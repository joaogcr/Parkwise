

  function cadastrarFuncionario() {
      
          var nomeVar = nome.value;
          var emailVar = email.value;
          var senhaVar = senha.value;
          var cnpjVar = cnpj.value;
          var funcaoVar = funcao.value;

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