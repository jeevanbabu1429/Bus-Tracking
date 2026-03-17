const express = require('express');
const router = express.Router();
const busController = require('../controllers/busController');
const { requireRole } = require('../middleware/authMiddleware');

router.use(requireRole('COLLEGE_ADMIN'));

router.post('/add', busController.addBus);
router.get('/list', busController.listBuses);
router.post('/assign-driver', busController.assignDriver);

module.exports = router;
