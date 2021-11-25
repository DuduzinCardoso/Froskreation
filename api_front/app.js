process.env.AMBIENTE_PROCESSO = "desenvolvimento";
// process.env.AMBIENTE_PROCESSO = "producao";

const express = require("express");
const cors = require("cors");
const path = require("path");
const PORTA = 3333;

const app = express();

const indexRouter = require("./src/routes/index");
const usuarioRouter = require("./src/routes/usuarios");
const avisosRouter = require("./src/routes/avisos");
const medidasRouter = require("./src/routes/medidas");

app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(express.static(path.join(__dirname, "public")));

app.use(cors());

app.use("/", indexRouter);
app.use("/usuarios", usuarioRouter);
app.use("/avisos", avisosRouter);
app.use("/medidas", medidasRouter)

app.listen(PORTA, function () {
    console.log(`Servidor do site está rodando rodando: http://localhost:${PORTA} \n
    Você está rodando sua aplicação em ${process.env.AMBIENTE_PROCESSO} \n
    \t\tSe "desenvolvimento", banco local (MySQL Workbench). \n
    \t\tSe "producao", banco remoto (SQL Server em nuvem Azure)`);
});