public class Control {

  public PVector keyDown(char charac, PVector velocity) {
    if (charac == 'w') {
        velocity.y = -4;
    } else if (charac == 'a') {
        velocity.x = -4;
    } else if (charac == 's') {
        velocity.y = 4;
    } else if (charac == 'd') {
        velocity.x = 4;
    } else if (charac == 'm') {
      special.useSpecial();
    }

    return velocity;
  }

  public void keyHolding() {
  }

  public PVector keyUp(char charac, PVector velocity) {
    if (charac == 'w') {
      velocity.sub(new PVector(0, -4));
    } else if (charac == 'a') {
      velocity.sub(new PVector(-4, 0));
    } else if (charac == 's') {
      velocity.sub(new PVector(0, 4));
    } else if (charac == 'd') {
      velocity.sub(new PVector(4, 0));
    }
    
    return velocity;
  }
}