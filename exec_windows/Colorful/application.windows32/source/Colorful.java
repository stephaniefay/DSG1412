import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Colorful extends PApplet {

Control control;
Keyboard keyboard;
Score score;

int numOfBalls = 3;
boolean validGame = true;
boolean timerFlag = true;

ArrayList<Ball> balls = new ArrayList<Ball>();

public void setup() {
  

  control = new Control();
  keyboard = new Keyboard();
  score = new Score();

  balls.add(new Ball(100, 100, 20, true, 0));
  balls.add(new Ball(700, 400, (int)(10 + (Math.random()*40)), false, 1));
  balls.add(new Ball(300, 600, (int)(10 + (Math.random()*40)), false, 2)); 
  balls.add(new Ball(200, 200, (int)(10 + (Math.random()*40)), false, 3));
}

public void draw() {
  if (validGame) {

    background(51);

    for (Ball b : balls) {
      b.update();
      b.display();
      b.checkBoundaryCollision();
      score.updateScore(numOfBalls);

      for (int i = 0; i < numOfBalls; i++) {
        b.checkCollision(balls.get(i));
      }
    }

    boolean test = balls.get(0).colorBall.checkColors(balls);
    if (test)
      validGame = !validGame;
  } else {
    background(0);
    textSize(32);
    text("Game Over - You Won", mouseX, mouseY);
  }

  int t = score.timer();

  if ((t%10 == 0) && (t>=10) && timerFlag) {
    balls.add(new Ball((int)(0 + (Math.random()*800)), (int)(0 + (Math.random()*600)), (int)(10 + (Math.random()*40)), false, (balls.size())));
    numOfBalls++;
    timerFlag = !timerFlag;
  } else if (!timerFlag) {
    if (t%10 != 0)
      timerFlag = !timerFlag;
  }

  score.calculatePoints(numOfBalls);
  
}

// Use class Control instead
public void keyPressed() {  
  if (keyboard.isKeyDown(key) == false) {
    balls.get(0).velocity = control.keyDown(balls.get(0).velocity);
    keyboard.setKeyDown(key, true);
  }
}

// Use class Control instead
public void keyReleased() {
  balls.get(0).velocity = control.keyUp(balls.get(0).velocity);
  keyboard.setKeyDown(key, false);
}
public class Ball {
  PVector position;
  PVector velocity;

  Color colorBall;

  float radius, m;
  boolean player;
  
  int idBall;

  public Ball(float x, float y, float r_, boolean p, int id) {
    position = new PVector(x, y);
    radius = r_;
    m = radius*.1f;
    player = p;
    colorBall = new Color(p);
    if (player) {
      velocity = new PVector(0, 0);
    } else {
      velocity = PVector.random2D();
      velocity.mult(3);
    }
    idBall = id;
  }

  public void update() {
    position.add(velocity);
  }

  public void checkBoundaryCollision() {

    int flag = 0;

    if (position.x > width-radius) {
      if (!player)
        velocity.x *= -1;
      position.x = width-radius;
      flag += 1;
    } else if (position.x < radius) {
      if (!player)
        velocity.x *= -1;
      position.x = radius;
      flag += 1;
    } else if (position.y > height-radius) {
      if (!player)
        velocity.y *= -1;
      position.y = height-radius;
      flag += 1;
    } else if (position.y < radius) {
      if (!player)
        velocity.y *= -1;
      position.y = radius;
      flag += 1;
    }

    if (flag > 0) {
      colorBall.changeColor();
    }
  }

  public void checkCollision(Ball other) {

    PVector distanceVect = PVector.sub(other.position, position);

    float distanceVectMag = distanceVect.mag();

    float minDistance = radius + other.radius;

    if (distanceVectMag < minDistance) {
      float distanceCorrection = (minDistance-distanceVectMag)/2.0f;
      PVector d = distanceVect.copy();
      PVector correctionVector = d.normalize().mult(distanceCorrection);

      if (!other.player)
        other.position.add(correctionVector);

      if (!player)
        position.sub(correctionVector);

      float theta  = distanceVect.heading();
      float sine = sin(theta);
      float cosine = cos(theta);

      PVector[] bTemp = {
        new PVector(), new PVector()
      };

      bTemp[1].x  = cosine * distanceVect.x + sine * distanceVect.y;
      bTemp[1].y  = cosine * distanceVect.y - sine * distanceVect.x;

      PVector[] vTemp = {
        new PVector(), new PVector()
      };

      vTemp[0].x  = cosine * velocity.x + sine * velocity.y;
      vTemp[0].y  = cosine * velocity.y - sine * velocity.x;
      vTemp[1].x  = cosine * other.velocity.x + sine * other.velocity.y;
      vTemp[1].y  = cosine * other.velocity.y - sine * other.velocity.x;

      PVector[] vFinal = {  
        new PVector(), new PVector()
      };

      vFinal[0].x = ((m - other.m) * vTemp[0].x + 2 * other.m * vTemp[1].x) / (m + other.m);
      vFinal[0].y = vTemp[0].y;

      vFinal[1].x = ((other.m - m) * vTemp[1].x + 2 * m * vTemp[0].x) / (m + other.m);
      vFinal[1].y = vTemp[1].y;

      bTemp[0].x += vFinal[0].x;
      bTemp[1].x += vFinal[1].x;

      PVector[] bFinal = { 
        new PVector(), new PVector()
      };

      bFinal[0].x = cosine * bTemp[0].x - sine * bTemp[0].y;
      bFinal[0].y = cosine * bTemp[0].y + sine * bTemp[0].x;
      bFinal[1].x = cosine * bTemp[1].x - sine * bTemp[1].y;
      bFinal[1].y = cosine * bTemp[1].y + sine * bTemp[1].x;

      if (!other.player) {
        other.position.x = position.x + bFinal[1].x;
        other.position.y = position.y + bFinal[1].y;
      }

      if (!player) {
        position.add(bFinal[0]);

        velocity.x = cosine * vFinal[0].x - sine * vFinal[0].y;
        velocity.y = cosine * vFinal[0].y + sine * vFinal[0].x;
      }

      if (!other.player) {
        other.velocity.x = cosine * vFinal[1].x - sine * vFinal[1].y;
        other.velocity.y = cosine * vFinal[1].y + sine * vFinal[1].x;
      }

      if (player) {
        colorBall.playerTouchColor(other);
      } else if (other.player) {
        other.colorBall.playerTouchColor(this);
      }
    }
  }

  public void display() {
    if (!player)
      noStroke();
    else {
      stroke(255, 0, 0);
      strokeWeight(2);
    }
    fill(colorBall.color1, colorBall.color2, colorBall.color3);
    ellipse(position.x, position.y, radius*2, radius*2);
  }
}
public class Color {

  public int color1;
  public int color2;
  public int color3; 

  public Color (boolean player) {

    if (player) {
      color1 = 204;
      color2 = 204;
      color3 = 204;
    } else {
      color1 = 0 + (int)(Math.random() * 255);
      color2 = 0 + (int)(Math.random() * 255);
      color3 = 0 + (int)(Math.random() * 255);
    }
  }

  public void changeColor () {
    color1 = 0 + (int)(Math.random() * 255);
    color2 = 0 + (int)(Math.random() * 255);
    color3 = 0 + (int)(Math.random() * 255);
  }

  public void playerTouchColor (Ball other) {

    other.colorBall.color1 = color1;
    other.colorBall.color2 = color2;
    other.colorBall.color3 = color3;
  }
  
  public boolean checkColors (ArrayList<Ball> balls) {

    int flag = 0;

    for (Ball b : balls) {
      if ((b.colorBall.color1 == color1) && (b.colorBall.color1 == color1) && (b.colorBall.color1 == color1))
        flag++;
    }

    score.colorfulBalls = flag;

    if (flag == balls.size())
      return true;
    return false;
  }
}
public class Control {

  public PVector keyDown(PVector velocity) {
    if (key == 'w') {
      velocity.add(new PVector(0, -4));
    } else if (key == 'a') {
      velocity.add(new PVector(-4, 0));
    } else if (key == 's') {
      velocity.add(new PVector(0, 4));
    } else if (key == 'd') {
      velocity.add(new PVector(4, 0));
    }

    return velocity;
  }

  public void keyHolding() {
  }

  public PVector keyUp(PVector velocity) {
    if (key == 'w') {
      velocity.sub(new PVector(0, -4));
    } else if (key == 'a') {
      velocity.sub(new PVector(-4, 0));
    } else if (key == 's') {
      velocity.sub(new PVector(0, 4));
    } else if (key == 'd') {
      velocity.sub(new PVector(4, 0));
    }
    
    return velocity;
  }
}
public class Keyboard {
  
  HashMap<Character, Boolean> keys;
  
  public Keyboard() {
    keys = new HashMap<Character, Boolean>();
  }
  
  public boolean isKeyDown(Character key) {
    if(keys.get(key) == null) {
      setKeyDown(key, false);
      return false;
    }
    
    if(keys.get(key) == true)
      return true;
    
    return false;
  }
  
  public void setKeyDown(Character key, Boolean pressed) {
    keys.put(key, pressed);
  }
  
}
public class Score {
  
  String score;
  
  int timer;
  int points = 200;
  
  int colorfulBalls = 0;
  
  int lastColorfulBalls = 0;
  int lastNumOfBalls = 0;
  
  boolean timerFlag = true;
  
  public void updateScore (int balls) {
   
    timer = millis();
    timer /= 1000;
    
    score = "Balls in play: " + balls + "; Time: " + timer + " seconds; Scored Points: " + points + ".";
    textFont(loadFont("font.vlw"));
    textSize(30);
    fill(255);
    text(score, 0, 590);
    
  }
  
  public int timer () {
   
    return millis()/1000;
  }
  
  public void calculatePoints(int numOfBalls) {
    if (lastColorfulBalls > colorfulBalls) {
      points += 100;
      lastColorfulBalls = colorfulBalls;
    }
    
    if (lastNumOfBalls < numOfBalls) {
      points -= 50;
      lastNumOfBalls = numOfBalls;
    }
    
    if ((timer%2 == 0) && (timer>=2) && timerFlag) {
    points--;
    timerFlag = !timerFlag;
  } else if (!timerFlag) {
    if (timer%2 != 0)
      timerFlag = !timerFlag;
  }
    
  }
  
}
  public void settings() {  size(800, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Colorful" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
