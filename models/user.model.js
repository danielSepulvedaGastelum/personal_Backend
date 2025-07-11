import {db} from '../database/connection_database.js';

const create = async({email, password, username}) => {
    const query = {
        text: `
        INSERT INTO users (email, password, username)
        VALUES ($1, $2, $3)
        RETURNING email, username, uid
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

export const userModel = {
    create,
    findOneByemail
};