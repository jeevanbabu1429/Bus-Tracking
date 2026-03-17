const User = require('../models/User');
const StudentBusAssignment = require('../models/StudentBusAssignment');

/**
 * Add a new student
 */
exports.addStudent = async (req, res) => {
  try {
    const { full_name, mobile_number, gender, bus_id } = req.body;
    const college_id = req.user.collegeId;

    // Check if student already exists
    const existingUser = await User.findOne({ mobile_number });
    if (existingUser) {
      return res.status(400).json({ success: false, message: 'Mobile number already registered' });
    }

    // Create User (Student)
    const student = await User.create({
      full_name,
      mobile_number,
      gender,
      role: 'STUDENT',
      college_id,
    });

    // Create Assignment
    await StudentBusAssignment.create({
      student_id: student._id,
      bus_id,
      college_id,
    });

    res.status(201).json({ success: true, data: student });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

/**
 * List all students for a college with their assigned bus
 */
exports.listStudents = async (req, res) => {
  try {
    const students = await User.find({ college_id: req.user.collegeId, role: 'STUDENT' });
    
    // Enrich with bus info
    const enrichedStudents = await Promise.all(students.map(async (student) => {
      const assignment = await StudentBusAssignment.findOne({ student_id: student._id }).populate('bus_id', 'bus_number');
      return {
        ...student._doc,
        assigned_bus: assignment ? assignment.bus_id : null,
      };
    }));

    res.status(200).json({ success: true, data: enrichedStudents });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};
