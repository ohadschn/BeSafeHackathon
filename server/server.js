import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import rubberDuckRoutes from './routes/rubberDucks.js'; // Import the routes


dotenv.config();

const app = express();

app.use(express.json());

if (process.env.CLIENT_URL) {
  // Dev / cross-origin scenario
  app.use(cors({
    origin: process.env.CLIENT_URL
  }));
} else {
  // Prod / same-origin: do nothing, browser considers requests same-origin
}

app.use(express.static('public')); // Serve client in combined deployment
app.use('/images', express.static('images')); 
app.use('/ducks', rubberDuckRoutes);

// Start server
const PORT = process.env.PORT;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
