abstract class Object{
  PVector pos, vel = new PVector(), acc = new PVector();
  float restitution;
  float mass, invmass;//mass, 1 / mass
  
  Object(PVector pos, PVector vel, float mass, float restitution){
    this.pos = pos;
    this.vel = vel;
    this.mass = mass;
    this.restitution = restitution;
    invmass = 1./mass;
  }
  
  void update(){
    acc.add(0, g);
    vel.add(PVector.mult(acc, dt));
    pos.add(PVector.mult(vel, dt));
    acc = new PVector();
  }
  
  abstract void show();
}

class Circle extends Object{
  float radius;
  
  Circle(float radius, PVector pos, PVector vel, float mass, float restitution){
    super(pos, vel, mass, restitution);
    this.radius = radius;
  }
  
  void show(){
    ellipse(pos.x, pos.y, radius*2, radius*2);
  }
}

class AABB extends Object{
  float w, h;
  
  AABB(PVector min, PVector max, PVector vel, float mass, float restitution){
    super(PVector.add(min, max).div(2), vel, mass, restitution);
  }
 
  AABB(float w, float h, PVector pos, PVector vel, float mass, float restitution){
    super(pos, vel, mass, restitution);
    this.w = w;
    this.h = h;
  }
  
  PVector getMin(){
    return PVector.sub(pos, new PVector(w/2, h/2));
  }
  
  PVector getMax(){
    return PVector.add(pos, new PVector(w/2, h/2));
  }
  
  void show(){
    rect(pos.x-w/2, pos.y-h/2, w, h);
  }
}
