const mongoose = require('mongoose');

const busAssignmentSchema = new mongoose.Schema(
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
    assigned_date: {
      type: Date,
      default: Date.now,
    },
    is_current: {
      type: Boolean,
      default: true,
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model('BusAssignment', busAssignmentSchema);
