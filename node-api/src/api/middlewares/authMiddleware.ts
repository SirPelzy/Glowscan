import { Request, Response, NextFunction } from 'express';
import passport from 'passport';
import { User, Role, SubscriptionStatus } from '@prisma/client';

// This is the primary middleware to protect routes
export const protect = (req: Request, res: Response, next: NextFunction) => {
    passport.authenticate('jwt', { session: false }, (err: any, user: User, info: any) => {
        if (err || !user) {
            return res.status(401).json({ message: 'Unauthorized: No token provided or token is invalid' });
        }
        req.user = user;
        return next();
    })(req, res, next);
};


// RBAC Middleware: Checks for a specific role
export const restrictTo = (...roles: Role[]) => {
    return (req: Request, res: Response, next: NextFunction) => {
        const user = req.user as User;
        if (!user || !roles.includes(user.role)) {
            return res.status(403).json({ 
                message: 'Forbidden: You do not have permission to perform this action' 
            });
        }
        next();
    };
};

// Subscription Middleware: Checks for premium status
export const requirePremium = (req: Request, res: Response, next: NextFunction) => {
    const user = req.user as User;
    if (!user || user.subscriptionStatus !== SubscriptionStatus.PREMIUM) {
        return res.status(403).json({
            message: 'Forbidden: This feature requires a premium subscription.'
        });
    }
    next();
};
