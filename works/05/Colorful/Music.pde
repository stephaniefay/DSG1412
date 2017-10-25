public class Music {

  SoundFile sample;
  Amplitude rms;
  
  float scale=5;
  float smooth_factor=0.25;
  float sum;
  
  int Bcolor;
 
  void drawBackground () {
    noStroke();
    colorMode(HSB);
    if (Bcolor >= 255)  Bcolor=0;  else  Bcolor++;
    fill(Bcolor, 255, 255);
    
    
    sum += (rms.analyze() - sum) * smooth_factor;  
    float rms_scaled=sum*(height/2)*scale;
    ellipse(width/2, height/2, rms_scaled, rms_scaled);
  }
  
  
}