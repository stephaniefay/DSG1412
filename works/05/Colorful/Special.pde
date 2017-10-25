public class Special {

  int percentage;
  int timerSpecial;
  int lastSecond;
  int multiplier = 0;

  boolean ready = false;

  public boolean isSpecialReady () {
    calculateSpecial();

    if (ready) return true;
    else return false;
  }

  protected void calculateSpecial() {
    timerSpecial = score.timer;
    if (timerSpecial == lastSecond) return;
    else {
      lastSecond = timerSpecial;
      if (percentage < 100) percentage += 5;
    }
    
    if ((!ready) && (percentage==100)) ready = !ready;
  }
  
  public void useSpecial () {
    if (!ready) return;
    balls.get(0).stopBalls();
    
    percentage = 0;
    ready = !ready;
    
  }
  
  public void showSpecial () {
    colorMode(RGB);
    fill(204, 204, 0);
    rect(0,0,percentage*6, 20);
    
    String showPer = "Special: " + percentage + "%";
    textFont(loadFont("font.vlw"));
    textSize(25);
    fill(255);
    text(showPer, 0, 20);
    
  }
  
}