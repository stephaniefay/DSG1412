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
    m = radius*.1;
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

  public void checkCollision(Ball other, Score s) {

    PVector distanceVect = PVector.sub(other.position, position);

    float distanceVectMag = distanceVect.mag();

    float minDistance = radius + other.radius;

    if (distanceVectMag < minDistance) {
      float distanceCorrection = (minDistance-distanceVectMag)/2.0;
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
    colorMode(RGB);
    if (!player)
      noStroke();
    else {
      stroke(255, 0, 0);
      strokeWeight(2);
    }
    fill(colorBall.color1, colorBall.color2, colorBall.color3);
    ellipse(position.x, position.y, radius*2, radius*2);
  }
  
  public void stopBalls() {
    for (Ball b : balls) {
      if (!b.player) {
       b.velocity = new PVector(0,0);
      }
    }
  }
}