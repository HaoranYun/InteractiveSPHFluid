class GUI{
}

class Slider{
  String name;
  float x2D;
  float y2D;
  float diameter = 5;
  float x3D,y3D,z3D;
  float valMax, valMin,value,len;
  boolean isDragged;
  float s_increment;
  
  
  Slider(String s, float x, float y,float val ){
    
    name = s;
    x3D = x;
    y3D = y;
    
    x2D = screenX(x3D,y3D,0);
    y2D = screenY(x3D,y3D,0);
    
    len = 20;

    value = val;
    
  }
  void setRange(float min, float max, float increment){
    valMax= max;
    valMin= min;
    s_increment = increment;
  }
  
  void update(){
    x2D = screenX(x3D,y3D,0);
    y2D = screenY(x3D,y3D,0);
    
    float otherEnd  = screenX(x3D + len,y3D,0);
    float screenLen = x2D - otherEnd;
    if (isDragged) 
    {value = (x2D-mouseX)*(valMax-valMin)/screenLen + valMin;
  println(value);}
    
    checkLimit();
    if (value % s_increment < s_increment/2) {
      value = s_increment*int(value/s_increment);
    } else {
      value = s_increment*(1+int(value/s_increment));
    }
    
    strokeWeight(1);
    fill(255);
    textAlign(LEFT, BOTTOM);
    String txt = name;
    text(txt, int(x3D), int(y3D-1),0 );
    textAlign(LEFT, CENTER);
    text(String.format("%.3f", value) ,int(x3D+len), y3D+1,0 );
    
    fill(100); noStroke();
    rect(x3D,y3D,len- 0.5*diameter,0.3*diameter,0.3*diameter);
    // Bar Indentation
    fill(50);
    rect(x3D+1,y3D+0.05*diameter,(len-1.0*diameter),0.15*diameter);
    // Bar Positive Fill
    fill(150);
    rect(x3D+1,y3D+0.05*diameter,(len-1.0*diameter)*(value-valMin)/(valMax-valMin),0.15*diameter,0.15*diameter);
    
    // Slider Circle
    noStroke();
    //fill(100,100,100, 225);
    //if ( hover() ) fill(00,100,100, 255);
    //ellipse(x2D+0.5*diameter+(len-1.0*diameter)*(value-valMin)/(valMax-valMin),y3D,0.5*diameter,0.5*diameter);
  }
  
  void listen() {
    x2D = screenX(x3D,y3D,0);
    y2D = screenY(x3D,y3D,0);
    if(mousePressed && hover() ) {
      isDragged = true;
    }
    else{isDragged = false;}
  }
  
  
  void checkLimit() {
    if(value < valMin) value = valMin;
    if(value > valMax) value = valMax;
  }
  
  boolean hover() {
    x2D = screenX(x3D,y3D,0);
    y2D = screenY(x3D,y3D,0);
    float otherEnd  = screenX(x3D + len,y3D,0);
    if( mouseY > (y2D-10) && mouseY < (y2D+10) && 
        mouseX > (x2D) && mouseX < (otherEnd) ) {
      println("t");
      return true;
    } else {
      return false;
    }
  }
  
}
