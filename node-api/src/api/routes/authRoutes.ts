import { Router } from 'express';
import passport from 'passport';
import { register, login, socialLoginSuccess } from '../controllers/authController';
import { body } from 'express-validator';
import { validateRequest } from '../middlewares/validationMiddleware'; // We will create this next

const router = Router();

// Local Auth
router.post(
    '/register',
    [
        body('email').isEmail().withMessage('Please enter a valid email'),
        body('password').isLength({ min: 6 }).withMessage('Password must be at least 6 characters long'),
        body('firstName').notEmpty().withMessage('First name is required'),
    ],
    validateRequest, // Middleware to handle validation errors
    register
);

router.post(
    '/login',
    [
        body('email').isEmail().withMessage('Please enter a valid email'),
        body('password').notEmpty().withMessage('Password is required'),
    ],
    validateRequest,
    login
);

// Facebook Auth
router.get('/facebook', passport.authenticate('facebook', { scope: ['email'] }));
router.get(
    '/facebook/callback',
    passport.authenticate('facebook', { session: false, failureRedirect: '/login' }),
    socialLoginSuccess
);

// LinkedIn Auth
router.get('/linkedin', passport.authenticate('linkedin', { state: 'SOME_STATE' }));
router.get(
    '/linkedin/callback',
    passport.authenticate('linkedin', { session: false, failureRedirect: '/login' }),
    socialLoginSuccess
);

// Apple Auth (placeholder)
// router.get('/apple', passport.authenticate('apple'));
// router.get(
//     '/apple/callback',
//     passport.authenticate('apple', { session: false, failureRedirect: '/login' }),
//     socialLoginSuccess
// );


export default router;
