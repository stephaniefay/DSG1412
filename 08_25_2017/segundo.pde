void setup() {
  size(400, 400);
}

void draw() {
  background(125,125,125);
  line(20, 20, mouseX, mouseY);
  line(350, 100, 380, 380);
  
  bezier(20, 20, mouseX, mouseY, 350, 100, 380, 380);
}