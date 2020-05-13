
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
  float right,left,forward,backward,floor;
  
  
  int i,j,k,hashValue,id;
  
  Particle(float x, float y, float z,int ID){
    pos= new PVector(x,y,z);
    prevPos = pos.copy();
    vel = new PVector(0,0,0);
    acc = new PVector(0,0,0);
    force = new PVector(0,0,0);
    beginShape();
    noStroke();
    endShape();
    particleShape = createShape(SPHERE,space);
    particleShape.translate(pos.x,pos.y,pos.z); 
    particleShape.setFill(color(40,150,255,100));
    //particleShape.setStroke(color(50,150,200));
    
    neighbors = new  ArrayList<Particle>();
    neighbors_q= new  ArrayList<Float>();
    rho = 0;
    rho_near = 0;
    
    id = ID;
  }
  
  
  void Update(){
    prevPos = pos.copy();

    PVector test = vel.copy().mult(dt);
    test.add(force.copy().mult(dt));
    test.limit(space/3);
    pos.add(test);

    
    force = new PVector(0,-G,0);
    
    vel = PVector.sub(pos,prevPos);
    float velMax = 2;
    float speed = vel.mag();
    if(speed > velMax){
      vel = PVector.mult(vel,0.5);
    }
    
    boolean isOverBoard = overBoard();
    
    right = bd.posx + bd.w-space ;
    left = bd.posx+space;
    forward = bd.posz + bd.w-space ;
    backward = bd.posz+space;
    floor = 600 -space;

    if(!isOverBoard && gui.wallCheckBox.isChecked){
      if(pos.z < backward) force.z -= (pos.z -backward)/10;
      if(pos.z > forward) force.z -= (pos.z -forward)/10;
    
      if(pos.x < left) force.x -= (pos.x -left)/10;
      if(pos.x > right) force.x -= (pos.x -right)/10;
    }
    
    if(isOverBoard && pos.y >floor) force.y -= (pos.y -floor)/5;


    PVector trans =  PVector.sub(pos,prevPos);
    if(radius!=space) {
      int idx = groupShape.getChildIndex(particleShape);
      groupShape.removeChild(idx);
      particleShape = createShape(SPHERE,space);
      particleShape.translate(pos.x,pos.y,pos.z);
      particleShape.setFill(color(40,150,255,100));
      groupShape.addChild(particleShape);
    }

    particleShape.translate(trans.x,trans.y,trans.z); 
    
    i =(int) (pos.x/NeighborRadius);
    j = (int) (pos.y/NeighborRadius);
    k = (int)(pos.z/NeighborRadius);
    hashValue = (i + j + k) % hashN;
    if(hashValue > 0)hashTable[hashValue].add(this.id);
    
    
  }
  
  
  boolean overBoard(){
    if(pos.x >left && pos.x < right 
    && pos.z > backward && pos.z < forward 
    && pos.y < floor+5*space){
      return true;
    }
    else return false;   
  }
  
  
  
  
}
