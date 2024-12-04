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

function aplicarMascaraCNPJ(valor) {
    // remove caracteres n numericos 
    var cnpjLimpo = "";
  
    for (var i = 0; i < valor.length; i++) {
      var char = valor[i];
      if (char >= '0' && char <= '9') {
        cnpjLimpo += char;
      }
    }
  
    // formatacao dos caracteres
    var cnpjFormatado = "";
    var tamanho = cnpjLimpo.length;
  
    for (var i = 0; i < tamanho; i++) {
      if (i === 2 || i === 5) {
        cnpjFormatado += ".";
      } else if (i === 8) {
        cnpjFormatado += "/";
      } else if (i === 12) {
        cnpjFormatado += "-";
      }
      cnpjFormatado += cnpjLimpo[i];
    }
  
    return cnpjFormatado;
  }
  
  // pega o id do elemento
  var inputCNPJ = document.getElementById('input_cnpj');
  
  // add escutador de evento da input e funcao e aplica a funcao aplicarmascaracnpj
  inputCNPJ.addEventListener('input', function () {
    this.value = aplicarMascaraCNPJ(this.value);
  
  });