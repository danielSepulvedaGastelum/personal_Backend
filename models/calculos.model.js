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

const searchByNombre = async(nombre) => {
    const clean = nombre.trim();

    // Caso 1: 1 o 2 letras -> usar ILIKE
    if (clean.length < 3 && !clean.includes(" ")) {
        const query = {
            text: `
                SELECT matricula, nombre, tc , status
                FROM CALCULOS_CATALOGO_EMPLEADOS
                WHERE nombre ILIKE $1
                LIMIT 50
            `,
            values: [`%${clean}`]
        };
        const { rows } = await db.query(query);
        return rows;
    }

    // Caso 2 y 3: usar Full Text Search con prefijos
    // Si hay varias palabras, unirlas con "&" y ":*"
    const terms = clean
        .split(/\s+/)               // dividir por espacios
        .filter(Boolean)            // quitar vacíos
        .map(t => `${t}:*`)         // convertir a prefijo
        .join(" & ");               // AND entre palabras

    const query = {
        text: `
            SELECT matricula, nombre, tc , status
            FROM CALCULOS_CATALOGO_EMPLEADOS
            WHERE to_tsvector('spanish', nombre) @@ to_tsquery('spanish', $1)
            ORDER BY nombre
            LIMIT 50
        `,
        values: [terms]
    };

    const { rows } = await db.query(query);

    return rows;
}

export const calculosModel = {
    findOneByMatricula,
    searchByNombre
};