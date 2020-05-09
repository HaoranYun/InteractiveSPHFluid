class Board {
  float posx,posz;
  float posy;
  float w,h ;
  
  Board(float x, float y, float z){
    posx = x;
    posy = y;
    posz = z;
    w = 300;
    h = 300;
    
  }
  
  
  void Update(){
    if(mousePressed && hover() ) {
      //posx += (mouseX -pmouseX);
      //posy += (mouseY -pmouseY);
    }
    //fill(40,150,255);
    //pushMatrix();
    //translate(posx,posy,posz);
    //rotateX(PI/2);
    //rect(0,0,w,w);
    //popMatrix();
    
     beginShape();
    texture(tapImg);
    vertex(posx, posy,posz,  0, 0);
    vertex(posx + w, posy,posz, tapImg.width, 0);
    vertex(posx + w, posy,posz + w,tapImg.width, tapImg.height);
    vertex(posx, posy,posz + w, 0, tapImg.height);
    endShape();
    
    pushMatrix();
    translate(posx+w/2,posy+10,posz+w/2);
    box(w,19,w);
    popMatrix();
  }
  
  
  boolean hover() {
    if( mouseY > (posy-h) && mouseY < (posy + h) && 
        mouseX > (posx-w) && mouseX < (posx + w) ) {
      return true;
    } else {
      return false;
    }
  }
  
  
   void drawWall(){
  
    noStroke();
    noFill();

    pushMatrix();
    fill(100,100,100,50);
    translate(posx,posy,posz);
    rotateY(-PI/2);
    rect(0,-w,w,w);
    translate(0,0,-w);
    rect(0,-w,w,w);
    popMatrix();
    
    pushMatrix();
    fill(100,100,100,50);
    translate(posx,posy,posz);
    rect(0,-w,w,w);
    translate(0,0,w);
    rect(0,-w,w,w);
    popMatrix();

  }
}
