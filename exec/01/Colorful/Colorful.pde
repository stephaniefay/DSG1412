Control control;
Keyboard keyboard;

int numOfBalls = 3;
boolean validGame = true;

Ball[] balls = {
  new Ball(100, 100, 20, true), 
  new Ball(700, 400, 80, false), 
  new Ball(300, 800, 70, false), 
  new Ball(200, 200, 40, false)
};

void setup() {
  size(800, 800);

  control = new Control();
  keyboard = new Keyboard();
}

void draw() {
  if (validGame) {

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

    boolean test = balls[0].checkColors(balls);
    if (test)
      validGame = !validGame;
  }
  else {
    background(0);
    textSize(32);
    text("Game Over - You Won", mouseX, mouseY);
  }
  
}

// Use class Control instead
void keyPressed() {
  if (keyboard.isKeyDown(key) == false) {
    balls[0].velocity = control.keyDown(balls[0].velocity);
    keyboard.setKeyDown(key, true);
  }
}

// Use class Control instead
void keyReleased() {
  balls[0].velocity = control.keyUp(balls[0].velocity);
  keyboard.setKeyDown(key, false);
}