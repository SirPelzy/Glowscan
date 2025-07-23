import { Router } from 'express';
import { protect, requirePremium } from '../middlewares/authMiddleware';
import { trackProgress, getProgressTrends } from '../controllers/progressController';
import multer from 'multer';

const router = Router();
const upload = multer({ storage: multer.memoryStorage() });

// All progress routes require a logged-in user
router.use(protect);

// The core AI analysis feature requires a premium subscription
router.post('/track', requirePremium, upload.single('skinImage'), trackProgress);

router.get('/trends', getProgressTrends);

export default router;
