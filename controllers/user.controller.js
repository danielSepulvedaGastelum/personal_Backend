import {userModel} from '../models/user.model.js';

//  /api/v1/users/register
const register = async (req, res) => {
    try{
        console.log(req.body);
        // const { username, email, password } = req.body;

        return res.json({ok: true, msg: 'user ok'})
    } catch(error){
        console.log(error);
        return res.status(500).json({
            ok: false,
            msg: 'Error Server'
        });
    }
}


//  /api/v1/users/login
const login = async (req, res) => {
    try{

    } catch(error){
        console.log(error);
        return res.status(500).json({
            ok: false,
            msg: 'Error Server'
        });
    }
}


export const userController = {
    register,
    login
}