/////**
//// * ControlP5 Slider. Horizontal and vertical sliders, 
//// * with and without tick marks and snap-to-tick behavior.
//// * by andreas schlegel, 2010
//// */

/////**
////* ControlP5 Slider
////*
////* Horizontal and vertical sliders, 
////* With and without tick marks and snap-to-tick behavior.
////*
////* find a list of public methods available for the Slider Controller
////* at the bottom of this sketch.
////*
////* by Andreas Schlegel, 2012
////* www.sojamo.de/libraries/controlp5
////*
////*/

////import controlP5.*;

////ControlP5 cp5;
////int myColor = color(0,0,0);

//////int sliderValue = 100;
////int sliderTicks1 = 100;
////int sliderTicks2 = 30;
////Slider abc;

////void setup() {
////  size(700,400);
////  noStroke();
////  cp5 = new ControlP5(this);
  
////  // add a horizontal sliders, the value of this slider will be linked
////  // to variable 'sliderValue' 
////  cp5.addSlider("sliderValue")
////     .setPosition(100,50)
////     .setRange(0,255)
////     ;
  
////  // create another slider with tick marks, now without
////  // default value, the initial value will be set according to
////  // the value of variable sliderTicks2 then.
////  cp5.addSlider("sliderTicks1")
////     .setPosition(100,140)
////     .setSize(20,100)
////     .setRange(0,255)
////     .setNumberOfTickMarks(5)
////     ;
     
     
////  // add a vertical slider
////  cp5.addSlider("slider")
////     .setPosition(100,305)
////     .setSize(200,20)
////     .setRange(0,200)
////     .setValue(128)
////     ;
  
////  // reposition the Label for controller 'slider'
////  cp5.getController("slider").getValueLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
////  cp5.getController("slider").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  

////  cp5.addSlider("sliderTicks2")
////     .setPosition(100,370)
////     .setWidth(400)
////     .setRange(255,0) // values can range from big to small as well
////     .setValue(128)
////     .setNumberOfTickMarks(7)
////     .setSliderMode(Slider.FLEXIBLE)
////     ;
////  // use Slider.FIX or Slider.FLEXIBLE to change the slider handle
////  // by default it is Slider.FIX
  

////}

////void draw() {
////  background(sliderTicks1);

////  //fill(sliderValue);
////  rect(0,0,width,100);
  
////  fill(myColor);
////  rect(0,280,width,70);
  
////  fill(sliderTicks2);
////  rect(0,350,width,50);
  
////}

//////void slider(float theColor) {
//////  myColor = color(theColor);
//////  println("a slider event. setting background to "+theColor);
//////}












/////**
////* ControlP5 Slider
////*
////*
////* find a list of public methods available for the Slider Controller
////* at the bottom of this sketch.
////*
////* by Andreas Schlegel, 2012
////* www.sojamo.de/libraries/controlp5
////*
////*/

/////*
////a list of all methods available for the Slider Controller
////use ControlP5.printPublicMethodsFor(Slider.class);
////to print the following list into the console.

////You can find further details about class Slider in the javadoc.

////Format:
////ClassName : returnType methodName(parameter type)

////controlP5.Slider : ArrayList getTickMarks() 
////controlP5.Slider : Slider setColorTickMark(int) 
////controlP5.Slider : Slider setHandleSize(int) 
////controlP5.Slider : Slider setHeight(int) 
////controlP5.Slider : Slider setMax(float) 
////controlP5.Slider : Slider setMin(float) 
////controlP5.Slider : Slider setNumberOfTickMarks(int) 
////controlP5.Slider : Slider setRange(float, float) 
////controlP5.Slider : Slider setScrollSensitivity(float) 
////controlP5.Slider : Slider setSize(int, int) 
////controlP5.Slider : Slider setSliderMode(int) 
////controlP5.Slider : Slider setTriggerEvent(int) 
////controlP5.Slider : Slider setValue(float) 
////controlP5.Slider : Slider setWidth(int) 
////controlP5.Slider : Slider showTickMarks(boolean) 
////controlP5.Slider : Slider shuffle() 
////controlP5.Slider : Slider snapToTickMarks(boolean) 
////controlP5.Slider : Slider update() 
////controlP5.Slider : TickMark getTickMark(int) 
////controlP5.Slider : float getValue() 
////controlP5.Slider : float getValuePosition() 
////controlP5.Slider : int getDirection() 
////controlP5.Slider : int getHandleSize() 
////controlP5.Slider : int getNumberOfTickMarks() 
////controlP5.Slider : int getSliderMode() 
////controlP5.Slider : int getTriggerEvent() 
////controlP5.Controller : CColor getColor() 
////controlP5.Controller : ControlBehavior getBehavior() 
////controlP5.Controller : ControlWindow getControlWindow() 
////controlP5.Controller : ControlWindow getWindow() 
////controlP5.Controller : ControllerProperty getProperty(String) 
////controlP5.Controller : ControllerProperty getProperty(String, String) 
////controlP5.Controller : Label getCaptionLabel() 
////controlP5.Controller : Label getValueLabel() 
////controlP5.Controller : List getControllerPlugList() 
////controlP5.Controller : PImage setImage(PImage) 
////controlP5.Controller : PImage setImage(PImage, int) 
////controlP5.Controller : PVector getAbsolutePosition() 
////controlP5.Controller : PVector getPosition() 
////controlP5.Controller : Slider addCallback(CallbackListener) 
////controlP5.Controller : Slider addListener(ControlListener) 
////controlP5.Controller : Slider bringToFront() 
////controlP5.Controller : Slider bringToFront(ControllerInterface) 
////controlP5.Controller : Slider hide() 
////controlP5.Controller : Slider linebreak() 
////controlP5.Controller : Slider listen(boolean) 
////controlP5.Controller : Slider lock() 
////controlP5.Controller : Slider plugTo(Object) 
////controlP5.Controller : Slider plugTo(Object, String) 
////controlP5.Controller : Slider plugTo(Object[]) 
////controlP5.Controller : Slider plugTo(Object[], String) 
////controlP5.Controller : Slider registerProperty(String) 
////controlP5.Controller : Slider registerProperty(String, String) 
////controlP5.Controller : Slider registerTooltip(String) 
////controlP5.Controller : Slider removeBehavior() 
////controlP5.Controller : Slider removeCallback() 
////controlP5.Controller : Slider removeCallback(CallbackListener) 
////controlP5.Controller : Slider removeListener(ControlListener) 
////controlP5.Controller : Slider removeProperty(String) 
////controlP5.Controller : Slider removeProperty(String, String) 
////controlP5.Controller : Slider setArrayValue(float[]) 
////controlP5.Controller : Slider setArrayValue(int, float) 
////controlP5.Controller : Slider setBehavior(ControlBehavior) 
////controlP5.Controller : Slider setBroadcast(boolean) 
////controlP5.Controller : Slider setCaptionLabel(String) 
////controlP5.Controller : Slider setColor(CColor) 
////controlP5.Controller : Slider setColorActive(int) 
////controlP5.Controller : Slider setColorBackground(int) 
////controlP5.Controller : Slider setColorCaptionLabel(int) 
////controlP5.Controller : Slider setColorForeground(int) 
////controlP5.Controller : Slider setColorValueLabel(int) 
////controlP5.Controller : Slider setDecimalPrecision(int) 
////controlP5.Controller : Slider setDefaultValue(float) 
////controlP5.Controller : Slider setHeight(int) 
////controlP5.Controller : Slider setId(int) 
////controlP5.Controller : Slider setImages(PImage, PImage, PImage) 
////controlP5.Controller : Slider setImages(PImage, PImage, PImage, PImage) 
////controlP5.Controller : Slider setLabelVisible(boolean) 
////controlP5.Controller : Slider setLock(boolean) 
////controlP5.Controller : Slider setMax(float) 
////controlP5.Controller : Slider setMin(float) 
////controlP5.Controller : Slider setMouseOver(boolean) 
////controlP5.Controller : Slider setMoveable(boolean) 
////controlP5.Controller : Slider setPosition(PVector) 
////controlP5.Controller : Slider setPosition(float, float) 
////controlP5.Controller : Slider setSize(PImage) 
////controlP5.Controller : Slider setSize(int, int) 
////controlP5.Controller : Slider setStringValue(String) 
////controlP5.Controller : Slider setUpdate(boolean) 
////controlP5.Controller : Slider setValueLabel(String) 
////controlP5.Controller : Slider setView(ControllerView) 
////controlP5.Controller : Slider setVisible(boolean) 
////controlP5.Controller : Slider setWidth(int) 
////controlP5.Controller : Slider show() 
////controlP5.Controller : Slider unlock() 
////controlP5.Controller : Slider unplugFrom(Object) 
////controlP5.Controller : Slider unplugFrom(Object[]) 
////controlP5.Controller : Slider unregisterTooltip() 
////controlP5.Controller : Slider update() 
////controlP5.Controller : Slider updateSize() 
////controlP5.Controller : String getAddress() 
////controlP5.Controller : String getInfo() 
////controlP5.Controller : String getName() 
////controlP5.Controller : String getStringValue() 
////controlP5.Controller : String toString() 
////controlP5.Controller : Tab getTab() 
////controlP5.Controller : boolean isActive() 
////controlP5.Controller : boolean isBroadcast() 
////controlP5.Controller : boolean isInside() 
////controlP5.Controller : boolean isLabelVisible() 
////controlP5.Controller : boolean isListening() 
////controlP5.Controller : boolean isLock() 
////controlP5.Controller : boolean isMouseOver() 
////controlP5.Controller : boolean isMousePressed() 
////controlP5.Controller : boolean isMoveable() 
////controlP5.Controller : boolean isUpdate() 
////controlP5.Controller : boolean isVisible() 
////controlP5.Controller : float getArrayValue(int) 
////controlP5.Controller : float getDefaultValue() 
////controlP5.Controller : float getMax() 
////controlP5.Controller : float getMin() 
////controlP5.Controller : float getValue() 
////controlP5.Controller : float[] getArrayValue() 
////controlP5.Controller : int getDecimalPrecision() 
////controlP5.Controller : int getHeight() 
////controlP5.Controller : int getId() 
////controlP5.Controller : int getWidth() 
////controlP5.Controller : int listenerSize() 
////controlP5.Controller : void remove() 
////controlP5.Controller : void setView(ControllerView, int) 
////java.lang.Object : String toString() 
////java.lang.Object : boolean equals(Object) 


////*/


///**
// * ControlP5 Controller on top of 3D
// * demonstrates how to use controlP5 controllers on top of a 
// * OpenGL 3D scene.
// *
// * by Andreas Schlegel, 2011
// * www.sojamo.de/libraries/controlP5
// *
// */



//import controlP5.*;
//import processing.opengl.*;

//ControlP5 cp5;
//ControlGroup messageBox;
//int messageBoxResult = -1;
//String messageBoxString = "";
//float t;

//void setup() {
//  size(640,480,P3D);
//  cp5 = new ControlP5(this);
//  noStroke();
//  createMessageBox();
//  Button b = cp5.addButton("toggleBox",1,20,20,100,20);
//  b.setLabel("Toggle Box");
//  textFont(createFont("",30));
//}


//void draw() {
//  hint(ENABLE_DEPTH_TEST);
//  pushMatrix();
//  if(messageBox.isVisible()) {
//    background(128);
//  } else {
//    background(0);
//    fill(255);
//    text(messageBoxString,20,height-40);
//  }
  
//  translate(width/2,height/2,mouseX);
//  rotateY(t+=0.1);
//  fill(255);
//  rect(-50,-50,100,100);
//  popMatrix();
//  hint(DISABLE_DEPTH_TEST);
//  // in case yo uare using the camera or you have 
//  // changed the default camera setting, reset the camera
//  // to default by uncommenting the following line.
//  // camera();
//}



//void toggleBox(int theValue) {
//  if(messageBox.isVisible()) {
//    messageBox.hide();
//  } else {
//    messageBox.show();
//  }
//}


//void createMessageBox() {
//  // create a group to store the messageBox elements
//  messageBox = cp5.addGroup("messageBox",width/2 - 150,100,300);
//  messageBox.setBackgroundHeight(120);
//  messageBox.setBackgroundColor(color(0,100));
//  messageBox.hideBar();
  
//  // add a TextLabel to the messageBox.
//  Textlabel l = cp5.addTextlabel("messageBoxLabel","Some MessageBox text goes here.",20,20);
//  l.moveTo(messageBox);
  
//  // add a textfield-controller with named-id inputbox
//  // this controller will be linked to function inputbox() below.
//  Textfield f = cp5.addTextfield("inputbox",20,36,260,20);
//  //f.captionLabel().setVisible(false);
//  f.moveTo(messageBox);
//  f.setColorForeground(color(20));
//  f.setColorBackground(color(20));
//  f.setColorActive(color(100));
//  // add the OK button to the messageBox.
//  // the name of the button corresponds to function buttonOK
//  // below and will be triggered when pressing the button.
//  Button b1 = cp5.addButton("buttonOK",0,65,80,80,24);
//  b1.moveTo(messageBox);
//  b1.setColorBackground(color(40));
//  b1.setColorActive(color(20));
//  // by default setValue would trigger function buttonOK, 
//  // therefore we disable the broadcasting before setting
//  // the value and enable broadcasting again afterwards.
//  // same applies to the cancel button below.
//  b1.setBroadcast(false); 
//  b1.setValue(1);
//  b1.setBroadcast(true);
//  b1.setCaptionLabel("OK");
//  // centering of a label needs to be done manually 
//  // with marginTop and marginLeft
//  //b1.captionLabel().style().marginTop = -2;
//  //b1.captionLabel().style().marginLeft = 26;
  
//  // add the Cancel button to the messageBox. 
//  // the name of the button corresponds to function buttonCancel
//  // below and will be triggered when pressing the button.
//  Button b2 = cp5.addButton("buttonCancel",0,155,80,80,24);
//  b2.moveTo(messageBox);
//  b2.setBroadcast(false);
//  b2.setValue(0);
//  b2.setBroadcast(true);
//  b2.setCaptionLabel("Cancel");
//  b2.setColorBackground(color(40));
//  b2.setColorActive(color(20));
//  //b2.captionLabel().toUpperCase(false);
//  // centering of a label needs to be done manually 
//  // with marginTop and marginLeft
//  //b2.captionLabel().style().marginTop = -2;
//  //b2.captionLabel().style().marginLeft = 16;
//}

//// function buttonOK will be triggered when pressing
//// the OK button of the messageBox.
//void buttonOK(int theValue) {
//  println("a button event from button OK.");
//  //messageBoxString = ((Textfield)cp5.controller("inputbox")).getText();
//  messageBoxResult = theValue;
//  messageBox.hide();
//}


//// function buttonCancel will be triggered when pressing
//// the Cancel button of the messageBox.
//void buttonCancel(int theValue) {
//  println("a button event from button Cancel.");
//  messageBoxResult = theValue;
//  messageBox.hide();
//}

//// inputbox is called whenever RETURN has been pressed 
//// in textfield-controller inputbox 
//void inputbox(String theString) {
//  println("got something from the inputbox : "+theString);
//  messageBoxString = theString;
//  messageBox.hide();
//}

import controlP5.*;

import peasy.*;

import processing.opengl.*;

PeasyCam cam;

PMatrix3D currCameraMatrix;

PGraphics3D g3;


int R = 40;

int G = 200;

int B = 200;


ControlP5 MyController;


color CL = #00FF1B;

int ON_OF = 0;


void setup() {


size(800, 800, OPENGL);


g3 = (PGraphics3D)g;


cam = new PeasyCam(this, 200,300,100, 500);


MyController = new ControlP5(this);


MyController.addSlider("R",0,255,128,20,100,10,100);

//MyController.controller("R").setColorForeground(#FC0000);


MyController.addSlider("G",0,255,128,70,100,10,100);

//MyController.controller("G").setColorForeground(#0BFC00);


MyController.addSlider("B",0,255,128,120,100,10,100);

//MyController.controller("B").setColorForeground(#002CFC);


//MyController.addButton("On_Of",10,20,60,80,20);


MyController.setAutoDraw(false);


}


void draw(){


if( ON_OF == 1){

strokeWeight(0);

}


else{

strokeWeight(1);}


background(R,G,B);

noFill();


stroke(R);

pushMatrix();

translate(300,200,40);

sphere(50);

popMatrix();


gui();


//MyController.controller("On_Of").setColorBackground(CL);


}


void gui() {

currCameraMatrix = new PMatrix3D(g3.camera);

camera();

MyController.draw();

g3.camera = currCameraMatrix;

}


public void On_Of(){

if(ON_OF == 0){

ON_OF = 1;

CL = #FF0022;

}


else{

ON_OF = 0;

CL = #00FF1B;

}

}
