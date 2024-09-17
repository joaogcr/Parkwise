const int PINO_SENSOR_TCRT5000 = 7; // número da entrada digital
  int ativado = 0; // variável global para a presença do carro
  int desativado = 0; // variável global para vaga vazia
  int const separacao = 0;

void setup() { // inicia a configuração
  pinMode(PINO_SENSOR_TCRT5000, INPUT); // configura o pino como entrada (INPUT)
  Serial.begin(9600); // velocidade de leitura de bits por segundo
}

void loop() { // inica a contagem das variáveis
  int estadoSensor = digitalRead(PINO_SENSOR_TCRT5000); // leitura do valor que o sensor está devolvendo
  String p1=";";

  if (estadoSensor == LOW) {
    desativado = 0; // zera o valor de desativado quando sair um carro
    Serial.print("Separação:");
    Serial.print(separacao);
    Serial.print(p1);
    Serial.print("Tempo Ativado:");
    Serial.print(ativado);
    Serial.print(p1);
    Serial.print("Tempo Desativado:");
    Serial.println(desativado);
    ativado++; // incrementa o valor quando tem carro
  } else {
    ativado = 0; // zera o valor do ativado
    delay(1000);
    Serial.print("Separação:");
    Serial.print(separacao);
    Serial.print(p1);
    Serial.print("Tempo Ativado:");
    Serial.print(ativado);
    Serial.print(p1);
    Serial.print("Tempo Desativado:");
    Serial.println(desativado);
    desativado--; // incrementa o valor quando não tem carro
  }

  delay(1000); // cria um atraso de 1 segundo 1
}