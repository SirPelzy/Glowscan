import { Request, Response } from 'express';

// Placeholder data - in a real app, this would come from the database
const mockProducts = [
    // Budget
    { id: 'prod_budget_1', name: 'Gentle Hydrating Cleanser', brand: 'The Ordinary', category: 'Cleanser', price: 7.50, segment: 'BUDGET', affiliateLink: 'https://example.com/aff/b1' },
    { id: 'prod_budget_2', name: 'Hyaluronic Acid 2% + B5', brand: 'The Ordinary', category: 'Serum', price: 6.80, segment: 'BUDGET', affiliateLink: 'https://example.com/aff/b2' },
    { id: 'prod_budget_3', name: 'Daily Moisturizing Lotion', brand: 'CeraVe', category: 'Moisturizer', price: 12.00, segment: 'BUDGET', affiliateLink: 'https://example.com/aff/b3' },
    // Luxury
    { id: 'prod_luxury_1', name: 'T.L.C. Framboos™ Glycolic Night Serum', brand: 'Drunk Elephant', category: 'Serum', price: 90.00, segment: 'LUXURY', affiliateLink: 'https://example.com/aff/l1' },
    { id: 'prod_luxury_2', name: 'Crème de la Mer', brand: 'La Mer', category: 'Moisturizer', price: 190.00, segment: 'LUXURY', affiliateLink: 'https://example.com/aff/l2' },
    { id: 'prod_luxury_3', name: 'Facial Treatment Essence', brand: 'SK-II', category: 'Essence', price: 99.00, segment: 'LUXURY', affiliateLink: 'https://example.com/aff/l3' },
];


export const getProductRecommendations = (req: Request, res: Response) => {
    // Optional: Add logic here to personalize recommendations based on user's skin analysis
    res.status(200).json({
        budget: mockProducts.filter(p => p.segment === 'BUDGET'),
        luxury: mockProducts.filter(p => p.segment === 'LUXURY'),
    });
};
