const Bus = require('../models/Bus');
const BusAssignment = require('../models/BusAssignment');

/**
 * Add a new bus
 */
exports.addBus = async (req, res) => {
  try {
    const { bus_number, vehicle_registration, capacity, model_name } = req.body;
    const college_id = req.user.collegeId;

    const bus = await Bus.create({
      college_id,
      bus_number,
      vehicle_registration,
      capacity,
      model_name,
    });

    res.status(201).json({ success: true, data: bus });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

/**
 * List all buses for a college
 */
exports.listBuses = async (req, res) => {
  try {
    const buses = await Bus.find({ college_id: req.user.collegeId });
    res.status(200).json({ success: true, data: buses });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

/**
 * Assign a driver to a bus
 */
exports.assignDriver = async (req, res) => {
  try {
    const { bus_id, driver_id } = req.body;

    // Set existing assignments to not current
    await BusAssignment.updateMany({ bus_id }, { is_current: false });

    // Create new assignment
    const assignment = await BusAssignment.create({
      bus_id,
      driver_id,
      is_current: true,
    });

    res.status(200).json({ success: true, message: 'Driver assigned successfully', data: assignment });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};
