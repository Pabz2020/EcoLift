require('dotenv').config() // Load the dotenv library to read the .env file
const express = require('express'); // Import express library
const mongoose = require('mongoose'); // Import mongoose library
const app = express(); // Create a new express application
const userRoutes = require('./routes/userRoutes'); // Import routes
const cors = require('cors'); // Import CORS library

app.use(cors()); // Use CORS to allow requests from different origins


// middleware
app.use(express.json());

app.use((req,res,next)=>{
    console.log(req.path);
    console.log(req.headers);
    next();
})

app.use('/api/users', userRoutes);

mongoose.connect(process.env.MONGO_URI)
.then(()=>{

    const port = process.env.PORT 

    // Define a route for the root of the app
    app.listen(port, () => {
        console.log(`User Service running on port ${port} and connected to user database successfully!`)
    })
})
.catch((err)=>{
    
    console.log(err)
})



