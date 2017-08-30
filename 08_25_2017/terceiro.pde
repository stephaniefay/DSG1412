void setup() {
  size(400, 400);
}

void draw() {
  background(255,255,0);
  
  stroke(0,255,0);
  strokeWeight(10);
  fill(255);
  line(20, 20, mouseX, mouseY);
  line(350, 100, 380, 380);
  
  bezier(20, 20, mouseX, mouseY, 350, 100, 380, 380);
  
  fill(255, 0, 0, 125);
  ellipse(200, 200, 300, 300);
}