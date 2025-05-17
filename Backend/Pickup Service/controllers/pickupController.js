const { getIO } = require('../websocket');
const PickupRequest = require('../models/pickupRequestModel');
const axios = require('axios');
const { findNearbyActiveCollectors } = require('../services/redisService');

const createPickupRequest = async (req, res) => {
    try {
        const isInstant = !req.body.scheduledTime;
        const requestType = isInstant ? 'instant' : 'scheduled';

        const pickupData = {
            customerId: req.user.userId,
            location: req.body.location,
            items: req.body.items,
            requestType,
            ...(isInstant ? {} : { scheduledTime: req.body.scheduledTime })
        };

        const pickup = await PickupRequest.create(pickupData);

        if (isInstant) {
            // Get coordinates from the request
            const coordinates = req.body.location.coordinates;
            const [longitude, latitude] = coordinates;
            
            // Find active collectors using Redis (faster, real-time)
            const activeCollectorIds = await findNearbyActiveCollectors(longitude, latitude, 5);
            
            if (activeCollectorIds.length > 0) {
                // If we found active collectors in Redis, notify them directly
                const io = getIO();
                io.notifyCollectors({
                    type: 'NEW_INSTANT_REQUEST',
                    request: pickup.toJSON()
                }, activeCollectorIds);
                
                console.log(`Notified ${activeCollectorIds.length} active collectors about pickup request`);
            } else {
                // Fallback: If no active collectors in Redis, use the User Service API
                console.log('No active collectors found in Redis, falling back to User Service API');
                try {
                    const { data } = await axios.get(`${process.env.USER_SERVICE_URL}/api/users/collectors/nearby`, {
                        params: {
                            coordinates,
                            maxDistance: 5000
                        },
                        headers: {
                            Authorization: req.header('Authorization')
                        }
                    });

                    const io = getIO();
                    const collectorIds = data.collectors.map(c => c._id.toString());

                    io.notifyCollectors({
                        type: 'NEW_INSTANT_REQUEST',
                        request: pickup.toJSON()
                    }, collectorIds);
                } catch (apiError) {
                    console.error('Error calling User Service API:', apiError.message);
                }
            }
        }

        res.status(201).json({ message: 'Pickup request created', pickup });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Error creating pickup request', error: error.message });
    }
};

const getPendingRequests = async (req, res) => {
    try {
        const requests = await PickupRequest.find({ status: 'Pending' });
        res.json(requests);
    } catch (error) {
        res.status(500).json({ message: 'Error fetching requests', error: error.message });
    }
};

const acceptPickupRequest = async (req, res) => {
    const { requestId, collectorId } = req.body;

    try {
        const pickup = await PickupRequest.findById(requestId);

        if (!pickup || pickup.status !== 'Pending') {
            return res.status(400).json({ message: 'Pickup not available or already accepted' });
        }

        pickup.status = 'Accepted';
        pickup.collectorId = collectorId;
        await pickup.save();

        const io = getIO();
        io.notifyCustomer(pickup.customerId.toString(), {
            type: 'pickupRequestAccepted',
            data: pickup.toJSON()
        });

        res.json({ message: 'Pickup request accepted', pickup });
    } catch (error) {
        res.status(500).json({ message: 'Error accepting pickup request', error: error.message });
    }
};

module.exports = {
    createPickupRequest,
    getPendingRequests,
    acceptPickupRequest
};
