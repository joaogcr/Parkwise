function validarEmail() {
  var frase_original = input_email.value;
  div_mensagem.innerHTML = "";

  // valida se tem .com ou .br
  var finalEmailCom = frase_original.endsWith(".com");
  var finalEmailBr = frase_original.endsWith(".br");

  if (!finalEmailCom && !finalEmailBr) {
    div_mensagem.innerHTML += `O e-mail não é válido. Deve terminar com '.com' ou '.br'. <br>`;
  }

  // valida se tem arroba
  var arroba = frase_original.includes("@");

  if (!arroba) {
    div_mensagem.innerHTML += `O e-mail não é válido. Deve conter '@'. <br>`;
  }
}

function validacaoCnpj() {
  var frase_original = input_cnpj.value;

  var tem_0001 = frase_original.includes("/0001");

  var mensagem = ``;
  if (tem_0001 == false) {
    mensagem = `O CNPJ precisa conter /0001 <br>`;
  }

  div_mensagem.innerHTML = mensagem;
}

function validarSenha() {
  var senha = input_senha.value;
  mensagemErroSenha.innerHTML = ``;

  var caracteresEspeciais = "!@#$%&?";
  var tamanhoSenha = senha.length;
  var temCaractereEspecial = false;
  var mensagensErro = [];

  //validando tamanho da senha
  if (tamanhoSenha < 8) {
    mensagensErro.push(`A senha precisa ter oito caracteres.`);
  }

  if (tamanhoSenha > 30) {
    mensagensErro.push(`A senha precisa ter no máximo trinta caracteres.`);
  }

  //validando caractere especial
  for (var i = 0; i < tamanhoSenha; i++) {
    if (caracteresEspeciais.includes(senha[i])) {
      temCaractereEspecial = true;
    }
  }

  if (!temCaractereEspecial) {
    mensagensErro.push(
      `A senha precisa conter ao menos um caractere especial.`
    );
  }

  // criando array com letras e spread operator
  const minusculas = [..."abcdefghijklmnopqrstuvwxyz"];
  const maiusculas = [..."ABCDEFGHIJKLMNOPQRSTUVWXYZ"];

  // verifica com o some se passa em pelo menos uma das letras dentro do array
  // o "letra" eh o nome do elemento do array

  var temMinuscula = minusculas.some((letra) => senha.includes(letra));
  var temMaiuscula = maiusculas.some((letra) => senha.includes(letra));

  if (!temMinuscula) {
    mensagensErro.push("A senha precisa conter ao menos uma letra minúscula.");
  }

  if (!temMaiuscula) {
    mensagensErro.push("A senha precisa conter ao menos uma letra maiúscula.");
  }

  const numeros = [..."01234567889"];

  var temNumero = numeros.some((numero) => senha.includes(numero));

  if (!temNumero) {
    mensagensErro.push("A senha preciso conter ao menos um número.");
  }

  // trazendo todas as mensagens q tao dentro do array e dando join com o br para quebrar linha
  document.getElementById("div_mensagem").innerHTML =
    mensagensErro.join("<br>");
}

// front api
function cadastrar() {
  var estacionamentoVar = input_estacionamento.value;
  var cnpjVar = input_cnpj.value;
  var telefoneVar = input_telefone.value;
  var logradouroVar = input_logradouro.value;
  var vagasVar = Number(input_vaga.value);
  var numeroENDVar = input_endereco.value;
  var bairroVar = input_bairro.value;
  var emailVar = input_email.value;
  var senhaVar = input_senha.value;

  // Enviando o valor da nova input
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
      senhaServer: senhaVar
    }),
  })
    .then((resposta) => {
      if (resposta.ok) {
        alert("Cadastro realizado com sucesso!");
        window.location.href = "../tela_login.html"; // Redireciona para a página de login
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
