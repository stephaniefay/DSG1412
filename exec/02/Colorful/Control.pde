public class Control {

  public PVector keyDown(PVector velocity) {
    print("key " + key + " down\n");


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
    print("holding key " + key + "\n");
  }

  public PVector keyUp(PVector velocity) {
    print("key " + key + " up\n");
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