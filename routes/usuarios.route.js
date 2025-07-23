import { Router } from "express";
import { usuariosController } from "../controllers/usuarios.controller.js";


const router = Router();

// api/v1/usuarios

router.get('/sideBarMenu', usuariosController.generarMenuPorMatricula);




export default router;