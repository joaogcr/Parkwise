function passdash() {

  var email_login = input_email.value;
  var senha_login = input_senha.value;
  var fkEstacionamento = sessionStorage.getItem('ID_ESTACIONAMENTO');

  if (email_login == "" || senha_login == "") {

    cardErro.style.display = "block";
    mensagem_erro.innerHTML =
      "Preencha todos os campos.";
    setTimeout(() => {
      cardErro.style.display = "none";
    }, 3000);
    return;
  } else {

    console.log("FORM LOGIN: ", email_login);
    console.log("FORM SENHA: ", senha_login);

    fetch("/usuarios/autenticar", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        emailServer_login: email_login,
        senhaServer_login: senha_login
      })
    }).then(function (resposta) {
      console.log("Status da resposta:", resposta.status);

      if (resposta.ok) {
        return resposta.json();
      } else {
        return resposta.text().then(textoErro => {
          throw new Error(textoErro);
        });
      }
    }).then(json => {
      sessionStorage.EMAIL_USUARIO = json.email;
      sessionStorage.NOME_USUARIO = json.nome;
      sessionStorage.ID_ESTACIONAMENTO = json.idEstacionamento;
      if(email_login == 'gabriella.antunes@gmail.com' && senha_login == 'senha%123'){
        window.location = "./hubBob.html";
      } else {
        window.location = "./hub.html";
      }
    }).catch(function (erro) {
      console.error("Erro de login:", erro);
      cardErro.style.display = "block";
      mensagem_erro.innerHTML = erro.message || "E-mail ou Senha inválido.";
      setTimeout(() => {
        cardErro.style.display = "none";
      }, 3000);
    });

    fetch("/funcionario/autenticarFuncionario", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        emailServer: email_login,
        senhaServer: senha_login,
        fkEstacionamentoServer: fkEstacionamento
      })
    })
      .then(function (resposta) {
        console.log("ESTOU NO THEN DO passdash()!");

        if (resposta.ok) {
          
          resposta.json().then(json => {
            console.log(json);
            console.log(JSON.stringify(json));
            sessionStorage.EMAIL_USUARIO = json.email;
            sessionStorage.NOME_USUARIO = json.nomeFuncionario;
            sessionStorage.ID_ESTACIONAMENTO = json.fkEstacionamento;
            window.location = "./hub.html";
          });
        } else {
          cardErro.style.display = "block";
          mensagem_erro.innerHTML = "E-mail, senha e/ou ID do estacionamento inválido(s).";
          setTimeout(() => {
            cardErro.style.display = "none";
          }, 3000);
          return;
        }
      })
      .catch(function (erro) {
        console.log(erro);
      });

    return false;
  }

}