//based on this site https://gamedevelopment.tutsplus.com/tutorials/how-to-create-a-custom-2d-physics-engine-the-basics-and-impulse-resolution--gamedev-6331

float g = 9.8;
float dt = 0.1;
ArrayList<Object> objects = new ArrayList<Object>();


void setup(){
  size(500, 500);
  //fullScreen();
  Object floor = new AABB(width/2, 50, new PVector(width/2, height-50), new PVector(0, 0), 0, 1);
  objects.add(floor);
  objects.add(new AABB(100, 100, new PVector(width/2+width/4, 0), new PVector(0, 0), 1, 1));
  objects.add(new Circle(100, new PVector(width/2, height/2), new PVector(0, 0), 4, 1));
  frameRate(60);
}

void mousePressed(){
  if(mouseButton == LEFT){
    float r = random(10, 100);
    objects.add(new Circle(r, new PVector(mouseX, mouseY), new PVector(0, 0), 4, 1));
  }else if(mouseButton == RIGHT){
    float wh = random(10, 100);
    objects.add(new AABB(wh, wh, new PVector(mouseX, mouseY), new PVector(0, 0), 4, 1));
  }
}

void draw(){
  fill(0, 10);
  rect(0, 0, width, height);
  fill(255);
  //background(0);
  for(Object A : objects){
    for(Object B : objects){
      if(A != B){//Check if neither is passive
        Manifold m = new Manifold(A, B);
        if(A.collide(m)){
          ResolveCollision(m);
          PositionalCorrection(m);
        }
      }
    }
    A.update();
    A.show();
  }
}
