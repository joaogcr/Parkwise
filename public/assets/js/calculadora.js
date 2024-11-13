function simular() {

    div_calculadora.style.display = "none";
    div_aparecer.style.display = "flex";

    var capacidade = Number(ipt_capacidadeTotal.value); // capacidade total do estacionamento
    var preco = Number(ipt_preco_hora.value);  // preço por hora cobrado
    var precoAdicional = Number(ipt_precoAdicional.value)  // preço adicional para cada hora que passa
    var vagasOcupadas = Number(ipt_vagasOcupadas.value);  // vagas ocupadas no estacionemnto

    var vagasLivres = capacidade - vagasOcupadas; // vagas livres no estacionamento

    var valorParaCadaCarro = preco + precoAdicional * 2; // estimativa de 3 horas diárias por carro em cada vaga
    var receita = vagasOcupadas * valorParaCadaCarro * 8; // receita do estacionamento gerado por cada vaga

    var manutencao = receita * 30 / 100; // manutenção dos sensores é 30% do preço para cada carro
    var lucroPotencial = ((capacidade * valorParaCadaCarro) - (vagasOcupadas * valorParaCadaCarro)) * 8; //prejuízo para cada vaga livre no estacionamento
    var receitaSemManutencao = receita - manutencao

    div_vagasOcupadas.innerHTML = `${vagasOcupadas}`;
    div_vagasLivres.innerHTML = `${vagasLivres}`;
    div_receitaAtual.innerHTML = `R$${receita.toFixed(2)}`;
    div_receitaPotencial.innerHTML = `R$${lucroPotencial.toFixed(2)}`;
    div_lucroDiario.innerHTML = `R$${(receitaSemManutencao).toFixed(2)}`;
    div_lucroSemanal.innerHTML = `R$${(receitaSemManutencao * 7).toFixed(2)}`;
    div_lucroMensal.innerHTML = `R$${(receitaSemManutencao * 30).toFixed(2)}`;
    div_potencialDiario.innerHTML = `R$${(receitaSemManutencao + (receitaSemManutencao * 0.35)).toFixed(2)}`;
    div_potencialSemanal.innerHTML = `R$${((receitaSemManutencao * 7) + (receitaSemManutencao * 7 * 0.35)).toFixed(2)}`;
    div_potencialMensal.innerHTML = `R$${((receitaSemManutencao * 30) + (receitaSemManutencao * 30 * 0.35)).toFixed(2)}`;

}