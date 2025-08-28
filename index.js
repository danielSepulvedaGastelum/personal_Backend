import 'dotenv/config';
import express from "express";
import cors from "cors";

import userRouter from './routes/user.route.js';
import petRouter from './routes/pet.route.js';
import usuariosRouter from './routes/usuarios.route.js';
import calculosRouter from './routes/calculos.route.js';



const app = express();

app.use(express.json());
app.use(express.urlencoded({extended: true}));
app.use(express.static('public'));
app.use(cors({
  origin: 'http://localhost:5173', // Puerto donde corre React
  credentials: true
}));

app.use('/api/v1/users', userRouter);
app.use('/api/v1/pets', petRouter);
app.use('/api/v1/usuarios', usuariosRouter);
app.use('/api/vi/calculos',calculosRouter);

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log(`Servidor corriendo en el puerto ${PORT}`);
});