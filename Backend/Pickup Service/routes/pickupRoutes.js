const express = require('express');
const { createPickupRequest, getPendingRequests, acceptPickupRequest } = require('../controllers/pickupController');
const authenticateMiddleware = require("../middlewares/authMiddleware");
const router = express.Router();

router.use(authenticateMiddleware);    

router.post('/', createPickupRequest);
router.get('/pending', getPendingRequests);
router.post('/accept', acceptPickupRequest);

module.exports = router;
