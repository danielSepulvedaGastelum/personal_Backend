import bcryptjs from "bcryptjs";
import jwt from "jsonwebtoken";
import { usuarioModel } from '../models/usuarios.model.js'

//  /api/v1/usuarios/cambioPassword
const cambioPasswordInicial = async (req, res) => {
    try{
        // req.body extrae la imformación que viaja atravez del cuerpo de la petición
        const { matricula, password } = req.body;

        if(!matricula || !password){
            return res.status(400).json({ok: false, msg: 'Necesitan completar todos los campos: matricula, password'});
        }

        const user = await usuarioModel.findOneByMatricula(matricula);
        if(!user){
            return res.status(400).json({ok: false, msg: 'Matricula no existe'});
        }

        const salt = await bcryptjs.genSalt(10);
        const hashedPassword = await bcryptjs.hash(password, salt);

        const usuarioModificado = await usuarioModel.cambioPassword({matricula, password: hashedPassword});
        if(!usuarioModificado){
            return res.status(400).json({ok: false, msg: 'Matricula no existente para cambio de Password'});
        }

        return res.status(201).json({ok: true, msg: 'Cambio de Contraseña Inicial correctamente, para empezar aplicación'});

    } catch(error){
        console.log(error);
        return res.status(500).json({
            ok: false,
            msg: 'Error Server'
        });
    }
}

const cambioPassword = async (req, res) => {
    try{
        // Dato Obtenido del Middleware al verificar el token
        const matricula = req.matricula;

        // req.body extrae la imformación que viaja atravez del cuerpo de la petición
        const {CurrentPassword, newPassword} = req.body;

        if(!CurrentPassword || !newPassword){
            return res.status(400).json({ok: false, msg: 'Necesitan completar todos los campos: matricula, password y Nuevo Password'});
        }

        const user = await usuarioModel.findOneByMatriculaLogin(matricula);
        if(!user){
            return res.status(400).json({ok: false, msg: 'Matricula no existe en base de datos'});
        }

        const isMatch = await bcryptjs.compare(CurrentPassword, user.password);
        if(!isMatch){
            return res.status(401).json({ok: false, msg: 'Contraseña actual incorrecta'});
        }

        if(CurrentPassword === newPassword){
            return res.status(401).json({ok: false, msg: 'Contraseña Nueva igual a la Actual'});
        }

        const salt = await bcryptjs.genSalt(10);
        const hashedPassword = await bcryptjs.hash(newPassword, salt);
        const usuarioModificado = await usuarioModel.cambioPassword({matricula, password: hashedPassword});
        if(!usuarioModificado){
            return res.status(400).json({ok: false, msg: 'Matricula no existente para cambio de Password'});
        }

        return res.status(201).json({ok: true, msg: 'Cambio de Contraseña realizado correctamente'});

    } catch(error){
        console.log(error);
        return res.status(500).json({
            ok: false,
            msg: 'Error Server'
        });
    }
}

//  /api/v1/usuarios/login
const login = async (req, res) => {
    try{
        const { matricula, password } = req.body;
        if(!matricula || !password){
            return res
                .status(400)
                .json({ok: false, msg: 'Necesitan completar todos los campos: matricula, password'});
        }

        const user = await usuarioModel.findOneByMatriculaLogin(matricula);
        if(!user){
            return res.status(404).json({ok: false, msg: 'Matricula no existe'});
        }

        const isMatch = await bcryptjs.compare(password, user.password);
        
        if(!isMatch){
            return res.status(401).json({ok: false, msg: 'credenciales invalidas'});
        }

        const token = jwt.sign({
            matricula: user.matricula,
            role_id: user.role_id
            },
            process.env.JWT_SECRET,
            {
                expiresIn: '1d'
            }
        )

        return res.status(200).json({
            ok: true, 
            msg: {
                token,
                role_id: user.role_id
            }
        })

    } catch(error){
        console.log(error);
        return res.status(500).json({
            ok: false,
            msg: 'Error Server'
        });
    }
}

//  /api/v1/usuarios/sideBarMenu
const generarMenuPorMatricula = async (req, res) => {
    try {
        // Dato Obtenido del Middleware al verificar el token
        const matricula = req.matricula;

        // Verificar si existe el usuario
        const resUsuario = await usuarioModel.existeUsuario(matricula);
        if(!resUsuario){
            return res
                .status(400)
                .json({ok: false, msg: 'No existe usuario con esa matricula'});
        }

        const { role_id, menu_id, rol } = resUsuario;
        if (!menu_id) {
            return res
                .status(400)
                .json({ok: false, msg: 'El rol del usuario no tiene un menú asignado'});
        }

        // Obtener los perfiles asignados al usuario que están dentro del menú correspondiente
        const perfiles = await usuarioModel.UsuarioPerfilesAutorizadosPorRol(menu_id,matricula);

        if (perfiles.length === 0) {
            return res.status(400).json({
                ok: false,
                msg: 'No existen perfiles asignados al usuario dentro del menú correspondiente'
            });
        }


        // Construcción del árbol de menú
        // console.log('perfiles: ',perfiles);
        function construirArbol(perfiles, parentId = null) {
            return perfiles
                .filter(p => p.parent_pid === parentId)
                .map(p => {
                const hijos = construirArbol(perfiles, p.pid);
                const nodo = {
                    title: p.title,
                    icon: p.icon
                };

                if (p.path !== null) {
                    nodo.path = p.path;
                }

                if (hijos.length > 0) {
                    nodo.children = hijos;
                }

                return nodo;
                });
        }

        const menuPorMatricula = construirArbol(perfiles);

        return res.status(200).json({ok: true, msg: menuPorMatricula})

    } catch(error){
        console.error(error);
        return res.status(500).json({
            ok: false,
            msg: 'Error en servidor para generar menu'
        });
    }
}


export const usuariosController = {
    login,
    cambioPasswordInicial,
    cambioPassword,
    generarMenuPorMatricula
}

