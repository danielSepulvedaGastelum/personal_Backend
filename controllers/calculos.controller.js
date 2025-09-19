import { calculosModel } from "../models/calculos.model.js";

const buscaMaricula = async ( req, res ) => {
    try{

        const { matricula } = req.query;

        if(!matricula ){
            return res.status(400).json({ok: false, msg: 'Necesitan completar todos los campos: matricula'});
        }

        const trabajador = await calculosModel.findOneByMatricula(matricula);
        if(!trabajador){
            return res.status(404).json({ok: false, msg: 'Matricula no existe'});
        }
        
        return res.status(201).json({ok: true, msg: "ok",  trabajador});
    } catch (error){
        console.log(error);
        return res.status(500).json({
            ok: false,
            msg: 'Error Server'
        });
    }
}

const buscaNombre = async ( req, res ) => {
    try{

        const { nombre } = req.query;

        if(!nombre ){
            return res.status(400).json({ok: false, msg: 'Necesitan digitar el nombre del trabajador'});
        }

        const trabajadores = await calculosModel.searchByNombre(nombre);
        if(!trabajadores){
            return res.status(404).json({ok: false, msg: 'Nombre no existe'});
        }
        
        return res.status(201).json({ok: true, msg: "ok",  trabajadores});
    } catch (error){
        console.log(error);
        return res.status(500).json({
            ok: false,
            msg: 'Error Server'
        });
    }
}

export const calculosController = {
    buscaMaricula,
    buscaNombre
}