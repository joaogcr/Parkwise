
// Model (funcionarioModel.js)
var database = require("../database/config")

function autenticarFuncionario(email, senha) {
    console.log("ACESSEI O FUNCIONARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function autenticarFuncionario(): ", email, senha)
    
    var instrucaoSql = `
        SELECT email, funcao, fkEstacionamento 
        FROM funcionario 
        WHERE email = '${email}' AND senha = '${senha}';
    `;
    
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function cadastrarFuncionario(nome, email, senha, funcao, fkEstacionamento) {
    console.log("ACESSEI O FUNCIONARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrarFuncionario():", nome, email, senha, funcao, fkEstacionamento);
    
    var instrucaoSql = `
        INSERT INTO funcionario (nomeFuncionario, email, senha, funcao, fkEstacionamento) 
        VALUES ('${nome}', '${email}', '${senha}', '${funcao}', ${fkEstacionamento});
    `;
    
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    autenticarFuncionario,
    cadastrarFuncionario
};
