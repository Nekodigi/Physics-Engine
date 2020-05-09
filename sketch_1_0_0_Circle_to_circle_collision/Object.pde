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
  }
  
  abstract void show();
}

class Circle extends Object{
  float radius;
  
  Circle(PVector pos, PVector vel, float mass, float restitution, float radius){
    super(pos, vel, mass, restitution);
    this.radius = radius;
  }
  
  void show(){
    ellipse(pos.x, pos.y, radius*2, radius*2);
  }
}
