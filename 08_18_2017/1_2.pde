int coordX = 400;

void setup () {
  size (800,800);
  rectMode (CENTER);
  frameRate(260);
}

void draw () {
  background (0,0,255);
  rect(coordX, 300,40,40);
  coordX += 1;
  
  if (coordX > 840) {
    coordX = -40;
  }
}
