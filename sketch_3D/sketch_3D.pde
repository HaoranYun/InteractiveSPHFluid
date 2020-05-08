
import processing.opengl.*;




float boxW = 20;

float G = -0.05;
float space = 3;
float NeighborRadius = 1.5*space;
float dt = 0.02;
float restDensity = 10;
float k = space/1000;
float k_near = k *10;
float Viscosity = 0.1;
float beta =0.0;
Camera cam;

int N = 1000;
ArrayList<Particle>  fluid = new ArrayList<Particle>();

PShape groupShape;



boolean pause = false;
ArrayList<Particle> tempParticles = new ArrayList<Particle>();
ArrayList<PVector> tempForce = new ArrayList<PVector>();

Slider vis;

PFont font; 

int hashN = 200;
ArrayList<Particle>[] hashTable;

void setup(){
  
  size(800,500,P3D);
  //size(1200, 800, OPENGL);
  cam = new Camera();
  font = loadFont("./data/AppleSDGothicNeo-Heavy-120.vlw"); 
  
  vis = new Slider("viscosity",-75,-40,Viscosity);
  vis.setRange(0,2,0.001);
  textFont(font,3);
  
  int count = 0;
  groupShape = createShape(PShape.GROUP);
  
  for(int i = 0; i < N; i++){
    count++;
    float x = random(-boxW/2,boxW/2);
    float y = random(-boxW,-boxW/2);
    float z = random(-boxW/2.0,boxW/2.0);
    Particle curr = new Particle(x,y,z);  
    fluid.add(curr);
    groupShape.addChild(curr.particleShape);
  }
  
  N = count;
  
  hashTable = new ArrayList[hashN];
  
  
}



void draw(){
  
  
  background(253,236,92);
  fill(100,100,100,100); noStroke();
 rect(-80,-50,40,50,5);
  directionalLight(255,255,255,0,1,0);
  directionalLight(255,255,255,0,0,-1);
  
  cam.Update( 1.0/frameRate );

  vis.listen();
  vis.update();
  Viscosity = vis.value;
  
  
  if(!pause){
    for(int i = 0; i < N; i++){
       fluid.get(i).Update();
     }
  
    findNeighbors();
    GetPressure();
    GetPressureForce();
    GetViscosity();
  }
 
  stroke(color(60,200,100));
  noFill();
  
  shape(groupShape);
  //drawBlob();
  pushMatrix();
  fill(100,100,100,100);
  translate(0,space+1,0);
  box(boxW*2,1,boxW*2);
  popMatrix();

}




void findNeighbors(){
  float d = 0;
  float dn = 0;
  float len, q, q2, q3;
  for(int i = 0; i < N; i++ ){
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
    
    curr.rho += d;
    curr.rho_near += dn;
   
  }
}


void GetDensity(){
  
}

void GetPressure(){
  for(int i = 0; i< N; i ++){
      Particle curr = fluid.get(i);
      curr.pressure = k*(curr.rho - restDensity);
      curr.pressure_near = k_near * curr.rho_near;
  }
  
}

void GetPressureForce(){
   for(int i = 0; i< N; i ++){
    Particle curr = fluid.get(i);   
    curr.pressure = k*(curr.rho - restDensity);
    curr.pressure_near = k_near * curr.rho_near;
    
    
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
  for(int i = 0; i< N; i ++){
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
  PVector mouse = new PVector(x,y,0);
  for(int i = 0; i < N; i ++){
    Particle curr = fluid.get(i);
    PVector dirc = PVector.sub(mouse,curr.pos);
    float dist = dirc.mag();
    if(dist < 100){
      tempParticles.add(curr);
      line(x,y,curr.pos.x,curr.pos.y);
      curr.force.add(dirc.mult(100-dist).limit(1));
    }
  }
  
}

void drawBlob(){
  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int index = x + y * width;
      float sum = 0;
      for (Particle p : fluid) {
        float x2 = screenX(p.pos.x,p.pos.y,p.pos.z);
        float y2 = screenY(p.pos.x,p.pos.y,p.pos.z);
        float d = dist(x, y, x2, y2);
        if(d < 30 * space){
          sum += 60*space/d;;
        }
      }
      pixels[index] = color(0, 0, sum);
    }
  }

  updatePixels();
}
void keyPressed(){
  if(key == 'p'){
    pause = !pause;
  }
   cam.HandleKeyPressed();
}

void mouseDragged(){
  //findParticleInRange(mouseX, mouseY);
}

void keyReleased()
{
  cam.HandleKeyReleased();
}
