const mongoose = require('mongoose');
const schema = mongoose.Schema;
const userSchema = new schema({
    name: {
        type: String,
        required: true,
    },
    phone: {
        type: String,
        required: true,
        unique: true,
    },
    email: {
        type: String,
        required: true,
        unique: true,
    },
    password: {
        type: String,
        required: true,
    },
    role: {
        type: String,
        enum: ['customer', 'collector'],
        required: true,
    },
    address: {
        addressNo: { type: String },
        street: { type: String },
        city: { type: String },
        district: { type: String },
    },
    location: {
        type: {
            type: String,
            enum: ['Point'],
            default: 'Point'
        },
        coordinates: {
            type: [Number],
            validate: {
                validator: function(v) {
                    return v.length === 2 && 
                        v[0] >= -180 && v[0] <= 180 &&
                        v[1] >= -90 && v[1] <= 90;
                },
                message: 'Invalid coordinates format [longitude, latitude]'
            }
        }
    },
    vehicleType: {
        type: String,
        required: function() {
            return this.role === 'collector';
        }
    },
    wasteTypes: {
        type: [String],
        required: function() {
            return this.role === 'collector';
        },
        validate: {
            validator: function(v) {
                return this.role !== 'collector' || (v && v.length > 0);
            },
            message: 'At least one waste type must be selected for collectors'
        }
    }
}, { timestamps: true });

userSchema.index({ location: '2dsphere' });

module.exports = mongoose.model('User', userSchema);