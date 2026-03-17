require('dotenv').config();
const http = require('http');
const { Server } = require('socket.io');
const connectDB = require('./config/db');
const app = require('./app');
const socketService = require('./services/socketService');

const PORT = process.env.PORT || 5000;

// Create HTTP server
const server = http.createServer(app);

// Initialize Socket.IO
const io = new Server(server, {
  cors: {
    origin: '*', // Adjust for production
    methods: ['GET', 'POST'],
  },
});

// Attach Socket.IO service
socketService(io);

// Connect to Database
connectDB();

// Start Server
server.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
