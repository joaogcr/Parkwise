function cadastrarFunc() {

    var nome = ipt_nome.value;
    var email = ipt_email.value;
    var senha = ipt_senha.value;
    var funcao = ipt_funcao.value;
    var estacionamento = ipt_estacionamento.value;
}

var mensagem = '';


if (nome === '') {
    mensagem += '⚠️ "Nome" é um campo obrigatório.<br>';
}
