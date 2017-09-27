int valor = 0;

void setup() {
   Serial.begin(19200);
   pinMode(13, OUTPUT);
   pinMode(12, OUTPUT);
}
void loop() {
   valor = analogRead(A0);
   Serial.println(valor, DEC);

   if (valor < 300){
    digitalWrite(13,HIGH);
    digitalWrite(12,LOW);
   } else {
    digitalWrite(13,LOW);
    digitalWrite(12,HIGH);
   }
   
   delay(10);
}
