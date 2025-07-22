import { petModel } from "../models/pet.model.js";

const findAll = async (req, res) =>{
    try{
        // req.query extrae la imformación que viaja atravez de la URL
        // No se debe enviar datos delicados a travez de este parametro
        // Todo lo que se obtenga del req.query es un 'String'
        let { limit = 5 , page = 1 } = req.query;
        limit = +limit; // combierte el valor a numero
        page = +page;

        if( page < 1 || limit < 1 || limit > 100){
            return res.status(400).json({error: "Invalid Queries"});
        }

        const count = await petModel.count();
        const pets = await petModel.findAll({limit, page});

        const baseUrl = `${req.protocol}://${req.get('host')}/api/v1/pets`;
        const baseUrlWithQueries = `${baseUrl}?limit=${limit}`

        const totalPages = Math.ceil(count / limit);
        const nextPage = page + 1 > totalPages ? null : `${baseUrlWithQueries}&page=${page + 1}`
        const prevPage = page - 1 < 1 ? null : `${baseUrlWithQueries}&page=${page - 1}`
        

        return res.status(200).json({
            pagination:{
                count,
                totalPages,
                prevPage,
                nextPage,
                currentPage: page,
                limit
            },
            pets
        });
    } catch(error){
        console.log(error);
        return res.status(500).json({
            ok: false,
            msg: 'Error Server'
        });
    }
}

export const petController = {
    findAll
}