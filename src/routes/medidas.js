var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

// kpis de vagas
router.get("/vagas/:idEstacionamento", function (req, res) {
    medidaController.exibirVagas(req, res);
});
// kpis do pico
router.get("/picos/:idEstacionamento", function (req, res) {
    medidaController.exibirPicos(req, res);
});

// mudar nome da rota para o grafico
router.get("/grafico_vagas_dia/:idEstacionamento", function (req, res) {
    medidaController.grafico_vagas_dia (req, res);
});

router.get("/grafico_vagas_semana/:idEstacionamento", function (req, res) {
    medidaController.grafico_vagas_semana(req, res);
});

module.exports = router;