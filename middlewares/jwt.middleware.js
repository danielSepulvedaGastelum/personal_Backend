import jwt from 'jsonwebtoken'

export const verifyToken = (req, res, next) => {

    let token = req.headers.authorization;

    if(!token){
        return res.status(401).json({ok: false, msg: 'Token no proveío'});
    }

    // Se pone el split porque el token viene con un formato: "Bearer @@@@@6♦@@@@321d6ds@sa$%%"
    token = token.split(' ')[1];

    try{
        const { matricula, role_id } = jwt.verify(token, process.env.JWT_SECRET);

        // Al crear estas propiedades en el 'req' se pasan a la siguiente función o middleware
        req.matricula = matricula;
        req.role_id = role_id;

        next(); 
    } catch(error){
        console.log('Error Token Invalido: ',error);
        return res.status(401).json({ok: false, msg: 'Token invalido'});
    }
}

export const verifyAdmin = (req, res, next) =>{
    // console.log(req);
    if(req.role_id === 1){
        return next();
    }

    res.status(403).json({ok: false, msg: 'Unauthorized only Admin user'});
}

export const verifyVet = (req, res, next) => {
    if(req.role_id === 2 || req.role_id === 1){
        return next();
    }

    res.status(403).json({ok: false, msg: 'Unauthorized only Vet user'});
}