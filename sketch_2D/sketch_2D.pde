import controlP5.*;
ControlP5 cp5;
Slider abc;

float G = -0.05;
float NeighborRadius = 30;
float density = 1000;
float space = 10;
float dt = 0.02;
float restDensity = 3;
float k = space/1000;
float k_near = k *10;
float Viscosity = 0.05;
float beta = 0.000;


int N = 100;
ArrayList<Particle>  fluid = new ArrayList<Particle>();

PShape groupShape;

float kernelRadius = 0.06;
float KERNEL_POLY6_COEF, KERNEL_SPIKY_GRAD_COEF,KERNEL_VISCO_LAP_COEF;

float[] rho;
float[] rho_near;
float[] press;
float[] press_near;

boolean pause = false;
ArrayList<Particle> tempParticles = new ArrayList<Particle>();
ArrayList<PVector> tempForce = new ArrayList<PVector>();



void setup(){
  
  size(800,500,P3D);
  cp5 = new ControlP5(this);
  //cp5.addSlider("Viscosity")
  //   .setPosition(100,50)
  //   .setRange(0,0.5)
  //   .setSliderMode(Slider.FLEXIBLE)
  //   ;
  //cp5.getController("Visocosity").getValueLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  //cp5.getController("Visocosity").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  

  int count = 0;
  groupShape = createShape(PShape.GROUP);
  
  for(int i = 200; i < 400; i += space*1.2){
    for(int j = 200; j < 400; j += space*1.2){
      count ++;
      Particle curr = new Particle(i,j);  
      fluid.add(curr);
      groupShape.addChild(curr.particleShape);
    }
  }
  N = count;
  
  
  //rho = new float[N];
  //rho_near = new float[N];
  //press = new float[N];
  //press_near = new float[N];
  
  //color B = color(50,150,200);
  //PShape test = createShape(ELLIPSE,width/2,height/2,30,30);
  //test.setFill(B);
  //groupShape.addChild(test);
  
}



void draw(){
  
  
  background(0);
  
  if(!pause){
  for(int i = 0; i < N; i++){
    fluid.get(i).Update();
  }
  
  findNeighbors();
  GetPressure();
  GetPressureForce();
  GetViscosity();
  }
  fill(color(100,200,100));
  stroke(color(60,200,100));
  shape(groupShape);
  
  rect(width-50+space,50,space,height-100 + 2*space);
  rect(0 + 50 -2*space,50,space,height-100 + 2*space);
  rect(0 + 50 -2*space,height - 50 + space ,width-50-2*space,space);
  

  rect(10,10,50,60);
}

void initializeParams() {
  KERNEL_POLY6_COEF = 4.0 / (PI * sq(kernelRadius));
  KERNEL_SPIKY_GRAD_COEF = -30.0 / (PI * pow(kernelRadius, 3.0));
  KERNEL_VISCO_LAP_COEF = 20.0 / (3.0 * PI * pow(kernelRadius, 4.0));
  //calcParticleMass();
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
  PVector mouse = new PVector(x,y);
  for(int i = 0; i < N; i ++){
    Particle curr = fluid.get(i);
    PVector dirc = PVector.sub(mouse,curr.pos);
    float dist = dirc.mag();
    if(dist < 100){
      tempParticles.add(curr);
      line(x,y,curr.pos.x,curr.pos.y);
      curr.force.add(dirc.mult(100-dist).limit(0.1));
    }
  }
  
}

void keyPressed(){
  if(key == 'p'){
    pause = !pause;
  }
}

void mouseDragged(){
  findParticleInRange(mouseX, mouseY);
}
