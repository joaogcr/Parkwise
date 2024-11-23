function validacao() {
    var cnpj = input_cnpj.value;
    var email = input_email.value;
    var senha = input_senha.value;

    // exemplo usuário 1
    if (cnpj == '12.345.678/0001-90' && email == 'admin@gmail.com' && senha == 'Admin@1234') {
      alert(`Seu usuário foi logado com sucesso!`)
      window.location.href = '../Login/hub.html';
    } else {
      alert('Senha/Email/CNPJ inválidos, ou usuário inexistente. Verifique se todos os dados foram inseridos corretamente.')
    }

    //validação cnpj
    var barraCNPJ = cnpj.includes('/');
    var tracoCNPJ = cnpj.includes('-');
    var pontoCNPJ = cnpj.includes('.');

    //validação email
    var gmail = email.includes('@gmail.com')
    var outlook = email.includes('@outlook.com')

    if (barraCNPJ == true && tracoCNPJ == true && pontoCNPJ == true) {
      //pass
    } else {
      alert('CNPJ inválido. Cheque se o ".", "/" e o "-" foram inseridos corretamente')

    }

    if (gmail == true || outlook == true) {
      //pass
    } else {
      alert('Email inválido. São somente permitidos gmail ou outlook')
    }
  }

  function passdash() {

    var email_login = input_email.value;
    var senha_login = input_senha.value;
    var cnpj_login = input_cnpj.value;

    if (email_login == "" || senha_login == "") {

      alert('Preencha todos os campo!');

            return false;
        }else{

        console.log("FORM LOGIN: ", email_login);
        console.log("FORM SENHA: ", senha_login);
        console.log("FORM CNPJ: ", cnpj_login);

        fetch("/usuarios/autenticar", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                emailServer_login: email_login,
                senhaServer_login: senha_login,
                cnpjServer_login: cnpj_login
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

              console.log(resposta);

            }

        }).catch(function (erro) {
            console.log(erro);
        })

        return false;
        
        }

  }