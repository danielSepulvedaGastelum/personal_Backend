import { petModel } from "../models/pet.model.js";

const findAll = async (req, res) =>{
    try{
        // req.query extrae la imformación que viaja atravez de la URL
        // No se debe enviar datos delicados a travez de este parametro
        // Todo lo que se obtenga del req.query es un 'String'
        let { limit , page } = req.query;
        limit = +limit; // combierte el valor a numero
        page = +page;
        const count = await petModel.count();
        const pets = await petModel.findAll({limit, page});
        return res.status(200).json({pets, count});
    } catch(error){
        console.log(error);
        return res.status(500).json({
            ok: false,
            msg: 'Error Server'
        });
    }

    return res.json({ ok: 'pets'});
}

export const petController = {
    findAll
}