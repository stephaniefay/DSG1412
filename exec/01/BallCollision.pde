class Ball {
  PVector position;
  PVector velocity;
  
  int color1 = 204;
  int color2 = 204;
  int color3 = 204;

  float radius, m;

  Ball(float x, float y, float r_) {
    position = new PVector(x, y);
    velocity = PVector.random2D();
    velocity.mult(3);
    radius = r_;
    m = radius*.1;
  }

  void update() {
    position.add(velocity);
  }

  void checkBoundaryCollision() {
    
    int flag = 0;
    
    if (position.x > width-radius) {
      position.x = width-radius;
      velocity.x *= -1;
      flag += 1;
    } else if (position.x < radius) {
      position.x = radius;
      velocity.x *= -1;
      flag += 1;
    } else if (position.y > height-radius) {
      position.y = height-radius;
      velocity.y *= -1;
      flag += 1;
    } else if (position.y < radius) {
      position.y = radius;
      velocity.y *= -1;
      flag += 1;
    }
    
    if (flag > 0) {
      color1 = 0 + (int)(Math.random() * 255);
      color2 = 0 + (int)(Math.random() * 255);
      color3 = 0 + (int)(Math.random() * 255);
    }
    
  }

  void checkCollision(Ball other) {

    PVector distanceVect = PVector.sub(other.position, position);

    float distanceVectMag = distanceVect.mag();

    float minDistance = radius + other.radius;

    if (distanceVectMag < minDistance) {
      float distanceCorrection = (minDistance-distanceVectMag)/2.0;
      PVector d = distanceVect.copy();
      PVector correctionVector = d.normalize().mult(distanceCorrection);
      other.position.add(correctionVector);
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

      other.position.x = position.x + bFinal[1].x;
      other.position.y = position.y + bFinal[1].y;

      position.add(bFinal[0]);

      velocity.x = cosine * vFinal[0].x - sine * vFinal[0].y;
      velocity.y = cosine * vFinal[0].y + sine * vFinal[0].x;
      other.velocity.x = cosine * vFinal[1].x - sine * vFinal[1].y;
      other.velocity.y = cosine * vFinal[1].y + sine * vFinal[1].x;
      
      int chance = 1 + (int)(Math.random() * 2);
      
      if (chance%2 == 0){
        other.color1 = color1;
        other.color2 = color2;
        other.color3 = color3;
      }
      else {
        color1 = other.color1;
        color2 = other.color2;
        color3 = other.color3;
      }

      
    }
  }

  void display() {
    noStroke();
    fill(color1, color2, color3);
    ellipse(position.x, position.y, radius*2, radius*2);
  }
}