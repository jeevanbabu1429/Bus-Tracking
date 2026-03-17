const jwt = require('jsonwebtoken');
const User = require('../models/User');
const otpService = require('../services/otpService');

/**
 * Controller for sending OTP
 */
exports.sendOtp = async (req, res) => {
  try {
    const { mobile_number } = req.body;

    // Validate mobile number (10 digits)
    if (!mobile_number || !/^\d{10}$/.test(mobile_number)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid mobile number. Must be 10 digits.',
      });
    }

    await otpService.sendOtp(mobile_number);

    res.status(200).json({
      success: true,
      message: 'OTP sent successfully',
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
};

/**
 * Controller for verifying OTP and issuing JWT
 */
exports.verifyOtp = async (req, res) => {
  try {
    const { mobile_number, otp_code } = req.body;

    if (!mobile_number || !otp_code) {
      return res.status(400).json({
        success: false,
        message: 'Mobile number and OTP code are required.',
      });
    }

    // Verify OTP
    await otpService.verifyOtp(mobile_number, otp_code);

    // Find User
    const user = await User.findOne({ mobile_number });

    if (!user) {
      return res.status(404).json({
        success: false,
        message: 'User not found with this mobile number.',
      });
    }

    // Update last login
    user.last_login = new Date();
    await user.save();

    // Generate JWT
    const token = jwt.sign(
      {
        userId: user._id,
        role: user.role,
        collegeId: user.college_id,
        mobile_number: user.mobile_number,
      },
      process.env.JWT_SECRET,
      { expiresIn: '7d' }
    );

    res.status(200).json({
      success: true,
      token,
      user: {
        id: user._id,
        full_name: user.full_name,
        role: user.role,
        college_id: user.college_id,
      },
    });
  } catch (error) {
    res.status(400).json({
      success: false,
      message: error.message,
    });
  }
};
