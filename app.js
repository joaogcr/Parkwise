// var ambiente_processo = 'producao';
var ambiente_processo = 'desenvolvimento';

const { GoogleGenerativeAI } = require("@google/generative-ai");
const express = require("express");
const path = require("path");

var caminho_env = ambiente_processo === 'producao' ? '.env' : '.env.dev';
// Acima, temos o uso do operador ternário para definir o caminho do arquivo .env
// A sintaxe do operador ternário é: condição ? valor_se_verdadeiro : valor_se_falso

require("dotenv").config({ path: caminho_env });

var cors = require("cors");
var PORTA_APP = process.env.APP_PORT;
var HOST_APP = process.env.APP_HOST;

// configurando o gemini (IA)
const chatIA = new GoogleGenerativeAI(process.env.MINHA_CHAVE);


var app = express();

var indexRouter = require("./src/routes/index");
var usuarioRouter = require("./src/routes/usuarios");
var medidasRouter = require("./src/routes/medidas");
var funcionarioRouter = require("./src/routes/funcionario");

app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(express.static(path.join(__dirname, "public")));

app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Headers', 'Origin, Content-Type, Accept');
    next();
});

app.use(cors());

app.use("/", indexRouter);
app.use("/usuarios", usuarioRouter);
app.use("/medidas", medidasRouter);
app.use("/funcionario", funcionarioRouter);


app.post("/perguntar", async (req, res) => {
    const pergunta = req.body.pergunta;

    try {
        const resultado = await gerarResposta(pergunta);
        res.json( { resultado } );
    } catch (error) {
        res.status(500).json({ error: 'Erro interno do servidor' });
    }

});

// função para gerar respostas usando o gemini
async function gerarResposta(mensagem) {
    // obtendo o modelo de IA
    const modeloIA = chatIA.getGenerativeModel({ model: "gemini-pro" });

    try {
        // gerando conteúdo com base na pergunta
        const resultado = await modeloIA.generateContent(`Em um paragráfo responda: ${mensagem}`);
        const resposta = await resultado.response.text();
        
        console.log(resposta);

        return resposta;
    } catch (error) {
        console.error(error);
        throw error;
    }
}


app.listen(PORTA_APP, function () {
    console.log(`
        ___              __     _      __ _         
        / _ \ ___ _ ____ / /__  | | /| / /(_)___ ___ 
       / ___// _ // __//  '_/  | |/ |/ // /(_-</ -_)
      /_/    \__//_/  /_/\_\   |__/|__//_//___/\__/ 
                                                     
    \n\n\n                                                                                                 
    Servidor do seu site já está rodando! Acesse o caminho a seguir para visualizar .: http://${HOST_APP}:${PORTA_APP} :. \n\n
    Você está rodando sua aplicação em ambiente de .:${process.env.AMBIENTE_PROCESSO}:. \n\n
    \tSe .:desenvolvimento:. você está se conectando ao banco local. \n
    \tSe .:producao:. você está se conectando ao banco remoto. \n\n
    \t\tPara alterar o ambiente, comente ou descomente as linhas 1 ou 2 no arquivo 'app.js'\n\n`);

});