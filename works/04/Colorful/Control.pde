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
    } else if (key == 'm') {
      special.useSpecial();
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