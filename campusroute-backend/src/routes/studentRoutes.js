const express = require('express');
const router = express.Router();
const studentController = require('../controllers/studentController');
const { requireRole } = require('../middleware/authMiddleware');

router.use(requireRole('COLLEGE_ADMIN'));

router.post('/add', studentController.addStudent);
router.get('/list', studentController.listStudents);

module.exports = router;
