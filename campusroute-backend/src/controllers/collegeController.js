const College = require('../models/College');
const User = require('../models/User');
const otpService = require('../services/otpService');

/**
 * Register a new college and its admin
 */
exports.registerCollege = async (req, res) => {
  try {
    const {
      college_name,
      college_code,
      college_type,
      affiliation,
      address,
      contact,
      admin,
    } = req.body;

    // 1. Validate required fields
    if (!college_name || !college_code || !college_type || !admin?.full_name || !admin?.mobile_number) {
      return res.status(400).json({
        success: false,
        message: 'Missing required fields (college_name, college_code, college_type, admin.full_name, admin.mobile_number)',
      });
    }

    // 2. Check if college_code already exists
    const existingCollege = await College.findOne({ college_code: college_code.toUpperCase() });
    if (existingCollege) {
      return res.status(400).json({
        success: false,
        message: 'College code already exists',
      });
    }

    // 3. Check if admin mobile_number already exists
    const existingUser = await User.findOne({ mobile_number: admin.mobile_number });
    if (existingUser) {
      return res.status(400).json({
        success: false,
        message: 'Admin mobile number already registered',
      });
    }

    // 4. Create College document
    const college = await College.create({
      college_name,
      college_code,
      college_type,
      affiliation,
      address,
      contact,
    });

    // 5. Create User document (Admin)
    const adminUser = await User.create({
      full_name: admin.full_name,
      mobile_number: admin.mobile_number,
      email: admin.email,
      designation: admin.designation,
      gender: admin.gender,
      role: 'COLLEGE_ADMIN',
      college_id: college._id,
    });

    // 6. Send OTP to admin
    await otpService.sendOtp(admin.mobile_number);

    // 7. Success Return
    res.status(201).json({
      success: true,
      message: 'College registered. OTP sent to admin mobile.',
      college_id: college._id,
      admin_id: adminUser._id,
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
};

/**
 * Get college details with admin info
 */
exports.getCollege = async (req, res) => {
  try {
    const college = await College.findById(req.params.id);
    if (!college) {
      return res.status(404).json({
        success: false,
        message: 'College not found',
      });
    }

    // Find admin for this college
    const admin = await User.findOne({ college_id: college._id, role: 'COLLEGE_ADMIN' });

    res.status(200).json({
      success: true,
      college,
      admin,
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
};
