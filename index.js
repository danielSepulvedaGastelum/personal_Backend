import 'dotenv/config';
import express from "express";

import userRouter from './routes/user.route.js';
import petRouter from './routes/pet.route.js';


const app = express();

app.use(express.json());
app.use(express.urlencoded({extended: true}));
app.use(express.static('public'));

app.use('/api/v1/users', userRouter);
app.use('/api/v1/pets', petRouter);

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log(`Servidor corriendo en el puerto ${PORT}`);
});