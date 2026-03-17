const mongoose = require('mongoose');

const studentBusAssignmentSchema = new mongoose.Schema(
  {
    student_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'User',
      required: true,
    },
    bus_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Bus',
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
  },
  { timestamps: true }
);

module.exports = mongoose.model('StudentBusAssignment', studentBusAssignmentSchema);
