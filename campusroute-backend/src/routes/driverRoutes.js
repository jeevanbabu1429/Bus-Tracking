const express = require('express');
const router = express.Router();
const driverController = require('../controllers/driverController');
const { requireRole } = require('../middleware/authMiddleware');

router.use(requireRole('COLLEGE_ADMIN'));

router.post('/add', driverController.addDriver);
router.get('/list', driverController.listDrivers);

module.exports = router;
