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
function grafico_vagas_dia(req, res) {
    console.log(`Recuperando distribuição de usuários por álbum`);

    medidaModel.grafico_vagas_dia().then(function (resultado) {
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

function grafico_vagas_semana(req, res) {
    var idEstacionamento = req.params.idEstacionamento; // Recupera o parâmetro da URL
    console.log(`Recuperando dados para o estacionamento com ID: ${idEstacionamento}`);

    medidaModel.grafico_vagas_semana(idEstacionamento).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado); // Retorna os resultados como JSON
        } else {
            res.status(204).send("Nenhum resultado encontrado!"); // Retorna status 204 se nenhum dado for encontrado
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar a ocupação semanal.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage); // Retorna erro 500 em caso de falha
    });
}

module.exports = {
    exibirVagas,
    exibirPicos,
    grafico_vagas_dia,
    grafico_vagas_semana
}