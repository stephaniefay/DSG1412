public class Special {

  int percentage;
  int timerSpecial;
  int lastSecond;
  int multiplier = 0;

  boolean ready = false;

  boolean isSpecialReady () {
    calculateSpecial();

    if (ready) return true;
    else return false;
  }

  void calculateSpecial() {
    timerSpecial = score.timer;
    if (timerSpecial == lastSecond) return;
    else {
      lastSecond = timerSpecial;
      if (percentage < 100) percentage += 5;
    }
    
    if ((!ready) && (percentage==100)) ready = !ready;
  }
  
  void useSpecial () {
    if (!ready) return;
    balls.get(0).stopBalls();
    
    percentage = 0;
    ready = !ready;
    
  }
  
}