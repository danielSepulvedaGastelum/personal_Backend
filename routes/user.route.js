import {Router} from 'express';
import { userController } from '../controllers/user.controller.js';
import { verifyToken } from '../middlewares/jwt.middleware.js';

const router = Router();

router.post('/register', userController.register);
router.post('/login', userController.login);

//  Ruta protegida, primero pasa por la verificación del token en el middleware: verifyToken
//  Si para esa verificación con el next() procesa el controlador del: profile
router.get('/profile', verifyToken, userController.profile);



export default router;