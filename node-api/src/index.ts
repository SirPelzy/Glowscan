import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import passport from 'passport';

import authRoutes from './api/routes/authRoutes';
import userRoutes from './api/routes/userRoutes';
import routineRoutes from './api/routes/routineRoutes';
import productRoutes from './api/routes/productRoutes';
import progressRoutes from './api/routes/progressRoutes';

dotenv.config();

const app = express();
const port = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(passport.initialize());

// API Routes
app.use('/api/auth', authRoutes);
app.use('/api/users', userRoutes);
app.use('/api/routines', routineRoutes);
app.use('/api/products', productRoutes);
app.use('/api/progress', progressRoutes);

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
