import processing.serial.*;
import cc.arduino.*;

public class ArduinoColorful {
  Arduino a;
  
  void captureMovement () {
    int movementX = a.analogRead(0);
    int movementY = a.analogRead(1);
    
    println(movementX, movementY);
    
    if ( movementX > 300 ) {
      if (keyboard.isKeyDown('d') == false) {
        keyboard.setKeyDown('d', true);
        balls.get(0).velocity = control.keyDown('d', balls.get(0).velocity);
      }
    } else if ( movementX < 200 ) {
      if (keyboard.isKeyDown('a') == false) {
        keyboard.setKeyDown('a', true);
        balls.get(0).velocity = control.keyDown('a', balls.get(0).velocity);
        
      }
    } else if ( (movementX > 200) && (movementX < 300) ){
      keyboard.setKeyDown('a', false);
      keyboard.setKeyDown('d', false);
      balls.get(0).velocity = control.keyUp('a', balls.get(0).velocity);
      balls.get(0).velocity = control.keyUp('d', balls.get(0).velocity);
      
    }
    
    if ( movementY > 300) {
      if (keyboard.isKeyDown('w') == false) {
        keyboard.setKeyDown('w', true);
        balls.get(0).velocity = control.keyDown('w', balls.get(0).velocity);
        
      }
    } else if ( movementY < 200 ) {
      if (keyboard.isKeyDown('s') == false) {
        keyboard.setKeyDown('s', true);
        balls.get(0).velocity = control.keyDown('s', balls.get(0).velocity);
        
      }
    } else if ( (movementY > 200) && (movementY < 300) ) {
      keyboard.setKeyDown('s', false);
      keyboard.setKeyDown('w', false);
      balls.get(0).velocity = control.keyUp('w', balls.get(0).velocity);
      
      balls.get(0).velocity = control.keyUp('s', balls.get(0).velocity);
      
    }
    
    println(balls.get(0).velocity);
    
    /*
    if ( (movement > 400) && (movement < 550) ) {
      balls.get(0).velocity = control.keyUp('a', balls.get(0).velocity);
      keyboard.setKeyDown('a', false);
      balls.get(0).velocity = control.keyUp('d', balls.get(0).velocity);
      keyboard.setKeyDown('d', false);
    }
    */
    
  }
}