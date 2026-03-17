const User = require('../models/User');
const otpService = require('../services/otpService');

/**
 * Add a new driver
 */
exports.addDriver = async (req, res) => {
  try {
    const { full_name, mobile_number, alternate_mobile, gender } = req.body;
    const college_id = req.user.collegeId;

    // Check if driver already exists
    const existingUser = await User.findOne({ mobile_number });
    if (existingUser) {
      return res.status(400).json({ success: false, message: 'Mobile number already registered' });
    }

    const driver = await User.create({
      full_name,
      mobile_number,
      alternate_mobile,
      gender,
      role: 'DRIVER',
      college_id,
    });

    // Send OTP to driver
    await otpService.sendOtp(mobile_number);

    res.status(201).json({ success: true, data: driver });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

/**
 * List all drivers for a college
 */
exports.listDrivers = async (req, res) => {
  try {
    const drivers = await User.find({ college_id: req.user.collegeId, role: 'DRIVER' });
    res.status(200).json({ success: true, data: drivers });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};
