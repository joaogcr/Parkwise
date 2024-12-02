
  function passdash() {

    var email_login = input_email.value;
    var senha_login = input_senha.value;

    if (email_login == "" || senha_login == "") {

      cardErro.style.display = "block";
      mensagem_erro.innerHTML =
        "Preencha todos os campos.";
      setTimeout(() => {
        cardErro.style.display = "none";
      }, 3000);
      return;
        }else{

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
            console.log("ESTOU NO THEN DO entrar()!")

            if (resposta.ok) {

                resposta.json().then(json => {
                    console.log(json);
                    console.log(JSON.stringify(json));
                    sessionStorage.EMAIL_USUARIO = json.email;
                    sessionStorage.NOME_USUARIO = json.nome;
                    sessionStorage.ID_ESTACIONAMENTO = json.idEstacionamento;
                    window.location = "./hub.html";
                });

            } else {

              cardErro.style.display = "block";
              mensagem_erro.innerHTML =
                "E-mail ou Senha inválido.";
              setTimeout(() => {
                cardErro.style.display = "none";
              }, 3000);
              return;

            }

        }).catch(function (erro) {
            console.log(erro);
        })

        return false;
        
        }

  }