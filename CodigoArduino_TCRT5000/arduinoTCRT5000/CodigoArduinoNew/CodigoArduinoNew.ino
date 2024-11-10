const int PINO_SENSOR_TCRT5000 = 7;

void setup() {
  pinMode(PINO_SENSOR_TCRT5000, INPUT);
  Serial.begin(9600);
}

void loop() {
  int estadoSensor = digitalRead(PINO_SENSOR_TCRT5000);

  if(estadoSensor == LOW){
    Serial.println("1");
  } else {
    Serial.println("0");
  }

  delay(1000);
}
