var database = require("../database/config");

function exibirVagas() {
    var instrucaoSql = `
    SELECT
        SUM(CASE WHEN statusVaga = 1 THEN 1 ELSE 0 END) AS vagas_ocupadas,
        SUM(CASE WHEN statusVaga = 0 THEN 1 ELSE 0 END) AS vagas_desocupadas
    FROM fluxo; 
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function exibirPicos() {
    var instrucaoSql = `
    SELECT MAX(vagas_ocupadas) AS pico_vagas
    FROM (
        SELECT 
            WEEK(entrada) AS semana,
            COUNT(CASE WHEN statusVaga = 1 THEN 1 END) AS vagas_ocupadas
        FROM fluxo
        GROUP BY WEEK(entrada)
    ) AS vagas_ocupadas;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

// funcao do grafico
function grafico_vagas_dia() {
    var instrucaoSql = `
    SELECT * FROM VagasOcupadaseDesocupadas;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    exibirVagas,
    exibirPicos,
    grafico_vagas_dia
};

