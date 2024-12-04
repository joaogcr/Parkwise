var database = require("../database/config");

function exibirVagas(idEstacionamento) {
    var instrucaoSql = `
    SELECT 
        SUM(CASE WHEN f.statusVaga = 1 THEN 1 ELSE 0 END) AS vagas_ocupadas,
        SUM(CASE WHEN f.statusVaga = 0 THEN 1 ELSE 0 END) AS vagas_desocupadas
    FROM (
        SELECT 
            v.fkSensor, 
            MAX(f.idFluxo) AS ultimoFluxo
        FROM vaga AS v
        JOIN fluxo AS f ON v.fkFluxo = f.idFluxo
        JOIN sensor AS s ON v.fkSensor = s.idSensor
        WHERE s.fkEstacionamento = ${idEstacionamento}
        GROUP BY v.fkSensor
    ) AS ultimos_fluxos
    JOIN fluxo AS f ON f.idFluxo = ultimos_fluxos.ultimoFluxo;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql, [idEstacionamento]);
}

function exibirPicos(idEstacionamento) {
    var instrucaoSql = `
SELECT * FROM dia_de_pico
WHERE idEstacionamento = ${idEstacionamento}
GROUP BY dia_da_semana
ORDER BY total_carros_estacionados DESC
LIMIT 1;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql, [idEstacionamento]);
}

// funcao do grafico
function grafico_vagas_dia(idEstacionamento) {
    var instrucaoSql = `
        SELECT 
            CONCAT (DAY(f.entrada),'/', MONTH(f.entrada)) AS dia,
            COUNT(CASE WHEN f.statusVaga = 1 THEN 1 END) AS vagas_ocupadas,
            COUNT(CASE WHEN f.statusVaga = 0 THEN 1 END) AS vagas_desocupadas
        FROM fluxo AS f
        JOIN vaga AS v on f.idFluxo = v.fkFluxo
        JOIN sensor AS s ON v.fkSensor = s.idSensor
        JOIN estacionamento AS e ON s.fkEstacionamento = e.idEstacionamento
        WHERE e.idEstacionamento = ${idEstacionamento}
        AND
        f.entrada >= CURDATE() - INTERVAL 7 DAY
        GROUP BY dia
        ORDER BY min(f.entrada) ASC LIMIT 7;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql, [idEstacionamento]);
}

function grafico_vagas_mes(idEstacionamento) {
    var instrucaoSql = `
    SELECT 
        e.idEstacionamento,
        e.nome AS estacionamento,
        DATE_FORMAT(f.entrada, '%Y-%m') AS mes,
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
        AND f.entrada >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 2 MONTH), '%Y-%m-01')
        AND f.entrada < DATE_FORMAT(DATE_ADD(CURDATE(), INTERVAL 1 MONTH), '%Y-%m-01')
    GROUP BY 
        e.idEstacionamento, 
        mes
    ORDER BY 
        e.idEstacionamento, mes;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql, [idEstacionamento]); // Passe o parâmetro como array
}

module.exports = {
    exibirVagas,
    exibirPicos,
    grafico_vagas_dia,
    grafico_vagas_mes
};