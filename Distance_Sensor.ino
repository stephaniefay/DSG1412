//DISTANCE SENSOR

int valor = 0;

void setup() {
  pinMode(12, OUTPUT);
  Serial.begin(19200);

}

void loop() {
  valor = analogRead(A0);
  Serial.println(valor, DEC);

  if (valor > 400)
    digitalWrite(12,HIGH);
  else
    digitalWrite(12,LOW);

  delay(10);

}
