const BusTripLog = require('../models/BusTripLog');

const socketService = (io) => {
  io.on('connection', (socket) => {
    console.log(`New connection: ${socket.id}`);

    // --- DRIVER EVENTS ---

    // Driver starts a trip
    socket.on('driver:start', async ({ driverId, busId }) => {
      try {
        const tripLog = await BusTripLog.create({
          bus_id: busId,
          driver_id: driverId,
          status: 'Active',
        });

        socket.join(`bus:${busId}`);
        socket.emit('trip:started', { tripId: tripLog._id, busId });
        console.log(`Trip started for bus ${busId} by driver ${driverId}`);
      } catch (error) {
        console.error('Error starting trip:', error.message);
      }
    });

    // Driver sends location updates
    socket.on('driver:location', ({ driverId, busId, latitude, longitude }) => {
      const locationData = {
        busId,
        latitude,
        longitude,
        timestamp: new Date(),
      };
      
      // Broadcast to all students in the bus room
      socket.to(`bus:${busId}`).emit('bus:location', locationData);
    });

    // Driver stops a trip
    socket.on('driver:stop', async ({ driverId, busId }) => {
      try {
        await BusTripLog.findOneAndUpdate(
          { bus_id: busId, driver_id: driverId, status: 'Active' },
          { status: 'Completed', end_time: new Date() },
          { sort: { createdAt: -1 } }
        );

        socket.leave(`bus:${busId}`);
        io.to(`bus:${busId}`).emit('trip:ended', { busId });
        console.log(`Trip ended for bus ${busId}`);
      } catch (error) {
        console.error('Error stopping trip:', error.message);
      }
    });

    // --- STUDENT EVENTS ---

    // Student joins a bus room to track it
    socket.on('student:join', ({ studentId, busId }) => {
      socket.join(`bus:${busId}`);
      socket.emit('joined:bus', { busId });
      console.log(`Student ${studentId} joined room for bus ${busId}`);
    });

    // Student leaves a bus room
    socket.on('student:leave', ({ studentId, busId }) => {
      socket.leave(`bus:${busId}`);
      console.log(`Student ${studentId} left room for bus ${busId}`);
    });

    socket.on('disconnect', () => {
      console.log(`Socket disconnected: ${socket.id}`);
    });
  });
};

module.exports = socketService;
