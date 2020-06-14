//based on this site https://gamedevelopment.tutsplus.com/tutorials/how-to-create-a-custom-2d-physics-engine-the-basics-and-impulse-resolution--gamedev-6331

float g = 0;
float dt = 0.1;
Object A, B;


void setup(){
  size(500, 500);
  //             pos                                     vel                mass restitution radius
  A = new AABB(200, 200, new PVector(width/2-width/4, height/2), new PVector(10, 5), 4, 1);
  B = new AABB(100, 100, new PVector(width/2+width/4, height/2), new PVector(-10, -1), 1, 1);
}

void draw(){
  background(0);
  A.update();
  B.update();
  Manifold m = new Manifold(A, B);
  if(AABBvsAABB(m)){
    ResolveCollision(m);
    PositionalCorrection(m);
  }
  A.show();
  B.show();
}
