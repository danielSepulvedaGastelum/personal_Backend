import { Router } from "express";
import { petController } from "../controllers/pet.controller.js";


const router = Router();

// /api/v1/pets
router.get('/', petController.findAll);

export default router;