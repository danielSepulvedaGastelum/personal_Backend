import {db} from '../database/connection_database.js'

const existeUsuario = async(matricula) =>{
    const query = {
        text: `
            SELECT u.matricula AS usuario_id, r.rid AS rol
            FROM USUARIOS u
            JOIN ROLES r ON u.role_id = r.rid
            WHERE u.matricula = $1
        `,
        values:[matricula]
    }

    const { rows } = await db.query(query);

    return rows[0];
}


const UsuarioPerfilesAutorizadosPorRol = async(matricula, perfilesPermitidosPorRol) =>{
    const query = {
        text:`
            SELECT p.pid, p.title, p.icon, p.path, p.parent_id
            FROM USUARIO_PERFILES up
            JOIN PERFILES p ON up.pid = p.pid
            WHERE up.matricula = $1 AND p.pid = ANY($2::text[])
        `,
        values: [matricula, perfilesPermitidosPorRol]
    }

    const { rows } = await db.query(query);

    return rows;
}

export const usuarioModel = {
    existeUsuario,
    UsuarioPerfilesAutorizadosPorRol

}