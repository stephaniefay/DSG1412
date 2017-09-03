public class Keyboard {
  
  HashMap<Character, Boolean> keys;
  
  public Keyboard() {
    keys = new HashMap<Character, Boolean>();
  }
  
  public boolean isKeyDown(Character key) {
    if(keys.get(key) == null) {
      setKeyDown(key, false);
      return false;
    }
    
    if(keys.get(key) == true)
      return true;
    
    return false;
  }
  
  public void setKeyDown(Character key, Boolean pressed) {
    keys.put(key, pressed);
  }
  
}