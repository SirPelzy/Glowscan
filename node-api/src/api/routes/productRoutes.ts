import { Router } from 'express';
import { getProductRecommendations } from '../controllers/productController';
import { protect } from '../middlewares/authMiddleware';

const router = Router();

// All product routes should be protected
router.use(protect);

router.get('/recommendations', getProductRecommendations);

export default router;
