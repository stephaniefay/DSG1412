// 30/08/2017

int position_x = 400;
boolean right = true;


void setup () {
  size(800,600);
}

void draw () {
  background(111);
  noStroke();
  ellipse(position_x,300,50,50);
  
  if (right == true)
    position_x += 3;
   else
    position_x -= 3;
  
  if (mousePressed == true) {
    fill(255, 0, 0);
  }
  else {
    fill(255);
  }
}

void mousePressed () {
  if (right == true) {
    if (mouseButton == RIGHT)
      right = false;
  }
}