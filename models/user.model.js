import {db} from '../database/connection_database.js';

const create = async({email, password, username}) => {
    const query = {
        text: `
        INSERT INTO users (email, password, username)
        VALUES ($1, $2, $3)
        RETURNING email, username, uid, role_id
        `,
        values: [email, password, username]
    }

    const {rows} = await db.query(query);

    return rows[0];
}

const findOneByemail = async(email) => {
    const query = {
        text:`
        SELECT * FROM users
        WHERE EMAIL = $1
        `,
        values :[email]
    }

    const {rows} = await db.query(query);

    return rows[0];
}

const findAll = async() => {
    const query = {
        text:`
        SELECT * FROM users
        `,
    }

    const { rows } = await db.query(query);

    return rows;    
}

const findOneByUid = async(uid) => {
    const query = {
        text:`
        SELECT * FROM users
        WHERE UID = $1
        `,
        values :[uid]
    }

    const {rows} = await db.query(query);

    return rows[0];
}

const updateRoleVet = async(uid) => {
    const query = {
        text:`
        UPDATE USERS
        SET ROLE_ID = 2
        WHERE UID = $1
        RETURNING email, username, role_id
        `,
        values :[uid]
    }

    const {rows} = await db.query(query);

    return rows[0];
}

export const userModel = {
    create,
    findOneByemail,
    findAll,
    findOneByUid,
    updateRoleVet
};