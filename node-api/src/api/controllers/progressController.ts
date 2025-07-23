import { Request, Response } from 'express';
import { PrismaClient, User } from '@prisma/client';
import { uploadImageToS3 } from '../services/awsS3Service';
import { analyzeImageWithAI } from '../services/aiAnalysisService';

const prisma = new PrismaClient();

// The main endpoint to upload a selfie and track progress
export const trackProgress = async (req: Request, res: Response) => {
    const user = req.user as User;

    if (!req.file) {
        return res.status(400).json({ message: 'No image file uploaded.' });
    }

    try {
        // Step 1: Upload image to S3-compatible storage
        const imageUrl = await uploadImageToS3(req.file);

        // Step 2: Send image to AI microservice for analysis
        const analysisResult = await analyzeImageWithAI(req.file);

        // Step 3: Save the results to the database
        const progressRecord = await prisma.progress.create({
            data: {
                userId: user.id,
                imageUrl: imageUrl,
                analysis: analysisResult, // analysisResult is already a JSON object
            },
        });

        res.status(201).json(progressRecord);
    } catch (error: any) {
        res.status(500).json({ message: 'Failed to track progress', error: error.message });
    }
};

// Endpoint to get all progress data for trend graphs
export const getProgressTrends = async (req: Request, res: Response) => {
    const user = req.user as User;
    try {
        const trends = await prisma.progress.findMany({
            where: { userId: user.id },
            orderBy: { date: 'asc' },
        });
        res.status(200).json(trends);
    } catch (error: any) {
        res.status(500).json({ message: 'Failed to retrieve progress trends', error: error.message });
    }
};
