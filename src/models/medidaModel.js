var database = require("../database/config");

function exibirVagas(idEstacionamento) {
    var instrucaoSql = `
    SELECT
        SUM(CASE WHEN statusVaga = 1 THEN 1 ELSE 0 END) AS vagas_ocupadas,
        SUM(CASE WHEN statusVaga = 0 THEN 1 ELSE 0 END) AS vagas_desocupadas
    FROM fluxo as f
    JOIN vaga as v ON f.idFluxo = v.fkFluxo 
    JOIN sensor as s ON s.idSensor = v.fkSensor
    JOIN estacionamento as e ON e.idEstacionamento = s.fkEstacionamento 
    WHERE e.idEstacionamento = ${idEstacionamento}; 
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql, [idEstacionamento]);
}

function exibirPicos(idEstacionamento) {
    var instrucaoSql = `
    SELECT MAX(vagas_ocupadas) AS pico_vagas
    FROM (
        SELECT 
            WEEK(entrada) AS semana,
            COUNT(CASE WHEN statusVaga = 1 THEN 1 END) AS vagas_ocupadas
        FROM fluxo as f
        JOIN vaga as v ON f.idFluxo = v.fkFluxo 
        JOIN sensor as s ON s.idSensor = v.fkSensor
        JOIN estacionamento as e ON e.idEstacionamento = s.fkEstacionamento 
        WHERE e.idEstacionamento = ${idEstacionamento}
        GROUP BY WEEK(entrada)
    ) AS vagas_ocupadas;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql, [idEstacionamento]);
}

// funcao do grafico
function grafico_vagas_dia(idEstacionamento) {
    var instrucaoSql = `
        SELECT 
            DATE(f.entrada) AS dia,
            COUNT(CASE WHEN f.statusVaga = 1 THEN 1 END) AS vagas_ocupadas,
            COUNT(CASE WHEN f.statusVaga = 0 THEN 1 END) AS vagas_desocupadas
        FROM fluxo AS f
        JOIN vaga AS v on f.idFluxo = v.fkFluxo
        JOIN sensor AS s ON v.fkSensor = s.idSensor
        JOIN estacionamento AS e ON s.fkEstacionamento = e.idEstacionamento
        WHERE e.idEstacionamento = ${idEstacionamento}
        GROUP BY dia
        ORDER BY dia DESC LIMIT 7;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql, [idEstacionamento]);
}

function grafico_vagas_semana(idEstacionamento) {
    var instrucaoSql = `
        SELECT 
            e.idEstacionamento,
            e.nome AS estacionamento,
            -- Calculando as semanas baseadas na diferença de dias de 7 em 7
            CONCAT('Semana ', FLOOR(DATEDIFF(CURDATE(), f.entrada) / 7) + 1) AS semana,
            -- Contagem de vagas ocupadas (statusVaga = 1)
            SUM(CASE WHEN f.statusVaga = 1 THEN 1 ELSE 0 END) AS vagas_ocupadas
        FROM 
            estacionamento e
        JOIN 
            sensor s ON e.idEstacionamento = s.fkEstacionamento
        JOIN 
            vaga v ON s.idSensor = v.fkSensor
        JOIN 
            fluxo f ON v.fkFluxo = f.idFluxo
        WHERE 
            e.idEstacionamento = ${idEstacionamento}
            AND 
            f.entrada >= CURDATE() - INTERVAL 30 DAY  -- Considera os últimos 30 dias
        GROUP BY 
            e.idEstacionamento, 
            CONCAT('Semana ', FLOOR(DATEDIFF(CURDATE(), f.entrada) / 7) + 1)
        ORDER BY 
            e.idEstacionamento, semana;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql, [idEstacionamento]); // Passe o parâmetro como array
}

module.exports = {
    exibirVagas,
    exibirPicos,
    grafico_vagas_dia,
    grafico_vagas_semana
};

