import {db} from '../database/connection_database.js'


const findOneByMatricula = async(matricula) => {
    const query = {
        text: `
            SELECT MATRICULA, NICKNAME, NOMBRE, APELLIDO1, APELLIDO2, EMAIL, UNIDAD_TRABAJO, SERVICIO, DEPARTAMENTO, OFICINA, SECCION, ROLE_ID
            FROM usuarios
            WHERE matricula = $1
        `,
        values: [matricula]
    };

    const { rows } = await db.query(query);

    return rows[0];
}

const findOneByMatriculaLogin = async(matricula) => {
    const query = {
        text: `
            SELECT MATRICULA, PASSWORD, ROLE_ID
            FROM usuarios
            WHERE matricula = $1
        `,
        values: [matricula]
    };

    const { rows } = await db.query(query);

    return rows[0];
}  

const cambioPassword = async({matricula, password}) =>{
    const query = {
        text: `
            UPDATE USUARIOS
            SET PASSWORD = $2,
            ULTIMO_CAMBIO_PASSWORD = CURRENT_TIMESTAMP
            WHERE MATRICULA = $1
            RETURNING MATRICULA
        `,
        values: [matricula, password]
    };
    const { rows } = await db.query(query).catch( e => console.log(e));
    return rows[0];
}

const existeUsuario = async(matricula) =>{
    const query = {
        text: `
            SELECT u.matricula, u.role_id, ur.menu_id, ur.nombre AS rol
            FROM usuarios u
            LEFT JOIN usuario_roles ur ON u.role_id = ur.rid
            WHERE u.matricula = $1
        `,
        values:[matricula]
    }

    const { rows } = await db.query(query);

    return rows[0];
}


const UsuarioPerfilesAutorizadosPorRol = async(menu_id, matricula) =>{
    const query = {
        text:`
            SELECT cp.cpid AS pid, cp.title, cp.icon, cp.path, um.parent_pid
            FROM usuario_perfiles up
            JOIN usuario_catalogo_perfiles cp ON up.pid = cp.cpid
            JOIN usuario_menus um ON cp.cpid = um.pid AND um.mid = $1
            WHERE up.matricula = $2
            ORDER BY um.orden ASC
        `,
        values: [menu_id, matricula]
    }

    const { rows } = await db.query(query);

    return rows;
}

export const usuarioModel = {
    findOneByMatricula,
    findOneByMatriculaLogin,
    cambioPassword,
    existeUsuario,
    UsuarioPerfilesAutorizadosPorRol

}