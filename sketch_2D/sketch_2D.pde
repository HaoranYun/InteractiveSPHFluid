
import java.util.*; 


float G = -0.01; // -0.05
int NeighborRadius = 30;
float density = 1000;
float space = 10; // 10 
float dt = 0.02;
float restDensity = 10; // 3
float k = space/1000;
float k_near = k *10;
float Viscosity = 0.05;
float beta = 0.000;



ArrayList<Particle>  fluid = new ArrayList<Particle>();

PShape groupShape;

float kernelRadius = 0.06;

float[] rho;
float[] rho_near;
float[] press;
float[] press_near;

boolean pause = false;
ArrayList<Particle> tempParticles = new ArrayList<Particle>();
ArrayList<PVector> tempForce = new ArrayList<PVector>();



PImage tapImg;
color tapCol = color(255,255,255);

GUI gui;
float mass = 5;
float flux = 4;


boolean TAPON = false;
Board bd;
int hashN = 200;
ArrayList<Integer>[] hashTable;
int iter = 0;



void setup(){
  
  size(800,500,P2D);

  tapImg = loadImage("tap.png");
  
  gui = new GUI();
  bd = new Board(width-200,200);
  
  groupShape = createShape(PShape.GROUP);
  
  resetWaterBall();
 
  hashTable= new ArrayList[hashN];
  for(int i = 0; i < hashN; i ++){
    hashTable[i] = new ArrayList<Integer>();
  }
  
}



void draw(){
  iter ++;
  
  background(0);
 
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
  
  if(gui.blobCheckBox.isChecked){
    drawBlob();
  }
  else {
    shape(groupShape);
  }
  
  
  rect(width-50+space,50,space,height-100 + 2*space);
  rect(0 + 50 -2*space,50,space,height-100 + 2*space);
  rect(0 + 50 -2*space,height - 50 + space ,width-50-2*space,space);
  rect(50-2*space,40,35,10);


  beginShape();
  texture(tapImg);
  vertex(width -120, 0, 0, 0);
  vertex(width-30, 0,  tapImg.width, 0);
  vertex(width -30, 90, tapImg.width, tapImg.height);
  vertex(width - 120, 90, 0, tapImg.height);
  endShape();
  
   //40 40 1.5  iter30
  if(TAPON && iter%10 == 0){
   int count = fluid.size();
   for(int i = 0; i < flux; i ++){
    //for(int j = 0; j < flux; j ++){
      float x = width -120 + i*space*1.2*(0.5-Viscosity)/0.5;
      float y = 80;
      Particle curr = new Particle(x,y,count);  
      fluid.add(curr);
      groupShape.addChild(curr.particleShape);
      curr.newAdded = true;
      count ++;
    //}
   }
  }
  
  // if particle number is over flow 
  
  if(fluid.size() > 3000){
    TAPON = false;
    gui.tapCheckBox.isChecked = false;
  }
  

  bd.Update();
  
  gui.Update();
  
  // drag by mouse 
  stroke(tapCol);
  for(int i = 0; i <tempParticles.size(); i++){ 
    line(mouseX,mouseY,tempParticles.get(i).pos.x,tempParticles.get(i).pos.y);
  }
  
  //save images
  if(gui.recordCheckBox.isChecked)saveFrame("output2/test_####.png");
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
    
    int maxh = curr.i + curr.j +2;
    for(int h = curr.i + curr.j -2; h < maxh; h ++ ){
      int hashH = h % hashN;
      if(hashH > -1 && hashH < hashN){
        temp.addAll(hashTable[hashH]);
      }
    }
    
    //Collections.sort(temp);

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

void GetDensity(){
  
}

void GetPressure(){
  for(int i = 0; i< fluid.size(); i ++){
      Particle curr = fluid.get(i);
      curr.pressure = k*(curr.rho - restDensity);
      curr.pressure_near = k_near * curr.rho_near;
  }
  
  
}




void GetPressureForce(){
   for(int i = 0; i< fluid.size(); i ++){
    Particle curr = fluid.get(i);   
    curr.pressure = k*(curr.rho - restDensity);
    curr.pressure_near = k_near * curr.rho_near;
    
    
    PVector dx = new PVector(0,0);
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
      //println(curr.force);
      if(u >0){
        float multiplex = (rij.mag() - q)*(Viscosity*u + beta*u*u);
        PVector I = PVector.mult(rij_norm,multiplex);
        PVector halfI = PVector.mult(I,0.5);
        curr.vel.sub(halfI);
        other.vel.add(halfI);
        //println(I);
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
    PVector dirc = PVector.sub(mouse,curr.pos);
    float dist = dirc.mag();
    if(dist < 100){
      tempParticles.add(curr);
      
      curr.force.add(dirc.mult(100-dist).limit(0.1));
    }
  }
  
}



void drawBlob(){
  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      //if(hashTable[(x%NeighborRadius +y%NeighborRadius)%hashN].size() <30)
      //{ continue;
      //}
      int index = x + y * width;
      float sum = 0;
      for (Particle p : fluid) {
        float d = dist(x, y, p.pos.x, p.pos.y);
        if(d < 1.5 * space){
          sum += 80*space/d;;
        }
      }
      pixels[index] = color(0, 0, sum);
    }
  }

  updatePixels();
}

void resetWaterBall(){
  int count = 0;
  for(int i = 200; i < 400; i += space*1.2){
    for(int j = 200; j < 400; j += space*1.2){

      Particle curr = new Particle(i,j,count);  
      fluid.add(curr);
      groupShape.addChild(curr.particleShape);
      count ++;
    }
  }
}


void keyPressed(){
  if(key == 'p'){
    pause = !pause;
  }
}

void mouseReleased(){
  gui.tapCheckBox.released();
  gui.recordCheckBox.released();
  gui.blobCheckBox.released();
  gui.hashCheckBox.released();
  tempParticles.clear();
}


void mouseDragged(){
  findParticleInRange(mouseX, mouseY);
}
