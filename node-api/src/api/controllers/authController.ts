import { Request, Response } from 'express';
import { PrismaClient } from '@prisma/client';
import passport from 'passport';
import { registerUser, generateJwtToken } from '../services/authService';

const prisma = new PrismaClient();

// Controller for Local Registration
export const register = async (req: Request, res: Response) => {
    try {
        const userExists = await prisma.user.findUnique({ where: { email: req.body.email } });
        if (userExists) {
            return res.status(409).json({ message: 'User with this email already exists' });
        }
        const user = await registerUser(req.body);
        const token = generateJwtToken(user);
        res.status(201).json({ token, user });
    } catch (error: any) {
        res.status(500).json({ message: 'Server error during registration', error: error.message });
    }
};

// Controller for Local Login
export const login = (req: Request, res: Response, next: any) => {
    passport.authenticate('local', { session: false }, (err: any, user: any, info: any) => {
        if (err || !user) {
            return res.status(400).json({ message: info.message || 'Login failed' });
        }
        const token = generateJwtToken(user);
        return res.json({ token, user });
    })(req, res, next);
};

// Generic handler for social login success
export const socialLoginSuccess = (req: Request, res: Response) => {
    if (!req.user) {
        return res.status(401).json({ message: "Authentication failed." });
    }
    const token = generateJwtToken(req.user as any);
    // In a real app, you'd redirect to the mobile app using a deep link
    // e.g., res.redirect(`glowscan://auth?token=${token}`);
    res.json({ token, user: req.user });
};
