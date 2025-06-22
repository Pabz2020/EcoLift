const express = require('express');
const { 
    register, 
    login,
    updateCollectorLocation,
    getNearbyCollectors,
    getNearbyActiveCollectors
} = require('../controllers/userControllers');
const authenticate = require('../middlewares/authMiddleware');

const router = express.Router();

// Public routes
router.post('/register', register);
router.post('/login', login);

// Protected routes
router.get('/profile', authenticate, (req, res) => {
    res.json({ message: 'Profile data', user: req.user });
});

// Collector routes
router.patch('/collectors/location', authenticate, updateCollectorLocation);
router.get('/collectors/nearby', authenticate, getNearbyCollectors);
router.get('/collectors/active-nearby', authenticate, getNearbyActiveCollectors);

module.exports = router;