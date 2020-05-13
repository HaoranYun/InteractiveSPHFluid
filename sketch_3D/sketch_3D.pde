
import java.util.*; 

float boxW = 20;
float G = -0.03; // -0.01
int NeighborRadius = 30;
float density = 1000;
float space = 10; // 10 
float dt = 1;
float restDensity = 10; // 3
float K = space/1000;
float K_near = K *10;
float Viscosity = 0.05;
float beta = 0.000;

int[] backgroundColor = new int[5];
int colorIdx = 0;

ArrayList<Particle>  fluid = new ArrayList<Particle>();

PShape groupShape;

float kernelRadius = 0.06;


boolean pause = false;
ArrayList<Particle> tempParticles = new ArrayList<Particle>();
ArrayList<PVector> tempForce = new ArrayList<PVector>();


Camera cam;
PImage tapImg;
color tapCol = color(255,255,255);



GUI gui;
float radius = 10;
float flux = 2;


boolean TAPON = false;
Board bd;
int hashN = 300;
ArrayList<Integer>[] hashTable;
int iter = 0;

PFont font;

float z = 600;
void setup(){
  
  size(800,450,P3D);
  cam = new Camera();
  tapImg = loadImage("grid.jpg");
  font = loadFont("./data/AppleSDGothicNeo-Heavy-120.vlw"); 
  textFont(font,8);
  gui = new GUI();
  bd = new Board(100,600,100);
  
  groupShape = createShape(PShape.GROUP);
  
  resetWaterBall();
 
  hashTable= new ArrayList[hashN];
  for(int i = 0; i < hashN; i ++){
    hashTable[i] = new ArrayList<Integer>();
  }
  
  backgroundColor[0] = #f4ad8e;
  backgroundColor[1] = #fcea7a;
  backgroundColor[2] = #7cf1d3;
  backgroundColor[3] = #e4aada;
  backgroundColor[4] = #9ceca4;
  
}



void draw(){
  iter ++;
  
  if(iter%50 == 0) colorIdx++;

  background(backgroundColor[colorIdx%5]);
  directionalLight(255,255,255,0,1,0);
  directionalLight(255,255,255,0,-0.2,-0.5);
  cam.Update( 1.0/frameRate );
  for(int i = 0; i < hashN; i ++){
    hashTable[i].clear();
  }
  
  if(!pause){
    for(int i = 0; i < fluid.size(); i++){
      fluid.get(i).Update();
    }
    
    if(gui.hashCheckBox.isChecked) findNeighborsHash();
    else findNeighbors();
    GetPressure();
    GetPressureForce();
    GetViscosity();
  }
  

  
  
  fill(tapCol);
  noStroke();
  
  shape(groupShape);
  
  
  //beginShape();
  //texture(tapImg);
  //vertex(width -120, 0, 0, 0);
  //vertex(width-30, 0,  tapImg.width, 0);
  //vertex(width -30, 90, tapImg.width, tapImg.height);
  //vertex(width - 120, 90, 0, tapImg.height);
  //endShape();
  
   //40 40 1.5  iter30
  if(gui.tapCheckBox.isChecked && iter%20 == 0){
   int count = fluid.size();
   for(int i = 0; i < flux; i ++){
     for(int j = 0; j < flux ; j ++){
       float x =  200+space * i * 5*(flux)/5;
       float y = 400;
       float z = 200 + space * j * 5*(flux)/5;
       Particle curr = new Particle(x,y,z,count);  
       fluid.add(curr);
       groupShape.addChild(curr.particleShape);
       count++;
     }
     
   }
  }
  
  // if particle number is over flow 
  
  if(fluid.size() > 1500){
   
    gui.tapCheckBox.isChecked = false;
  }
  

  bd.Update();
  
  gui.Update();
  
 if(gui.wallCheckBox.isChecked){
     bd.drawWall();
   }
  

  
  //save images
  if(gui.recordCheckBox.isChecked)saveFrame("output/test_####.png");
  

}





void findNeighbors(){
  float d = 0;
  float dn = 0;
  float len, q, q2, q3;
  for(int i = 0; i < fluid.size(); i++ ){
    d = 0;
    dn = 0;
    Particle curr = fluid.get(i);
    
    curr.neighbors.clear();
    curr.neighbors_q.clear();
    curr.rho = 0;
    curr.rho_near = 0;
    
    for(int j = 0; j < i; j ++){
      Particle other = fluid.get(j);
   
      float dist = PVector.sub(curr.pos,other.pos).mag();
      if(dist < NeighborRadius){
        len = dist;
        q = 1- len/NeighborRadius;
        q2 = q*q;
        q3 = q*q*q;
        d += q2;
        dn += q3;
        
        other.rho += q2;
        other.rho_near += q3;

        curr.neighbors.add(other);
        curr.neighbors_q.add(q);
      }
    }
    //println(curr.neighbors.size());
    curr.rho += d;
    curr.rho_near += dn;
   
  }
}


void findNeighborsHash(){
  float d = 0;
  float dn = 0;
  float len, q, q2, q3;
  ArrayList<Integer> temp;

  for(int i = 0; i < fluid.size(); i ++){
    temp = new ArrayList<Integer>();
    d = 0;
    dn = 0;
    Particle curr = fluid.get(i);
    
    curr.neighbors.clear();
    curr.neighbors_q.clear();
    curr.rho = 0;
    curr.rho_near = 0;

    int maxh = curr.i + curr.j +curr.k+3;
    for(int h = curr.i + curr.j +curr.k-3; h < maxh; h ++ ){
      int hashH = h % hashN;
      if(hashH > -1 && hashH < hashN){
        temp.addAll(hashTable[hashH]);
      }
    }
    

    for(int j : temp){
      Particle other = fluid.get(j);
      if(j >= curr.id) continue;
      
      float dist = PVector.sub(curr.pos,other.pos).mag();
      if(dist < NeighborRadius){

        len = dist;
        q = 1- len/NeighborRadius;
        q2 = q*q;
        q3 = q*q*q;
        d += q2;
        dn += q3;
        
        other.rho += q2;
        other.rho_near += q3;
        
        curr.neighbors.add(other);
        curr.neighbors_q.add(q);
       
      }
    }

    curr.rho += d;
    curr.rho_near += dn;
  }

  
}



void GetPressure(){
  for(int i = 0; i< fluid.size(); i ++){
      Particle curr = fluid.get(i);
      curr.pressure = K*(curr.rho - restDensity);
      curr.pressure_near = K_near * curr.rho_near;
  }
  
  
}




void GetPressureForce(){
   for(int i = 0; i< fluid.size(); i ++){
    Particle curr = fluid.get(i);   
    curr.pressure = K*(curr.rho - restDensity);
    curr.pressure_near = K_near * curr.rho_near;
    
    
    PVector dx = new PVector(0,0,0);
    int neighborSize = curr.neighbors.size();
    for (int j = 0; j < neighborSize; j ++){
      Particle other = curr.neighbors.get(j);
      PVector rij = PVector.sub(other.pos,curr.pos);
      PVector rij_norm = rij.copy().normalize();
      float q = curr.neighbors_q.get(j);
      float dm = (curr.pressure + other.pressure) * q +
                (curr.pressure_near + other.pressure_near)*q*q;
      PVector D = PVector.mult(rij_norm,dm);
      dx.add(D);
      other.force.add(D);
    }
    
    curr.force.sub(dx);
   }
  
}


void GetViscosity(){
  for(int i = 0; i< fluid.size(); i ++){
    Particle curr = fluid.get(i);   
    int neighborSize = curr.neighbors.size();
      for (int j = 0; j < neighborSize; j ++){
      Particle other = curr.neighbors.get(j);
      PVector rij = PVector.sub(other.pos,curr.pos);
      PVector rij_norm = rij.copy().normalize();
      float q = rij.mag()/NeighborRadius;
      PVector velDiff = PVector.sub(curr.vel, other.vel);
      float u = PVector.dot(velDiff,rij_norm);

      if(u >0){
        float multiplex = (rij.mag() - q)*(Viscosity*u + beta*u*u);
        PVector I = PVector.mult(rij_norm,multiplex);
        PVector halfI = PVector.mult(I,0.5);
        curr.vel.sub(halfI);
        other.vel.add(halfI);
      }
    }
  }
}

void UpdateFluid(){
  
}


void findParticleInRange(float x, float y){
  tempParticles.clear();
  PVector mouse = new PVector(x,y);
  for(int i = 0; i < fluid.size(); i ++){
    Particle curr = fluid.get(i);
    float p = screenX(curr.pos.x,curr.pos.y,curr.pos.z);
    float q = screenY(curr.pos.x,curr.pos.y,curr.pos.z);
    PVector dirc = PVector.sub(mouse,new PVector(p,q));
    float dist = dirc.mag();
    if(dist < 5*space){
      tempParticles.add(curr);
      curr.force.add(dirc.mult(100-dist).limit(0.2));
    }
  }
  
}




void resetWaterBall(){
  int count = fluid.size();
  for(int i = 200; i < 300; i += space*1.2){
    for(int j = 200; j < 300; j += space*1.2){
      for(int h = 200; h < 300;  h+= space*1.2){
        Particle curr = new Particle(i,j,h,count);  
        fluid.add(curr);
        groupShape.addChild(curr.particleShape);
        count ++;
      }
    }
  }
}




void keyPressed(){
  if(key == 'p'){
    pause = !pause;
    println(cam.position);
  }
  cam.HandleKeyPressed();
}

void keyReleased()
{
  cam.HandleKeyReleased();
}

void mouseReleased(){
  //gui.tapCheckBox.released();
  //gui.recordCheckBox.released();
  //gui.blobCheckBox.released();
  //gui.hashCheckBox.released();
  tempParticles.clear();
  gui.wallCheckBox.released();
  gui.tapCheckBox.released();
  gui.hashCheckBox.released();
  gui.recordCheckBox.released();
}


void mouseDragged(){
  findParticleInRange(mouseX, mouseY);
}
