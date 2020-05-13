class GUI{
  Slider vis;
  Slider radiusSlider;
  Slider fluxSlider;
  
  
  CheckBox wallCheckBox;
  CheckBox tapCheckBox;
  CheckBox hashCheckBox;
  CheckBox recordCheckBox;

  float startH = 350;
  float startX = -210;
  float W = 130; 
  float H =150;
  
  GUI(){
    
    vis = new Slider("Viscosity",startX+10,startH+10,Viscosity);
    vis.setRange(0,0.1,0.001);
    
    
    wallCheckBox = new CheckBox("Wall", startX+10, startH+55);
    wallCheckBox.isChecked = true;
    
    tapCheckBox = new CheckBox("Tap", startX+10, startH+70);
  
    radiusSlider = new Slider("Radius",startX+10,startH+40,space);
    radiusSlider.setRange(1,10,1);
    
    fluxSlider= new Slider("Flux",startX+10,startH+25,flux);
    fluxSlider.setRange(2,5,1);
    
    
    hashCheckBox = new CheckBox("Spatial Data Structure",startX+10,startH+85);
    //hashCheckBox.isChecked =true;
    
    recordCheckBox = new CheckBox("Recording",startX+10,startH+100);
    
    
  }
  
  void Update(){
    //draw panel
     
    fill(100,100,100,150);
    pushMatrix();
    translate(0,0,z);
    rect(startX,startH,W,H,10);
    popMatrix();
    
    
    vis.listen();
    vis.update();
    Viscosity = vis.value;
    restDensity = Viscosity * 150 + 2;

    
    wallCheckBox.update();
    tapCheckBox.update();
    
    radius = radiusSlider.value;
    radiusSlider.listen();
    radiusSlider.update();
    space = radiusSlider.value;
    
    
    fluxSlider.listen();
    fluxSlider.update();
    
    flux = fluxSlider.value;
  
    hashCheckBox.update();
    recordCheckBox.update();
    
    fill(255);
    text("Particle Number: "+ fluid.size(),startX+10,startH + H -30,z);
    text("Frame Rate: "+ frameRate,startX+10,startH + H -20,z);
    text("Press 'p' to pause/start.",startX+10,startH + H -10,z);

    
  }
   
}


class Slider{
  String name;
  float x2D;
  float y2D;
  float diameter = 15;
  float x3D,y3D,z3D;
  float valMax, valMin,value,len;
  boolean isDragged;
  float s_increment;
  

  Slider(String s, float x, float y,float val ){
    
    name = s;
    x3D = x;
    y3D = y;
    
    x2D = screenX(x3D,y3D,z);
    y2D = screenY(x3D,y3D,z);
    
    len = 80;

    value = val;
    
  }
  void setRange(float min, float max, float increment){
    valMax= max;
    valMin= min;
    s_increment = increment;
  }
  
  void update(){
    x2D = screenX(x3D,y3D,z);
    y2D = screenY(x3D,y3D,z);
    
    float otherEnd  = screenX(x3D + len,y3D,z);
    float screenLen = x2D - otherEnd;
    if (isDragged) 
    {value = (x2D-mouseX)*(valMax-valMin)/screenLen + valMin;
    }
    
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
    text(txt, int(x3D), int(y3D-1),z );
    textAlign(LEFT, CENTER);
    text(String.format("%.3f", value) ,int(x3D+len+5), y3D+3,z );
    
    pushMatrix();
    translate(0,0,z);
    fill(200); noStroke();
    rect(x3D,y3D,len,0.4*diameter);

    fill(250);
    circle(x3D+(len-0.1*diameter)*(value-valMin)/(valMax-valMin), y3D+0.2*diameter,0.5*diameter);
    popMatrix();

    noStroke();
 
  }
  
  void listen() {
    x2D = screenX(x3D,y3D,z);
    y2D = screenY(x3D,y3D,z);
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
    float otherEnd  = screenX(x3D + len,y3D,z);
    float otherEndH =screenY(x3D,y3D+0.4*diameter,z);
    if( mouseY > (y2D) && mouseY < (otherEndH) && 
        mouseX > (x2D) && mouseX < (otherEnd) ) {
      return true;
    } else {
      return false;
    }
  }
  
}


class CheckBox{
  
    String name;
  float x2D;
  float y2D;
  float x3D;
  float y3D;
  float w,h;
  boolean Clicked;
  boolean isChecked;
  
  
  
  CheckBox(String s, float x, float y){
    
    name = s;
    
    x3D = x;
    y3D = y;
    
    x2D = screenX(x3D,y3D,z);
    y2D = screenY(x3D,y3D,z);
    
    isChecked = false;
    Clicked = false;
    w = 10;
    h = 10;
    
  }
  
  
  void released(){
    x2D = screenX(x3D,y3D,z);
    y2D = screenY(x3D,y3D,z);
    if(hover()){
      isChecked = !isChecked;
    }
    
  }
  
  boolean hover() {
    float screenW = screenX(x3D + w,y3D,z);
    float screenH = screenY(x3D ,y3D + h,z);
    if( mouseY > (y2D ) && mouseY < (screenH) && 
        mouseX > (x2D) && mouseX < (screenW) ) {
      return true;
    } else {
      return false;
    }
  }
  void update(){
    strokeWeight(1);
    fill(255);
    textAlign(LEFT, BOTTOM);
    String txt = name;
    text(txt, int(x3D +5+w), int(y3D +3 + w/2),z);
    
    pushMatrix();
    translate(0,0,z);
    fill(200);
    rect(x3D,y3D,w,h,0.3);
    
    if(isChecked){
         fill(250);
         circle(x3D+w/2,y3D+h/2,w*0.75);
    }
    popMatrix();
    
  }

  
}
