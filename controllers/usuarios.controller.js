import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import { usuarioModel } from '../models/usuarios.model.js'
import { roles } from '../database/roles-perfiles.js'

const generarMenuPorMatricula = async (req, res) => {
    try {
        const { matricula } = req.body;
        if(!matricula ){
            return res
                    .status(400)
                    .json({ok: false, msg: 'Valor requerido: matricula'});
        }

        const resUsuario = await usuarioModel.existeUsuario(matricula);
        if(!resUsuario){
            return res
                .status(400)
                .json({ok: false, msg: 'No existe usuario con esa matricula'});
        }

        const { usuario_id, rol } = resUsuario;
        const rolNombre = rol.toUpperCase();
        const perfilesPermitidosRol = roles[rolNombre] || [];
        
        if (perfilesPermitidosRol.length === 0) {
            return res
                .status(400)
                .json({ok: false, msg: 'No tiene perfiles asignados segun el rol del usuario'});
        }

        const perfiles = await usuarioModel.UsuarioPerfilesAutorizadosPorRol(usuario_id, perfilesPermitidosRol);
        if(!perfiles){
            return res
                .status(400)
                .json({ok: false, msg: 'No existen perfiles asignados en la base de datos con respecto al rol del usuario'});
        }

        function construirArbol(perfiles, parentId = null) {

            return perfiles
                .filter(p => p.parent_id === parentId)
                .map(p => ({
                title: p.title,
                icon: p.icon,
                path: p.path,
                children: construirArbol(perfiles, p.pid)
                }));
            
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
    generarMenuPorMatricula
}

