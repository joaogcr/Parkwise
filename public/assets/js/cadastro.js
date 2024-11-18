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

function tamanhoSenha() {
  var senha = input_senha.value;

  var tamanhoSenha = senha.length;

  if (tamanhoSenha >= 8  && tamanhoSenha <= 30) {
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
  for(var j = 0 ; j < senha.length ; j++){
    for(var i = 0 ; i < numeros.length ; i++){
      if(senha[j] == numeros[i]){
        temNumero = true
      }
    }
  }

  if (temNumero) {
    return true;
  }

  return false;
}

function cadastrar() {
  if (!validarEmail()) {
    alert("Email inválido. Ele deve conter '@' e terminar com '.com' ou '.br'.");
    return;
  }

  if (!validacaoCnpj()) {
    alert("CNPJ inválido. Ele deve conter '/0001'.");
    return;
  }

  if (!tamanhoSenha()) {
    alert("Senha inválida. Ela deve ter entre 8 e 30 caracteres.");
    return;
  }

  if (!caracterEspecial()) {
    alert("Senha inválida. Ela deve conter ao menos um caractere especial (!@#$%&?).");
    return;
  }

  if (!senhaNum()) {
    alert("Senha inválida. Ela deve conter ao menos um número.");
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