import {Router} from 'express';
import { userController } from '../controllers/user.controller.js';
import { verifyToken, verifyAdmin } from '../middlewares/jwt.middleware.js';

const router = Router();

// api/v1/users

router.post('/register', userController.register);
router.post('/login', userController.login);

//  Ruta protegida, primero pasa por la verificación del token en el middleware: verifyToken
//  Si para esa verificación con el next() procesa el controlador del: profile
router.get('/profile', verifyToken, userController.profile);

// Admin
router.get('/', verifyToken, verifyAdmin,  userController.findAll);
router.put('/update-role-vet/:uid', verifyToken, verifyAdmin, userController.updateRoleVet);



export default router;