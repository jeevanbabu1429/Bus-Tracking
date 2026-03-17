const express = require('express');
const router = express.Router();
const collegeController = require('../controllers/collegeController');
const { verifyToken } = require('../middleware/authMiddleware');

router.get('/:id', collegeController.getCollege);

module.exports = router;
