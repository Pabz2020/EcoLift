const jwt = require('jsonwebtoken');
const User = require('../models/userModel');
const bcrypt = require('bcrypt'); // For hashing passwords


const register = async (req, res) => {
    const { 
        name, 
        phone, 
        email, 
        password, 
        role, 
        address, 
        location, 
        nicNumber, 
        vehicleInfo, 
        wasteTypes 
    } = req.body;

    try {
        // Validate role
        if (!['customer', 'collector'].includes(role)) {
            return res.status(400).json({ message: 'Invalid role specified' });
        }

        // Check if user already exists
        const userExists = await User.findOne({ email });
        if (userExists) {
            return res.status(400).json({ message: 'User already exists' });
        }

        // Validate required fields based on role
        if (role === 'customer' && !address) {
            return res.status(400).json({ message: 'Address is required for customers' });
        }
        
        // Validate collector-specific fields
        if (role === 'collector') {
            if (!nicNumber) {
                return res.status(400).json({ message: 'NIC number is required for collectors' });
            }
            if (!vehicleInfo?.type || !vehicleInfo?.number || !vehicleInfo?.capacity) {
                return res.status(400).json({ 
                    message: 'Vehicle information (type, number, and capacity) is required for collectors' 
                });
            }
            if (!wasteTypes || !Array.isArray(wasteTypes) || wasteTypes.length === 0) {
                return res.status(400).json({ 
                    message: 'At least one waste type must be specified for collectors' 
                });
            }
        }

        // Hash password
        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password, salt);

        // Create base user data
        const userData = {
            name,
            phone,
            email,
            password: hashedPassword,
            role
        };

        // Add role-specific data
        if (role === 'customer') {
            userData.address = address;
        } else if (role === 'collector') {
            userData.nicNumber = nicNumber;
            userData.vehicleInfo = vehicleInfo;
            userData.wasteTypes = wasteTypes;
        }

        // Add location if provided
        if (location) {
            userData.location = location;
        }

        const user = await User.create(userData);

        res.status(201).json({
            message: 'User registered successfully',
            user: {
                id: user._id,
                name: user.name,
                email: user.email,
                role: user.role
            }
        });
    } catch (error) {
        res.status(500).json({ message: 'Server error', error: error.message });
    }
};

const login = async (req, res) => {
    const { email, password } = req.body;

    try {
        const user = await User.findOne({ email });
        if (!user) return res.status(401).json({ message: 'Invalid credentials' });

        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) return res.status(401).json({ message: 'Invalid credentials' });

        // Generate JWT with role information
        const token = jwt.sign(
            { 
                userId: user._id.toString(), // Ensure ObjectId is converted to string
                role: user.role
            },
            process.env.JWT_SECRET,
            { expiresIn: process.env.JWT_EXPIRES_IN }
        );

        // Return role-specific data
        const responseData = {
            id: user._id,
            name: user.name,
            email: user.email,
            phone: user.phone,
            role: user.role
        };

        if (user.role === 'customer') {
            responseData.address = user.address;
        } else {
            responseData.location = user.location;
            responseData.nicNumber = user.nicNumber;
            responseData.vehicleInfo = user.vehicleInfo;
            responseData.wasteTypes = user.wasteTypes;
        }

        res.json({
            message: 'User logged in successfully',
            token,
            user: responseData
        });
    } catch (error) {
        res.status(500).json({ message: 'Server error', error: error.message });
    }
};

const updateCollectorLocation = async (req, res) => {
    try {
        if (req.user.role !== 'collector') {
            return res.status(403).json({ message: 'Only collectors can update locations' });
        }

        const user = await User.findByIdAndUpdate(
            req.user.id,
            { 
                location: {
                    type: 'Point',
                    coordinates: req.body.coordinates
                }
            },
            { new: true, runValidators: true }
        );
        
        res.status(200).json({
            message: 'Location updated successfully',
            user: {
                id: user._id,
                location: user.location
            }
        });
    } catch (error) {
        res.status(400).json({ message: 'Error updating location', error: error.message });
    }
};

const getNearbyCollectors = async (req, res) => {
    try {
        const coordinates = req.query.coordinates.map(Number);
        const maxDistance = req.query.maxDistance || 5000;

        const collectors = await User.find({
            role: 'collector',
            location: {
                $near: {
                    $geometry: {
                        type: "Point",
                        coordinates
                    },
                    $maxDistance: maxDistance
                }
            }
        }).select('-password -__v');

        res.status(200).json({
            message: 'Nearby collectors found',
            count: collectors.length,
            collectors
        });
    } catch (error) {
        res.status(400).json({ message: 'Error finding collectors', error: error.message });
    }
};




module.exports = { register, login, updateCollectorLocation, getNearbyCollectors };
