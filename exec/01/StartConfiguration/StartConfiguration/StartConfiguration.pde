int numOfBalls = 3;
Ball[] balls = {
  new Ball(100, 100, 20), 
  new Ball(700, 400, 80),
  new Ball(300, 800, 70),
  new Ball(200, 200, 40)
};

void setup() {
  size(800, 800);
  
}

void draw() {
  background(51);

  for (Ball b : balls) {
    b.update();
    b.display();
    b.checkBoundaryCollision();
  }

  balls[0].checkCollision(balls[1]);
  balls[1].checkCollision(balls[2]);
  balls[2].checkCollision(balls[0]);
  balls[3].checkCollision(balls[0]);
  balls[3].checkCollision(balls[1]);
  balls[3].checkCollision(balls[2]);
  
}