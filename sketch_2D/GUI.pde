class GUI{
  Slider vis;
  Slider massSlider;
  Slider fluxSlider;
  
  CheckBox tapCheckBox;
  CheckBox blobCheckBox;
  CheckBox recordCheckBox;
  CheckBox hashCheckBox;
  
  GUI(){
    
    vis = new Slider("Viscosity",65,130,Viscosity);
    vis.setRange(0,0.05,0.001);
  
    massSlider = new Slider("Mass",65,155,mass);
    massSlider.setRange(1,10,1);
    
    fluxSlider= new Slider("Flux",65,180,flux);
    fluxSlider.setRange(2,5,1);
    
    tapCheckBox= new CheckBox("Tap On/Off",65,40);
    
    blobCheckBox = new CheckBox("Blob On/Off",65,15);
    
    hashCheckBox = new CheckBox("Spatial Data Structure",65,90);
    
    recordCheckBox =  new CheckBox("Recording",65,65);
    
  }
  
  void Update(){
    //draw panel
    
    
    
    fill(50,150,200,200);
    rect(60,5,160,220,10);
    
    fluxSlider.listen();
    fluxSlider.update();
    flux = fluxSlider.value;
    
    
    vis.listen();
    vis.update();
    Viscosity = vis.value;
    restDensity = Viscosity * 150 + 2;
    //if(hashCheckBox.isChecked) mass = mass*4;
  
    tapCheckBox.listen();
    tapCheckBox.update();
  
    blobCheckBox.listen();
    blobCheckBox.update();
  
    massSlider.listen();
    massSlider.update();
  
  
    recordCheckBox.listen();
    recordCheckBox.update();
  
    mass = massSlider.value;
    
    hashCheckBox.listen();
    hashCheckBox.update();
    
    fill(255);
    text("Particle Number: "+ fluid.size(),65,220);
    text("Frame Rate: "+ frameRate,65,205);
    

    
  }
   
}

class Slider{
  String name;
  float x2D;
  float y2D;
  float diameter = 10;
  float valMax, valMin,value,len;
  boolean isDragged;
  float s_increment;
  
  
  Slider(String s, float x, float y,float val ){
    
    name = s;
    
    x2D = x;
    y2D = y;
    
    len = 100;

    value = val;
    
  }
  void setRange(float min, float max, float increment){
    valMax= max;
    valMin= min;
    s_increment = increment;
  }
  
  void update(){

    if (isDragged) 
    {value = (mouseX-x2D)*(valMax-valMin)/len + valMin;}
    
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
    text(txt, int(x2D), int(y2D-1) );
    textAlign(LEFT, CENTER);
    text(String.format("%.3f", value) ,int(x2D+len), y2D+1 );
    
    fill(100); noStroke();
    rect(x2D,y2D,len- 0.5*diameter,diameter,diameter);
    // Bar Indentation
    fill(50);
    rect(x2D+1,y2D+0.2*diameter,(len-1.0*diameter),0.5*diameter);
    // Bar Positive Fill
    fill(200,200,200,200);
    rect(x2D+1,y2D+0.2*diameter,(len-1.0*diameter)*(value-valMin)/(valMax-valMin),0.5*diameter,0.5*diameter);
    
    // Slider Circle
    noStroke();
    //fill(100,100,100, 225);
    //if ( hover() ) fill(00,100,100, 255);
    //ellipse(x2D+0.5*diameter+(len-1.0*diameter)*(value-valMin)/(valMax-valMin),y3D,0.5*diameter,0.5*diameter);
  }
  
  void listen() {
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

    if( mouseY > (y2D-10) && mouseY < (y2D+10) && 
        mouseX > (x2D) && mouseX < (x2D + len) ) {
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
  float w,h;
  boolean Clicked;
  boolean isChecked;
  
  CheckBox(String s, float x, float y){
    
    name = s;
    
    x2D = x;
    y2D = y;
    
    isChecked = false;
    Clicked = false;
    w = 20;
    h = 20;
    
  }
  
  void listen(){
    //if(mousePressed && hover() ) {
    //  isChecked = !isChecked;
    //}
  }
  
  void released(){
    if(hover()){
      isChecked = !isChecked;
      if(name.equals( "Tap On/Off")) 
      {
        TAPON = !TAPON;
        if(TAPON){
          tapCol = color(50,150,200,200);
        }
        else tapCol = color(255);
      }

    }
    
  }
  
  boolean hover() {

    if( mouseY > (y2D) && mouseY < (y2D + h) && 
        mouseX > (x2D) && mouseX < (x2D + w) ) {
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
    text(txt, int(x2D + 30), int(y2D+15) );
    
    fill(100);
    rect(x2D,y2D,w,h);
    
    if(isChecked){
         fill(200,200,200,200);
         circle(x2D+w/2,y2D+h/2,w*0.75);
    }
    
  }

}
