const mongoose = require('mongoose');

const busTripLogSchema = new mongoose.Schema(
  {
    bus_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Bus',
      required: true,
    },
    driver_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'User',
      required: true,
    },
    start_time: {
      type: Date,
      default: Date.now,
    },
    end_time: {
      type: Date,
    },
    status: {
      type: String,
      enum: ['Active', 'Completed'],
      default: 'Active',
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model('BusTripLog', busTripLogSchema);
