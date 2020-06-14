boolean CirclevsCircle(Manifold m){
  Circle A = (Circle)m.A;
  Circle B = (Circle)m.B;
  
  //Vector from A to B
  PVector n = PVector.sub(B.pos, A.pos);
  
  float r = A.radius + B.radius;
  //square n scala
  if(PVector.dot(n, n) > r * r)
    return false;
    
  //Calculate have collided, now compute manifold
  float d = n.mag();
  
  //if distance is difference between radius is not zero
  if(d != 0){
    //Distance is difference between radius and distance
    m.penetration = r - d;
    
    //Utilize our d since we performed sqrt on it already within Length()
    //Points from A to B, and is a unit vector
    m.normal = n.normalize();
    //Circles are same position
  }else{
    //Choose random (but consistant) values
    m.penetration = A.radius;
    m.normal = new PVector(1, 0);
  }
  return true;
}
