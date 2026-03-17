const mongoose = require('mongoose');

const busSchema = new mongoose.Schema(
  {
    college_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'College',
      required: true,
    },
    bus_number: {
      type: String,
      required: true,
    },
    vehicle_registration: {
      type: String,
    },
    capacity: {
      type: Number,
    },
    model_name: {
      type: String,
    },
    is_active: {
      type: Boolean,
      default: true,
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model('Bus', busSchema);
