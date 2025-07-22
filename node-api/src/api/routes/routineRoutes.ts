import { Router } from 'express';
import { protect } from '../middlewares/authMiddleware';
import {
    getUserRoutines,
    createRoutine,
    updateRoutine,
    deleteRoutine,
} from '../controllers/routineController';
import { body } from 'express-validator';
import { validateRequest } from '../middlewares/validationMiddleware';

const router = Router();

// All routine routes are protected
router.use(protect);

router.route('/')
    .get(getUserRoutines)
    .post(
        [
            body('name').notEmpty().withMessage('Routine name is required'),
        ],
        validateRequest,
        createRoutine
    );

router.route('/:id')
    .put(updateRoutine)
    .delete(deleteRoutine);

export default router;
