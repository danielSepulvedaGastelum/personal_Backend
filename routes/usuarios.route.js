import { Router } from "express";
import { usuariosController } from "../controllers/usuarios.controller.js";
import { verifyToken } from "../middlewares/jwt.middleware.js";


const router = Router();

// api/v1/usuarios

router.put('/cambioPasswordInicial', usuariosController.cambioPasswordInicial);
router.put('/cambioPassword',verifyToken, usuariosController.cambioPassword);
router.post('/login', usuariosController.login);
router.get('/sideBarMenu', verifyToken, usuariosController.generarMenuPorMatricula);




export default router;