// function cadastrarFunc() {

//     var nome = ipt_nome.value;
//     var email = ipt_email.value;
//     var senha = ipt_senha.value;
//     var funcao = ipt_funcao.value;
// }

// var mensagem = '';


// if (nome === '') {
//     mensagem += '⚠️ "Nome" é um campo obrigatório.<br>';
// }
// if (email === '') {
//     mensagem += '⚠️ "Email" é um campo obrigatório.<br>';
// } else if (!email.match(/^[^\s@]+@[^\s@]+\.[^\s@]+$/)) {
//     mensagem += '⚠️ "Email" está em um formato inválido.<br>';
// }

// if (senha === '') {
//     mensagem += '⚠️ "Senha" é um campo obrigatório.<br>';
// } else if (senha.length < 6) {
//     mensagem += '⚠️ "Senha" deve ter no mínimo 6 caracteres.<br>';
// }

// if (funcao === '') {
//     mensagem += '⚠️ "Função" é um campo obrigatório.<br>';
// }

// if (cnpj === '') {
//     mensagem += '⚠️ "CNPJ" é um campo obrigatório.<br>';
// } else if (!cnpj.match(/^\d{14}$/)) {
//     mensagem += '⚠️ "CNPJ" deve conter 14 números.<br>';
// }


// A mensagem de erro:
// if (mensagem !== '') {
//     div_mensagem.innerHTML = mensagem;
//     div_mensagem.style.color = 'red';
// }

//   // Se todos os campos estiverem válidos:
//   div_mensagem.innerHTML = '✔️ Todos os campos foram preenchidos corretamente!';
//   div_mensagem.style.color = 'green';

  function cadastrarFuncionario() {
      
          var nomeVar = nome.value;
          var emailVar = email.value;
          var senhaVar = senha.value;
          var cnpjVar = cnpj.value;
          var funcaoVar = funcao.value;
    // if (email != (email.includes('@') && email.includes('.') && (email.endsWith('.com') || email.endsWith('.br')))) {
    //     alert("Email inválido. Ele deve conter '@' e terminar com '.com' ou '.br'.");
    //     return;
    // }
    // if (senha.length < 8 || senha.length > 30) {
    //     alert("Senha inválida. Ela deve ter entre 8 e 30 caracteres.");
    //     return;
    // }
    // if (senha != (senha.includes('$') || senha.includes('#')|| senha.includes('@') || senha.includes('!') || senha.includes('$') || senha.includes('%') || senha.includes('&'))) {
    //     alert("Senha inválida. Ela deve conter ao menos um caractere especial (!@#$%&?).");
    //     return;
    // }
    // if (senha != (senha.includes('1') || senha.includes('2') || senha.includes('3') || senha.includes('4') || senha.includes('5') || senha.includes('6') || senha.includes('7') || senha.includes('8') || senha.includes('9') || senha.includes('0'))) {
    //     alert("Senha inválida. Ela deve conter ao menos um número.");
    //     return;
    // }

    var fkEstacionamentoVar = sessionStorage.ID_ESTACIONAMENTO;
    
    if (!fkEstacionamentoVar) {
        alert("Erro: ID do estacionamento não encontrado. Por favor, faça login novamente.");
        window.location.href = "../tela_login.html";
        return;
    }

    fetch("/funcionario/cadastrarFuncionario", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            nomeServer: nomeVar,
            emailServer: emailVar,
            senhaServer: senhaVar,
            cnpjServer: cnpjVar,
            funcaoServer: funcaoVar,
            fkEstacionamentoServer: fkEstacionamentoVar
        })
    })
    .then(function (resposta) {
        if (resposta.ok) {
            alert("Cadastro realizado com sucesso!");
            window.location.href = "../tela_login.html";
        } else {
            throw new Error("Houve um erro ao tentar realizar o cadastro!");
        }
    })
    .catch(function (erro) {
        console.log(erro);
        alert(erro.message);
    });
}