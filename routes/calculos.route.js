import { Router } from "express";
import { calculosController } from "../controllers/calculos.controller.js";
import { verifyToken } from "../middlewares/jwt.middleware.js";

const router = Router();

//api/v1/calculos

router.get('/matricula', verifyToken, calculosController.buscaMaricula);



export default router;