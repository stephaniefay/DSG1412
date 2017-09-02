public class Score {
  
  int timer;
  String score;
  
  public void updateScore () {
   
    timer = millis();
    timer /= 1000;
    
    println(timer);
    
  }
  
  
}