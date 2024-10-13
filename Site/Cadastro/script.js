function validacaoEmail () {
    var frase_original = input_email.value;

    var termina_gmail = frase_original.endsWith('@gmail.com');

    var mensagem = ``;
    if(termina_gmail == false){
        mensagem = `<spam style="color: red;">O E-mail precisa terminar em @gmail.com</spam> <br>`;
    }else{
        mensagem = `<spam style="color: blue;">O E-mail precisa terminar em @gmail.com</spam> <br>`;
    }

    div_mensagem.innerHTML = `<div style="
    display: flex; 
    justify-content: center; 
    align-items: center; 
    font-size: 15px;
    background-color: #000000;
    text-align: center;
    height: 70px;">${mensagem}</div>`;
}

function validacaoCnpj () {
    var frase_original = input_cnpj.value;

    var tem_0001 = frase_original.includes('/0001');

    var mensagem = ``;
    if(tem_0001 == false){
        mensagem = `<spam style="color: red;">O CNPJ precisa conter /0001</spam> <br>`;
    }else{
        mensagem = `<spam style="color: blue;">O CNPJ precisa conter /0001</spam> <br>`;
    }

    div_mensagem.innerHTML = `<div style="
    display: flex; 
    justify-content: center; 
    align-items: center; 
    font-size: 15px;
    background-color: #000000;
    text-align: center;
    height: 70px;">${mensagem}</div>`;
}

function validacaoSenha() {
    var frase_original = input_senha.value;

    var mensagem = ``;

    var tamanho_frase = frase_original.length;

    if(tamanho_frase >= 8){
        mensagem += `<spam style="color: blue;">A senha deve conter no mínimo 8 caracteres</spam> <br>`;
    }else{
        mensagem += `<spam style="color: red;">A senha deve conter no mínimo 8 caracteres</spam> <br>`;
    }
    var frase_upper = frase_original.toUpperCase();

    var frase_lower = frase_original.toLowerCase();

    var minusculo = frase_original != frase_lower;
    var maisculo = frase_original != frase_upper;

    if(minusculo == true){
        mensagem += `<spam style="color: blue;">A senha precisa ter letra MAIÚSCULA</spam> <br>`;
    }else{
        mensagem += `<spam style="color: red;">A senha precisa ter letra MAIÚSCULA</spam> <br>`;
    }

    if(maisculo == true){
        mensagem += `<spam style="color: blue;">A senha precisa ter letra MINÚSCULA</spam> <br>`;
    }else{
        mensagem += `<spam style="color: red;">A senha precisa ter letra MINÚSCULA</spam> <br>`;
    }

    var frase_numero = false;
    for(var i = 0 ; i < tamanho_frase ; i++){

        if(frase_original[i] == 0 || frase_original[i] == 1 || frase_original[i] == 2 || frase_original[i] == 3 || frase_original[i] == 4 || frase_original[i] == 5 || frase_original[i] == 6 || frase_original[i] == 7 || frase_original[i] == 8 || frase_original[i] == 9){
            frase_numero = true;
        }

    }

    if(frase_numero == false){
        mensagem += `<spam style="color: red;">A senha precisa ter um NÚMERO</spam> <br>`;
    }else{
        mensagem += `<spam style="color: blue;">A senha precisa ter um NÚMERO</spam> <br>`;
    }

    div_mensagem.innerHTML = `<div style="
    font-size: 15px;
    background-color: #000000;
    text-align: center;
    height: 70px;">${mensagem}</div>`;
}