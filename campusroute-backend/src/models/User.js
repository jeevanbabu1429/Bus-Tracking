const mongoose = require('mongoose');

const userSchema = new mongoose.Schema(
  {
    full_name: {
      type: String,
      required: true,
    },
    mobile_number: {
      type: String,
      required: true,
      unique: true,
    },
    alternate_mobile: {
      type: String,
    },
    email: {
      type: String,
    },
    designation: {
      type: String,
      enum: ['Principal', 'Vice Principal', 'Transport Manager'],
    },
    gender: {
      type: String,
      enum: ['Male', 'Female', 'Other'],
    },
    profile_photo_url: {
      type: String,
    },
    role: {
      type: String,
      enum: ['COLLEGE_ADMIN', 'DRIVER', 'STUDENT'],
      required: true,
    },
    college_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'College',
      required: true,
    },
    is_active: {
      type: Boolean,
      default: true,
    },
    last_login: {
      type: Date,
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model('User', userSchema);
