//Exemplo comunicação serial por João Bonelli
//Arduino envia dados para Processing atraves da Porta Serial
int valor = 0;
void setup() {
   Serial.begin(57600);
}
void loop() {
   valor = analogRead(A0)/4;
   Serial.write(valor);
   delay(100);
}
