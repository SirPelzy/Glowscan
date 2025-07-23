import axios from 'axios';
import FormData from 'form-data';

const AI_SERVICE_URL = process.env.AI_SERVICE_URL || 'http://localhost:8000';

export interface SkinAnalysisResult {
    wrinkles: number;
    pores: number;
    hydration: number;
    analysis_status: string;
}

export const analyzeImageWithAI = async (file: Express.Multer.File): Promise<SkinAnalysisResult> => {
    const form = new FormData();
    form.append('file', file.buffer, {
        filename: file.originalname,
        contentType: file.mimetype,
    });

    try {
        const response = await axios.post<SkinAnalysisResult>(
            `${AI_SERVICE_URL}/analyze`,
            form,
            {
                headers: {
                    ...form.getHeaders(),
                },
            }
        );
        return response.data;
    } catch (error: any) {
        console.error("Error calling AI analysis service:", error.response?.data || error.message);
        if (error.response) {
            // Forward the error from the AI service if available
            throw new Error(error.response.data.detail || 'AI service failed to process the image.');
        }
        throw new Error('Failed to connect to the AI analysis service.');
    }
};
