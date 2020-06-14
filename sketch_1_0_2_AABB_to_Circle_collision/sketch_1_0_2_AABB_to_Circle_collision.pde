//based on this site https://gamedevelopment.tutsplus.com/tutorials/how-to-create-a-custom-2d-physics-engine-the-basics-and-impulse-resolution--gamedev-6331

float g = 0;
float dt = 0.1;
Object A, B;


void setup(){
  size(500, 500);
  A = new AABB(100, 100, new PVector(width/2, height/2), new PVector(0, 0), 1, 1);
  B = new Circle(100, new PVector(width/2-width/8, height/2+height/8), new PVector(0, 0), 4, 1);
}

void draw(){
  background(0);
  A.update();
  B.update();
  Manifold m = new Manifold(A, B);
  if(AABBvsCircle(m)){
    ResolveCollision(m);
    PositionalCorrection(m);
  }
  A.show();
  B.show();
}
