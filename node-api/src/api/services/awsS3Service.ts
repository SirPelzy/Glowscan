import { S3Client, PutObjectCommand } from "@aws-sdk/client-s3";
import { v4 as uuidv4 } from 'uuid';

// Configure the S3 client
const s3Client = new S3Client({
    endpoint: process.env.AWS_S3_ENDPOINT, // Required for S3-compatible services
    region: process.env.AWS_REGION,
    credentials: {
        accessKeyId: process.env.AWS_ACCESS_KEY_ID!,
        secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY!,
    },
    forcePathStyle: true, // Required for many S3-compatible services
});


export const uploadImageToS3 = async (file: Express.Multer.File): Promise<string> => {
    const key = `uploads/${uuidv4()}-${file.originalname}`;

    const command = new PutObjectCommand({
        Bucket: process.env.AWS_S3_BUCKET_NAME,
        Key: key,
        Body: file.buffer,
        ContentType: file.mimetype,
        ACL: 'public-read', // Make the file publicly accessible
    });

    try {
        await s3Client.send(command);

        // Construct the URL. This may need adjustment based on the provider.
        // For Cloudflare R2, you'd use your public bucket URL.
        // For AWS S3, the format is https://<bucket-name>.s3.<region>.amazonaws.com/<key>
        const endpoint = new URL(process.env.AWS_S3_ENDPOINT!);
        const url = `https://${process.env.AWS_S3_BUCKET_NAME}.${endpoint.hostname}/${key}`;
        
        return url;
    } catch (error) {
        console.error("Error uploading to S3:", error);
        throw new Error("Failed to upload image.");
    }
};
