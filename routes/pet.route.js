import { Router } from "express";
import { petController } from "../controllers/pet.controller.js";
import { verifyToken, verifyVet } from "../middlewares/jwt.middleware.js";


const router = Router();

// /api/v1/pets
router.get('/',verifyToken, verifyVet,  petController.findAll);

export default router;