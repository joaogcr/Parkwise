var usuarioModel = require("../models/usuarioModel");
var aquarioModel = require("../models/aquarioModel");

function autenticar(req, res) {
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;

    if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está indefinida!");
    } else {

        usuarioModel.autenticar(email, senha)
            .then(
                function (resultadoAutenticar) {
                    console.log(`\nResultados encontrados: ${resultadoAutenticar.length}`);
                    console.log(`Resultados: ${JSON.stringify(resultadoAutenticar)}`); // transforma JSON em String

                    if (resultadoAutenticar.length == 1) {
                        console.log(resultadoAutenticar);

                        aquarioModel.buscarAquariosPorEmpresa(resultadoAutenticar[0].empresaId)
                            .then((resultadoAquarios) => {
                                if (resultadoAquarios.length > 0) {
                                    res.json({
                                        id: resultadoAutenticar[0].id,
                                        email: resultadoAutenticar[0].email,
                                        nome: resultadoAutenticar[0].nome,
                                        senha: resultadoAutenticar[0].senha,
                                    });
                                } else {
                                    res.status(204).json({ aquarios: [] });
                                }
                            })
                    } else if (resultadoAutenticar.length == 0) {
                        res.status(403).send("Email e/ou senha inválido(s)");
                    } else {
                        res.status(403).send("Mais de um usuário com o mesmo login e senha!");
                    }
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log("\nHouve um erro ao realizar o login! Erro: ", erro.sqlMessage);
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }

}

function cadastrar(req, res) {
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html
    var nome = req.body.nomeServer;
    var telefone = req.body.telefoneServer;
    var vagas = req.body.vagasServer;
    var cnpj = req.body.cnpjServer;
    var logradouro = req.body.logradouroServer;
    var numeroEND = req.body.numeroENDServer;
    var bairro = req.body.bairroServer;
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;
    // var email = req.body.emailServer;
    // var senha = req.body.senhaServer;
    // var estacionamento = req.body.estacionamentoServer;
    

   /* nomeServer: nomeVar,
    cnpjServer: cnpjVar,
    emailServer: emailVar,
    telefoneServer: telefoneVar,
    senhaServer: senhaVar,
    logradouroServer: logradouroVar,
    estacionamentoServer: estacionamentoVar,
    vagasServer: vagasVar
    */

    // Faça as validações dos valores
    if (nome == undefined) {
        res.status(400).send("Seu nome está undefined!");
    } else if (telefone == undefined) {
        res.status(400).send("Seu telefone está undefined!");
    } else if (vagas == undefined) {
        res.status(400).send("Vagas está undefined!");
    } else if (cnpj == undefined) {
        res.status(400).send("CNPJ está undefined!");
    } else if (logradouro == undefined) {
            res.status(400).send("Logradouro está undefined!");
    } else if(numeroEND == undefined){
        res.status(400).send("Endereco está undefined!");
    } else if(bairro == undefined){
        res.status(400).send("Bairro está undefined!");
    } else if(email == undefined){
        res.status(400).send("Bairro está undefined!");
    } else if(senha == undefined){
        res.status(400).send("Bairro está undefined!");
    } else {

        // Passe os valores como parâmetro e vá para o arquivo usuarioModel.js
        usuarioModel.cadastrar(nome, telefone, vagas, cnpj, logradouro, numeroEND, bairro, email, senha)
            .then(
                function (resultado) {
                    res.json(resultado);
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log(
                        "\nHouve um erro ao realizar o cadastro! Erro: ",
                        erro.sqlMessage
                    );
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }
}

module.exports = {
    autenticar,
    cadastrar
}