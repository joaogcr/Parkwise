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