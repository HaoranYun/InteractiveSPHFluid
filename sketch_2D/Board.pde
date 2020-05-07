class Board {
  float posx;
  float posy;
  float w,h ;
  
  Board(float x, float y){
    posx = x;
    posy = y;
    w = 160;
    h = 10;
  }
  
  
  void Update(){
    if(mousePressed && hover() ) {
      posx += (mouseX -pmouseX);
      posy += (mouseY -pmouseY);
    }
    fill(255,200,0);
    rect(posx,posy,w,h);
  }
  
  
  boolean hover() {
    if( mouseY > (posy-h) && mouseY < (posy + h) && 
        mouseX > (posx-w) && mouseX < (posx + w) ) {
      return true;
    } else {
      return false;
    }
  }
}
