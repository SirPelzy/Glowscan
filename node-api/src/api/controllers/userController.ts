import { Request, Response } from 'express';
import { PrismaClient, SubscriptionStatus } from '@prisma/client';

const prisma = new PrismaClient();

// Add this function to your existing userController.ts
export const paddleWebhook = async (req: Request, res: Response) => {
    const event = req.body;

    // IMPORTANT: In production, you MUST verify the webhook signature from Paddle
    // See Paddle documentation for details on signature verification.

    const alertName = event.alert_name;
    const userEmail = event.email;
    const paddleUserId = event.user_id;
    
    try {
        if (alertName === 'subscription_created' || alertName === 'subscription_payment_succeeded') {
            await prisma.user.update({
                where: { email: userEmail },
                data: {
                    subscriptionStatus: SubscriptionStatus.PREMIUM,
                    paddleCustomerId: paddleUserId,
                },
            });
        } else if (alertName === 'subscription_cancelled') {
            await prisma.user.update({
                where: { email: userEmail },
                data: {
                    subscriptionStatus: SubscriptionStatus.FREE,
                },
            });
        }
        res.status(200).send('Webhook received');
    } catch (error) {
        console.error('Error processing Paddle webhook:', error);
        res.status(500).send('Error processing webhook');
    }
};

// Then, add a new route in userRoutes.ts for the webhook
// router.post('/paddle-webhook', paddleWebhook);
