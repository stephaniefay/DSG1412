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
    text(score, 0, 390);
  }

  public int timer () {

    return millis()/1000;
  }

  public void calculatePoints(int numOfBalls) {
    if (colorfulBalls > lastColorfulBalls) {
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
    
    if (points < 0)
      points = 0;
    
  }  
}