const jwt = require('jsonwebtoken');

/**
 * Middleware to verify JWT token
 */
const verifyToken = async (req, res, next) => {
  let token;

  if (
    req.headers.authorization &&
    req.headers.authorization.startsWith('Bearer')
  ) {
    try {
      token = req.headers.authorization.split(' ')[1];
      const decoded = jwt.verify(token, process.env.JWT_SECRET);
      req.user = decoded;
      next();
    } catch (error) {
      console.error(error);
      return res.status(401).json({ success: false, message: 'Unauthorized' });
    }
  }

  if (!token) {
    return res.status(401).json({ success: false, message: 'Unauthorized' });
  }
};

/**
 * Middleware to require specific roles
 */
const requireRole = (...roles) => {
  return (req, res, next) => {
    if (!roles.includes(req.user.role)) {
      return res.status(403).json({
        success: false,
        message: 'Access denied',
      });
    }
    next();
  };
};

module.exports = { verifyToken, requireRole };
