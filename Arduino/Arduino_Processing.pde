//Utilizado junto com o StandartFirmata
import processing.serial.*;
import cc.arduino.*;
Arduino arduino;

int circle;
int colorValue;

void setup() {
   size(640, 480);
   println(Serial.list()); //imprimir a lista de portas seriais disponiveis
   arduino = new Arduino(this, Arduino.list()[0], 57600);
}
void draw(){
  
  background(0);
   circle = arduino.analogRead(0);
   colorValue = arduino.analogRead(1);
   
   fill(colorValue);
   ellipse(320,240,circle,circle);
}