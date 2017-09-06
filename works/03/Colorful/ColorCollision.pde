public class Color {

  public int color1;
  public int color2;
  public int color3; 

  public Color (boolean player) {

    if (player) {
      color1 = 204;
      color2 = 204;
      color3 = 204;
    } else {
      color1 = 0 + (int)(Math.random() * 255);
      color2 = 0 + (int)(Math.random() * 255);
      color3 = 0 + (int)(Math.random() * 255);
    }
  }

  public void changeColor () {
    color1 = 0 + (int)(Math.random() * 255);
    color2 = 0 + (int)(Math.random() * 255);
    color3 = 0 + (int)(Math.random() * 255);
  }

  public void playerTouchColor (Ball other) {

    other.colorBall.color1 = color1;
    other.colorBall.color2 = color2;
    other.colorBall.color3 = color3;
  }
  
  public boolean checkColors (ArrayList<Ball> balls, Score score) {

    int flag = 0;

    for (Ball b : balls) {
      if ((b.colorBall.color1 == color1) && (b.colorBall.color1 == color1) && (b.colorBall.color1 == color1))
        flag++;
    }

    score.colorfulBalls = flag;
    println(flag);

    if (flag == balls.size())
      return true;
    return false;
  }
}