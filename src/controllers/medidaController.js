var medidaModel = require("../models/medidaModel");

function exibirVagas(req, res) {
    console.log(`Recuperando KPIs gerais`);

    medidaModel.exibirVagas().then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as KPIs.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function exibirPicos(req, res) {
    console.log(`Recuperando KPIs gerais`);

    medidaModel.exibirPicos().then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as KPIs.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

// mudar nome das funcoes e dos modelos
function aaaaaaaaaaaaaa(req, res) {
    console.log(`Recuperando distribuição de usuários por álbum`);

    medidaModel.aaaaaaaaaaaaaa().then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar usuários por álbum.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

module.exports = {
    exibirVagas,
    exibirPicos
}