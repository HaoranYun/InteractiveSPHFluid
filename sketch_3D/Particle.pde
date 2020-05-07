class Particle{
  PVector acc;
  PVector vel;
  PVector pos;
  PVector prevPos;
  PShape particleShape;
  ArrayList<Particle> neighbors;
  ArrayList<Float> neighbors_q;
  float rho;
  float rho_near;
  float pressure;
  float pressure_near;
  PVector force;
  
  
  
  Particle(float x, float y, float z){
    pos= new PVector(x,y,z);
    prevPos = pos.copy();
    vel = new PVector(0,0,0);
    acc = new PVector(0,0,0);
    force = new PVector(0,0,0);
    particleShape = createShape(SPHERE,space);
    beginShape();
    noStroke();
    endShape();
    particleShape.translate(pos.x,pos.y,pos.z); 
    particleShape.setFill(color(50,150,200));
    //particleShape.setStroke(color(50,150,200));
    
    neighbors = new  ArrayList<Particle>();
    neighbors_q= new  ArrayList<Float>();
    rho = 0;
    rho_near = 0;
  }
  
  
  void Update(){
    prevPos = pos.copy();

    pos.add(vel);
    pos.add(force);
    
    force = new PVector(0,-G,0);
    
    vel = PVector.sub(pos,prevPos);
    float velMax = 2;
    float speed = vel.mag();
    if(speed > velMax){
      vel = PVector.mult(vel,0.5);
    }
    //if(pos.x < -boxW + space/2) force.x -= (pos.x + boxW-space/2);
    //if(pos.x > boxW-space/2) force.x -= (pos.x - boxW+ space/2);
    if(checkFloor() && pos.y > -space/2) force.y -= (pos.y + space/2);
    if(checkFloor() && pos.y < -boxW +space/2) force.y -= (pos.y +boxW-space/2);
    
    //if(pos.z > boxW - space/2) force.z -= (pos.z - boxW+ space/2);
    //if(pos.z <-boxW + space/2) force.z -= (pos.z + boxW-space/2);
    

    PVector trans =  PVector.sub(pos,prevPos);
    particleShape.translate(trans.x,trans.y,trans.z);  
  }
  
  boolean checkFloor(){
    if(pos.x < boxW-space/2 && pos.x > -boxW + space/2 && 
    pos.z < boxW - space/2 && pos.z >-boxW + space/2)
    return true;
    else return false;
  }
  
  
  
  
}
