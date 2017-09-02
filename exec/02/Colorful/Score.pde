public class Score {
  
  int timer;
  String score;
  
  public void updateScore (int balls) {
   
    timer = millis();
    timer /= 1000;
    
    score = "Balls in play: " + balls + "; Time: " + timer + " seconds.";
    textFont(loadFont("font.vlw"));
    textSize(30);
    fill(255);
    text(score, 0, 590);
    
  }
  
  public int timer () {
   
    return millis()/1000;
  }
  
}