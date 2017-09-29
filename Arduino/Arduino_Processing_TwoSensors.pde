 //Utilizado junto com o StandartFirmata
import processing.serial.*;
import cc.arduino.*;
Arduino arduino;

int posX;
int posY;

int pressure;

void setup() {
   size(640, 480);
   println(Serial.list()); //imprimir a lista de portas seriais disponiveis
   arduino = new Arduino(this, Arduino.list()[0], 57600);
}
void draw(){
  
  background(0);
   posX = (int)(cos(arduino.analogRead(0))*100);
   posY = (int)(sin(arduino.analogRead(1))*100);
   pressure = arduino.analogRead(2)%255;
   
   println(posX, posY, pressure);
   
   fill(pressure);
   ellipse(320,240,posX,posY);
}