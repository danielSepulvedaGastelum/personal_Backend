import {db} from '../database/connection_database.js'

const findOneByMatricula = async(matricula) => {
    const query = {
        text: `
            SELECT *
            FROM CALCULOS_CATALOGO_EMPLEADOS
            WHERE matricula = $1
        `,
        values: [matricula]
    };

    const { rows } = await db.query(query);

    return rows[0];
}

export const calculosModel = {
    findOneByMatricula
};