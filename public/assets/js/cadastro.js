function formatar(mascara, documento) {
  var i = documento.value.length;
  var saida = '#';
  var texto = mascara.substring(i);
  while (texto.substring(0, 1) != saida && texto.length) {
    documento.value += texto.substring(0, 1);
    i++;
    texto = mascara.substring(i);
  }
}

function formatarCnpj() {
  var cnpj = input_cnpj.value.replace(/\D/g, "");

  if (cnpj.length > 2) {
    cnpj = cnpj.replace(/^(\d{2})(\d)/, "$1.$2");
  }
  if (cnpj.length > 8) {
    cnpj = cnpj.replace(/^(\d{2})\.(\d{6})(\d)/, "$1.$2/$3");
  }
  if (cnpj.length > 12) {
    cnpj = cnpj.replace(/^(\d{2})\.(\d{6})\/(\d{4})(\d)/, "$1.$2/$3-$4");
  }

  input_cnpj.value = cnpj;
}

function campoNull() {
  var email = input_email.value;
  var senha = input_senha.value;
  var endereco = input_endereco.value;
  var bairro = input_bairro.value;
  var cnpj = input_cnpj.value;
  var estacionamento = input_estacionamento.value;
  var logradouro = input_logradouro.value;
  var telefone = input_telefone.value;
  var vaga = input_vaga.value;

  if (email == `` || senha == `` || endereco == `` || bairro == `` || cnpj == `` || estacionamento == `` || logradouro == `` || telefone == `` || vaga == ``) {
    return false;
  }

  return true;
}

function validarEmail() {
  var frase_original = input_email.value;

  var minusculo = frase_original.toLowerCase();

  if (minusculo.includes("@") && (minusculo.endsWith(".com") || minusculo.endsWith(".br"))) {
    console.log("Email válido!");
    return true;
  } else {
    console.log("Email inválido. Verifique o formato.");
    return false;
  }

}

function validacaoCnpj() {
  var frase_original = input_cnpj.value;
  var tem_0001 = frase_original.includes("/0001");

  if (tem_0001) {
    return true;
  }

  return false;
}

function tamanhoCnpj() {
  var cnpj = input_cnpj.value;

  if(cnpj.length < 16){
    return false;
  }

  return true;
}

function tamanhoSenha() {
  var senha = input_senha.value;

  var tamanhoSenha = senha.length;

  if (tamanhoSenha >= 8 && tamanhoSenha <= 30) {
    return true;
  }

  return false;
}

function caracterEspecial() {
  var senha = input_senha.value;

  var temCaractereEspecial = false;
  var caracteresEspeciais = "!@#$%&?";

  for (var i = 0; i < senha.length; i++) {
    if (caracteresEspeciais.includes(senha[i])) {
      temCaractereEspecial = true;
    }
  }

  return temCaractereEspecial;
}

function senhaNum() {
  var senha = input_senha.value;

  var temNumero = false;
  const numeros = [..."01234567889"];
  for (var j = 0; j < senha.length; j++) {
    for (var i = 0; i < numeros.length; i++) {
      if (senha[j] == numeros[i]) {
        temNumero = true
      }
    }
  }

  if (temNumero) {
    return true;
  }

  return false;
}

function tell15(){
  var telefone = input_telefone.value;

  if(telefone.length < 15){
    return false;
  }

    return true;
  


}

function cadastrar() {

  if (!campoNull()) {
    cardErro.style.display = "block";
    mensagem_erro.innerHTML =
      "Preencha todos os campos";
    setTimeout(() => {
      cardErro.style.display = "none";
    }, 3000);
    return;
  }

  if(!tell15()){
    cardErro.style.display = "block";
    mensagem_erro.innerHTML =
      "O telefone está incompleto";
    setTimeout(() => {
      cardErro.style.display = "none";
    }, 3000);
    return;
  }
  if (!validarEmail()) {
    cardErro.style.display = "block";
    mensagem_erro.innerHTML =
      "Email inválido.";
    setTimeout(() => {
      cardErro.style.display = "none";
    }, 3000);
    return;
  }

  if (!validacaoCnpj()) {
    cardErro.style.display = "block";
    mensagem_erro.innerHTML =
      "CNPJ inválido. Ele deve conter '/0001'.";
    setTimeout(() => {
      cardErro.style.display = "none";
    }, 3000);
    return;
  }

  if(!tamanhoCnpj()){
    cardErro.style.display = "block";
    mensagem_erro.innerHTML =
      "O CNPJ está incompleto.";
    setTimeout(() => {
      cardErro.style.display = "none";
    }, 3000);
    return;
  }

  if (!tamanhoSenha()) {
    cardErro.style.display = "block";
    mensagem_erro.innerHTML =
      "Senha inválida. Ela deve ter entre 8 e 30 caracteres.";
    setTimeout(() => {
      cardErro.style.display = "none";
    }, 3000);
    return;
  }

  if (!caracterEspecial()) {
    cardErro.style.display = "block";
    mensagem_erro.innerHTML =
      "Senha inválida. Ela deve conter ao menos um caractere especial (!@#$%&?).";
    setTimeout(() => {
      cardErro.style.display = "none";
    }, 3000);
    return;
  }

  if (!senhaNum()) {
    cardErro.style.display = "block";
    mensagem_erro.innerHTML =
      "Senha inválida. Ela deve conter ao menos um número.";
    setTimeout(() => {
      cardErro.style.display = "none";
    }, 3000);
    return;
  }

  var estacionamentoVar = input_estacionamento.value;
  var cnpjVar = input_cnpj.value;
  var telefoneVar = input_telefone.value;
  var logradouroVar = input_logradouro.value;
  var vagasVar = Number(input_vaga.value);
  var numeroENDVar = input_endereco.value;
  var bairroVar = input_bairro.value;
  var emailVar = input_email.value;
  var senhaVar = input_senha.value;

  console.log("Enviando dados:", {
    estacionamentoServer: estacionamentoVar,
    cnpjServer: cnpjVar,
    telefoneServer: telefoneVar,
    logradouroServer: logradouroVar,
    vagasServer: vagasVar,
    numeroENDServer: numeroENDVar,
    bairroServer: bairroVar,
    emailServer: emailVar,
    senhaServer: senhaVar,
  });

  fetch("/usuarios/cadastrar", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      estacionamentoServer: estacionamentoVar,
      cnpjServer: cnpjVar,
      telefoneServer: telefoneVar,
      logradouroServer: logradouroVar,
      vagasServer: vagasVar,
      numeroENDServer: numeroENDVar,
      bairroServer: bairroVar,
      emailServer: emailVar,
      senhaServer: senhaVar,
    }),
  })
    .then((resposta) => {
      if (resposta.ok) {
        alert("Cadastro realizado com sucesso!");
        window.location.href = "../tela_login.html";
      } else {
        return resposta.text().then((text) => {
          throw new Error(text);
        });
      }
    })
    .catch((erro) => {
      console.error("Erro ao realizar o cadastro:", erro);
      alert("Erro ao realizar o cadastro: " + erro.message);
    });
}

function buscarCep() {
  var cep = input_cep.value;

  var url = `https://viacep.com.br/ws/${cep}/json`;

  var json;
  if (cep.length < 8 || isNaN(Number(cep))) {
    return;
  } else {

    fetch(url)
      .then(function (resposta) {

        console.log(resposta);
        resposta.json()
          .then(function (respostaJson) {
            json = respostaJson;
            console.log(json.logradouro);
            console.log(json.bairro);
            console.log(respostaJson);

            input_logradouro.value = json.logradouro;
            input_bairro.value = json.bairro;
          })
      })

  }
}

function verify(form) {
  if (form === 'nome') {
    var nome = input_estacionamento.value;

    if (nome == ``) {
      div_verifyEstacionamento.innerHTML = ``;
    } else {
      if (nome.length >= 3) {
        div_verifyEstacionamento.innerHTML = `Ok`;
        return false;
      } else {
        div_verifyEstacionamento.innerHTML = `O nome deve conter mais de 2 caracteres`;
        return true;
      }
    }

  } else if (form === 'telefone') {
    var telefone = input_telefone.value;

    if (telefone == ``) {
      div_verifyTelefone.innerHTML = ``;
    } else {
      if (telefone.length < 15) {
        div_verifyTelefone.innerHTML = `O telefone precisa ter 16 dígitos`;
      } else {
        div_verifyTelefone.innerHTML = `Ok`;
      }
    }

  } else if (form === "vaga") {
    var vaga = input_vaga.value;
    input_vaga.value = input_vaga.value.replace(/[eE\+\-]/g, '');

    if (vaga.length > 0) {
      div_verifyVaga.innerHTML = `Ok`;
    } else {
      div_verifyVaga.innerHTML = ``;
    }


  } else if (form === "cnpj") {
    var cnpj = input_cnpj.value;

    var tem_0001 = cnpj.includes("/0001");
    if (cnpj == ``) {
      div_verifyCnpj.innerHTML = ``;
    } else {
      if (!tem_0001) {
        div_verifyCnpj.innerHTML = `O cnpj precisa ter /0001 (mil contra)`;
      } else {
        if (cnpj.length < 17) {
          div_verifyCnpj.innerHTML = `O cnpj precisa ter 17 caracteres`;
        } else {
          div_verifyCnpj.innerHTML = `Ok`;
        }
      }
    }


  } else if (form === "email") {
    var email = input_email.value;

    var minusculo = email.toLowerCase();
    if (email == ``) {
      div_verifyEmail.innerHTML = ``;
    } else {

      if (minusculo.includes("@")) {
        div_verifyEmail.innerHTML = `Ok`;
        if ((minusculo.endsWith("gmail.com"))) {
          div_verifyEmail.innerHTML = `Ok`;
        } else {
          div_verifyEmail.innerHTML = `O email precisa terminar "gmail.com" `;
        }
      } else {
        div_verifyEmail.innerHTML = `O email precisa incluir "@" `;
      }


    }
  } else if (form === "senha") {
    var senha = input_senha.value;

    var temCaractereEspecial = false;
    var caracteresEspeciais = "!@#$%&?";

    for (var i = 0; i < senha.length; i++) {
      if (caracteresEspeciais.includes(senha[i])) {
        temCaractereEspecial = true;
      }
    }

    var temNumero = false;

    const numeros = [..."01234567889"];
    for (var j = 0; j < senha.length; j++) {
      for (var i = 0; i < numeros.length; i++) {
        if (senha[j] == numeros[i]) {
          temNumero = true
        }
      }
    }
    var tamanho = false;
    var tamanhoSenha = senha.length;

    if (tamanhoSenha >= 8 && tamanhoSenha <= 30) {
      tamanho = true;
    }

    if (senha == ``) {
      div_verifySenha.innerHTML = ``;
    } else {
      if (temCaractereEspecial) {
        div_verifySenha.innerHTML = `Ok`;
        if (temNumero) {
          div_verifySenha.innerHTML = `Ok`;
          if (tamanho) {
            div_verifySenha.innerHTML = `Ok`;
          } else {
            div_verifySenha.innerHTML = `A senha está com um tamanho inválido`;
          }
        } else {
          div_verifySenha.innerHTML = `A senha precisa de um Número`;
        }
      } else {
        div_verifySenha.innerHTML = `A senha precisa de Carácter Especial`;
      }
    }

  }
}