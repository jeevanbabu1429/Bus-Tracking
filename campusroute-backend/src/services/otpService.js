const OtpLog = require('../models/OtpLog');

/**
 * Generates a random 6-digit OTP string
 */
const generateOtp = () => {
  return Math.floor(100000 + Math.random() * 900000).toString();
};

/**
 * Generates and saves an OTP, then logs it (simulating SMS)
 * @param {string} mobile_number 
 */
const sendOtp = async (mobile_number) => {
  const otp_code = generateOtp();
  const expires_at = new Date(Date.now() + 5 * 60 * 1000); // 5 minutes from now

  await OtpLog.create({
    mobile_number,
    otp_code,
    expires_at,
  });

  // Log for now (replacing SMS gateway)
  console.log(`[OTP] Sent to ${mobile_number}: ${otp_code}`);
  
  return otp_code;
};

/**
 * Verifies the latest unused OTP for a mobile number
 * @param {string} mobile_number 
 * @param {string} otp_code 
 */
const verifyOtp = async (mobile_number, otp_code) => {
  const latestOtp = await OtpLog.findOne({
    mobile_number,
    is_used: false,
    expires_at: { $gt: new Date() }
  }).sort({ createdAt: -1 });

  if (!latestOtp || latestOtp.otp_code !== otp_code) {
    throw new Error('Invalid or expired OTP');
  }

  latestOtp.is_used = true;
  await latestOtp.save();

  return true;
};

module.exports = {
  generateOtp,
  sendOtp,
  verifyOtp
};
