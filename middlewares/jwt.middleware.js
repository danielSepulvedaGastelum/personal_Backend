import jwt from 'jsonwebtoken'

export const verifyToken = (req, res, next) => {

    let token = req.headers.authorization;

    if(!token){
        return res.status(401).json({error: 'Token not Provided'});
    }

    // Se pone el split porque el token viene con un formato: "Bearer @@@@@6♦@@@@321d6ds@sa$%%"
    token = token.split(' ')[1];

    try{
        const { email } = jwt.verify(token, process.env.JWT_SECRET);

        req.email = email;

        next()
    } catch(error){
        console.log(error);
        return res.status(400).json({error: 'Invalid Token'});
    }
}