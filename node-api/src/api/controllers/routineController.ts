import { Request, Response } from 'express';
import { PrismaClient, User } from '@prisma/client';

const prisma = new PrismaClient();

// Get all routines for the logged-in user
export const getUserRoutines = async (req: Request, res: Response) => {
    const user = req.user as User;
    try {
        const routines = await prisma.skincareRoutine.findMany({
            where: { userId: user.id },
        });
        res.status(200).json(routines);
    } catch (error: any) {
        res.status(500).json({ message: 'Failed to retrieve routines', error: error.message });
    }
};

// Create a new skincare routine
export const createRoutine = async (req: Request, res: Response) => {
    const user = req.user as User;
    const { name, description, products } = req.body;
    try {
        const newRoutine = await prisma.skincareRoutine.create({
            data: {
                name,
                description,
                products, // products can be a JSON object
                userId: user.id,
            },
        });
        res.status(201).json(newRoutine);
    } catch (error: any) {
        res.status(500).json({ message: 'Failed to create routine', error: error.message });
    }
};

// Update an existing skincare routine
export const updateRoutine = async (req: Request, res: Response) => {
    const { id } = req.params;
    const { name, description, products } = req.body;
    const user = req.user as User;

    try {
        // First, verify the routine belongs to the user
        const routine = await prisma.skincareRoutine.findUnique({ where: { id } });
        if (!routine || routine.userId !== user.id) {
            return res.status(403).json({ message: 'Forbidden: You cannot update this routine' });
        }

        const updatedRoutine = await prisma.skincareRoutine.update({
            where: { id },
            data: { name, description, products },
        });
        res.status(200).json(updatedRoutine);
    } catch (error: any) {
        res.status(500).json({ message: 'Failed to update routine', error: error.message });
    }
};

// Delete a skincare routine
export const deleteRoutine = async (req: Request, res: Response) => {
    const { id } = req.params;
    const user = req.user as User;

    try {
        // Verify the routine belongs to the user
        const routine = await prisma.skincareRoutine.findUnique({ where: { id } });
        if (!routine || routine.userId !== user.id) {
            return res.status(403).json({ message: 'Forbidden: You cannot delete this routine' });
        }

        await prisma.skincareRoutine.delete({
            where: { id },
        });
        res.status(204).send(); // 204 No Content
    } catch (error: any) {
        res.status(500).json({ message: 'Failed to delete routine', error: error.message });
    }
};
