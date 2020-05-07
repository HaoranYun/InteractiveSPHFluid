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
  
  boolean newAdded = false;
  
  Particle(float x, float y){
    pos= new PVector(x,y);
    prevPos = pos;
    vel = new PVector(0,0);
    acc = new PVector(0,0);
    force = new PVector(0,0);
    particleShape = createShape(ELLIPSE,pos.x,pos.y,space,space);
    beginShape();
    noStroke();
    endShape();
    particleShape.setFill(color(50,150,200,200));
    
    neighbors = new  ArrayList<Particle>();
    neighbors_q= new  ArrayList<Float>();
    rho = 0;
    rho_near = 0;
  }
  
  
  void Update(){
    prevPos = pos.copy();

    pos.add(vel);
    pos.add(force);
    
    
    force = new PVector(0,-G*mass);
    
    vel = PVector.sub(pos,prevPos);
    float velMax = 2;
    float speed = vel.mag();
    if(speed > velMax*velMax){
      vel = PVector.mult(vel,0.3);
    }
    
    checkBoard();
    if(pos.x < 50) force.x -= (pos.x -50)/10;
    if(pos.x > width-50) force.x -= (pos.x -width +50)/10;
    if(pos.y >height -50) force.y -= (pos.y -height +50)/10;
    if(pos.y < 0) force.y -= (pos.y -0)/10;
    
    if(pos.y > height){
      println(force);
    }
    
    PVector trans =  PVector.sub(pos,prevPos);
    particleShape.setFill(color(50,150,trans.mag()*20+150,200));
    particleShape.translate(trans.x,trans.y);
    
    
    hashTable[hashBucket(pos.x,pos.y)].add(this);
    
  }
  
  void checkBoard(){
    
    if(newAdded && pos.x > bd.posx && pos.x < bd.posx+bd.w && pos.y > bd.posy - space && pos.y < bd.posy + space ) force.y -= (pos.y - bd.posy +space)/10;
      
  }
  

  
  
}
