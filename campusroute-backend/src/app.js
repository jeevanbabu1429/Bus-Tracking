const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const authRoutes = require('./routes/authRoutes');
const collegeRoutes = require('./routes/collegeRoutes');
const busRoutes = require('./routes/busRoutes');
const driverRoutes = require('./routes/driverRoutes');
const studentRoutes = require('./routes/studentRoutes');
const { verifyToken } = require('./middleware/authMiddleware');
const collegeController = require('./controllers/collegeController');

const app = express();

// Middleware
app.use(helmet());
app.use(cors());
app.use(express.json());

// Health Check Route
app.get('/api/health', (req, res) => {
  res.status(200).json({
    status: 'ok',
    message: 'CampusRoute API is running'
  });
});

// Auth Routes (Public)
app.use('/api/auth', authRoutes);

// College Registration (Public)
app.post('/api/college/register', collegeController.registerCollege);

// Global Authentication Middleware
app.use(verifyToken);

// Protected Routes
app.use('/api/college', collegeRoutes);
app.use('/api/bus', busRoutes);
app.use('/api/driver', driverRoutes);
app.use('/api/student', studentRoutes);

// Global Error Handler
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(err.status || 500).json({
    success: false,
    message: err.message || 'Internal Server Error'
  });
});

module.exports = app;
