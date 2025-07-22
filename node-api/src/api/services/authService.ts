import { PrismaClient, User } from '@prisma/client';
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';

const prisma = new PrismaClient();
const SALT_ROUNDS = 10;

export const registerUser = async (data: any) => {
  const { email, password, firstName, lastName } = data;
  const hashedPassword = await bcrypt.hash(password, SALT_ROUNDS);
  const user = await prisma.user.create({
    data: {
      email,
      password: hashedPassword,
      firstName,
      lastName,
    },
  });
  return user;
};

export const generateJwtToken = (user: User) => {
  const payload = {
    id: user.id,
    email: user.email,
    role: user.role,
    subscription: user.subscriptionStatus,
  };
  return jwt.sign(payload, process.env.JWT_SECRET || 'your_default_secret', {
    expiresIn: process.env.JWT_EXPIRES_IN || '1d',
  });
};
