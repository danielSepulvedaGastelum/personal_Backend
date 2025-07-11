import bcryptjs from 'bcryptjs';
import jwt from 'jsonwebtoken';
import {userModel} from '../models/user.model.js';

//  /api/v1/users/register
const register = async (req, res) => {
    try{
        console.log(req.body);
        const { username, email, password } = req.body;

        if(!username || !email || !password){
            return res.status(400).json({ok: false, msg: 'Missing required fields: email, password, username'});
        }

        const user = await userModel.findOneByemail(email);
        if(user){
            return res.status(400).json({ok: false, msg: 'Email already exists'});
        }

        const salt = await bcryptjs.genSalt(10);
        const hashedPassword = await bcryptjs.hash(password, salt);

        const newUser = await userModel.create({email, password: hashedPassword, username});

        const token = jwt.sign({
            email: newUser.email
            },
            process.env.JWT_SECRET,
            {
                expiresIn: '1h'
            }
        )


        return res.status(201).json({ok: true, msg: token})
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
        console.log(req.body);
        const { email, password } = req.body;

        console.log(email, password);


        if(!email || !password){
            return res
                .status(400)
                .json({ok: false, msg: 'Missing required fields: email, password'});
        }

        const user = await userModel.findOneByemail(email);
        if(!user){
            return res.status(404).json({ok: false, msg: 'Email does not exist'});
        }



        const isMatch = await bcryptjs.compare(password, user.password);
        
        if(!isMatch){
            return res.status(401).json({ok: false, msg: 'Invalid credencials'});
        }

        const token = jwt.sign({
            email: user.email
            },
            process.env.JWT_SECRET,
            {
                expiresIn: '1h'
            }
        )

        return res.status(200).json({ok: true, msg: token})

    } catch(error){
        console.log(error);
        return res.status(500).json({
            ok: false,
            msg: 'Error Server'
        });
    }
}

const profile = async (req, res) => {
    try{
        
        // req.email proviene desde el middleware de jwt
        const user = await userModel.findOneByemail(req.email);

        return res.status(200).json({ok: true, msg: user})
    } catch(error){
        console.log(error);
        return res.status(500).json({
            ok: false,
            msg: 'Error Server - Profile'
        });
    }
}


export const userController = {
    register,
    login,
    profile
}