const mongoose = require('mongoose');

const collegeSchema = new mongoose.Schema(
  {
    college_name: {
      type: String,
      required: true,
    },
    college_code: {
      type: String,
      required: true,
      unique: true,
      uppercase: true,
    },
    college_type: {
      type: String,
      enum: ['Arts', 'Engineering', 'Medical', 'Polytechnic', 'Other'],
      required: true,
    },
    affiliation: {
      type: String,
    },
    address: {
      line1: String,
      line2: String,
      city: String,
      district: String,
      state: String,
      pincode: String,
    },
    contact: {
      phone: String,
      email: String,
      website: String,
    },
    logo_url: String,
    location: {
      latitude: Number,
      longitude: Number,
    },
    account_status: {
      type: String,
      enum: ['Active', 'Inactive', 'Suspended'],
      default: 'Active',
    },
    subscription_plan: {
      type: String,
      enum: ['Starter', 'Growth', 'Enterprise'],
      default: 'Starter',
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model('College', collegeSchema);
