const path = require('path');
const fs = require('fs');
const dotenv = require('dotenv');

// Print current directory and file existence
const envPath = path.join(__dirname, '.env');
console.log('Current directory:', __dirname);
console.log('Looking for .env at:', envPath);
console.log('.env file exists:', fs.existsSync(envPath));

// Try to read the file contents directly
try {
    const envConfig = fs.readFileSync(envPath, 'utf8');
    console.log('.env file contents:', envConfig);
} catch (err) {
    console.error('Error reading .env file:', err);
}

// Load environment variables
dotenv.config({ path: envPath });

// Print loaded environment variables
console.log('Environment variables loaded:', {
    MONGO_URI: process.env.MONGO_URI,
    PORT: process.env.PORT,
    JWT_SECRET: process.env.JWT_SECRET
});

const express = require('express'); // Import express library
const mongoose = require('mongoose'); // Import mongoose library
const app = express(); // Create a new express application
const userRoutes = require('./routes/userRoutes'); // Import routes
const cors = require('cors'); // Import CORS library

// Configure CORS for Flutter web
app.use(cors({
    origin: '*', // Allow all origins for development
    methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
    allowedHeaders: ['Content-Type', 'Accept', 'Authorization'],
    credentials: true
}));

// middleware
app.use(express.json());

app.use((req,res,next)=>{
    console.log(req.path);
    console.log(req.headers);
    next();
})

// Add OPTIONS handling for preflight requests
app.options('*', cors());

app.use('/api/users', userRoutes);

mongoose.connect(process.env.MONGO_URI)
.then(()=>{
    const port = process.env.PORT || 4000;
    app.listen(port, () => {
        console.log(`User Service running on port ${port} and connected to user database successfully!`)
    })
})
.catch((err)=>{
    console.log('MongoDB connection error:', err)
})



