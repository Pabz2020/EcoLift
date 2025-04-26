const mongoose = require('mongoose');
const schema = mongoose.Schema;
const userSchema = new schema({
    email : {
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
    }
}, { timestamps: true });

userSchema.index({ location: '2dsphere' });

module.exports = mongoose.model('User', userSchema);