var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

// kpis de vagas
router.get("/vagas", function (req, res) {
    medidaController.exibirVagas(req, res);
});
// kpis do pico
router.get("/picos", function (req, res) {
    medidaController.exibirPicos(req, res);
});

// mudar nome da rota para o grafico
router.get("/grafico_vagas_dia", function (req, res) {
    medidaController.grafico_vagas_dia (req, res);
});

module.exports = router;