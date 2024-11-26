const int PINO_SENSOR_TCRT5000 = 7;
int estadoAnterior = -1;
int estadoAtual;

void setup() {
  pinMode(PINO_SENSOR_TCRT5000, INPUT);
  Serial.begin(9600);
}

void loop() {
  estadoAtual = digitalRead(PINO_SENSOR_TCRT5000);

  if (estadoAtual != estadoAnterior) {
    estadoAnterior = estadoAtual;

    if (estadoAtual == LOW) {
      Serial.println("1");
    } else {
      Serial.println("0");
    }
  }

  delay(1000);
}