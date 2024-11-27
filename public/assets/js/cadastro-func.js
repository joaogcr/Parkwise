function cadastrarFunc() {

    var nome = ipt_nome.value;
    var email = ipt_email.value;
    var senha = ipt_senha.value;
    var funcao = ipt_funcao.value;
}

var mensagem = '';


if (nome === '') {
    mensagem += '⚠️ "Nome" é um campo obrigatório.<br>';
}
if (email === '') {
    mensagem += '⚠️ "Email" é um campo obrigatório.<br>';
} else if (!email.match(/^[^\s@]+@[^\s@]+\.[^\s@]+$/)) {
    mensagem += '⚠️ "Email" está em um formato inválido.<br>';
}

if (senha === '') {
    mensagem += '⚠️ "Senha" é um campo obrigatório.<br>';
} else if (senha.length < 6) {
    mensagem += '⚠️ "Senha" deve ter no mínimo 6 caracteres.<br>';
}

if (funcao === '') {
    mensagem += '⚠️ "Função" é um campo obrigatório.<br>';
}

if (cnpj === '') {
    mensagem += '⚠️ "CNPJ" é um campo obrigatório.<br>';
} else if (!cnpj.match(/^\d{14}$/)) {
    mensagem += '⚠️ "CNPJ" deve conter 14 números.<br>';
}


// A mensagem de erro:
if (mensagem !== '') {
    div_mensagem.innerHTML = mensagem;
    div_mensagem.style.color = 'red';
    return;
}

  // Se todos os campos estiverem válidos:
  div_mensagem.innerHTML = '✔️ Todos os campos foram preenchidos corretamente!';
  div_mensagem.style.color = 'green';

