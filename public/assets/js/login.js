// function validacao() {

//     var email = input_email.value;
//     var senha = input_senha.value;

//     // exemplo usuário 1
//     if (email == 'admin@gmail.com' && senha == 'Admin@1234') {
//       alert(`Seu usuário foi logado com sucesso!`)
//       window.location.href = '../Login/hub.html';
//     } else {
//       alert('Senha/Email/CNPJ inválidos, ou usuário inexistente. Verifique se todos os dados foram inseridos corretamente.')
//     }

//     //validação email
//     var gmail = email.includes('@gmail.com')
//     var outlook = email.includes('@outlook.com')

//     if (gmail == true || outlook == true) {
//       //pass
//     } else {
//       alert('Email inválido. São somente permitidos gmail ou outlook')
//     }
//   }

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
                    sessionStorage.ID_USUARIO = json.idUsuario;
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