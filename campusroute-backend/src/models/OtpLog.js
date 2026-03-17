const mongoose = require('mongoose');

const otpLogSchema = new mongoose.Schema(
  {
    mobile_number: {
      type: String,
      required: true,
    },
    otp_code: {
      type: String,
      required: true,
    },
    expires_at: {
      type: Date,
      required: true,
    },
    is_used: {
      type: Boolean,
      default: false,
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model('OtpLog', otpLogSchema);
