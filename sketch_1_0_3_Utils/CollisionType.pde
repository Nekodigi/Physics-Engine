boolean CirclevsCircle(Manifold m){
  Circle A = (Circle)m.A;
  Circle B = (Circle)m.B;
  
  //Vector from A to B
  PVector n = PVector.sub(B.pos, A.pos);
  
  float r = A.radius + B.radius;
  //square n scala
  if(PVector.dot(n, n) > r*r)
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

boolean AABBvsAABB(Manifold m){
  Object A = m.A;
  Object B = m.B;
  
  //Vector from A to B
  PVector n = PVector.sub(B.pos, A.pos);
  
  AABB abox = (AABB)A;
  AABB bbox = (AABB)B;
  
  //Calculate half extents along x axis for each object
  PVector amin = abox.getMin();
  PVector amax = abox.getMax();
  PVector bmin = bbox.getMin();
  PVector bmax = bbox.getMax();
  
  float a_extent = (amax.x - amin.x) / 2;
  float b_extent = (bmax.x - bmin.x) / 2;
  
  //Calculate overlap on x axis
  float x_overlap = a_extent + b_extent - abs(n.x);
  
  //SAT test on x axis
  if(x_overlap > 0){
   //Calculate half extent along x axis for each object
   a_extent = (amax.y - amin.y) / 2;
   b_extent = (bmax.y - bmin.y) / 2;
   
   //Calculate overlap on y axis
   float y_overlap = a_extent + b_extent - abs(n.y);
   
   //SAT test on y axis
   if(y_overlap > 0){
     //Find out which axis is axis of least penetration
     if(x_overlap < y_overlap){
       //Point towards B knowing that n point from A to B
       if(n.x < 0){
         m.normal = new PVector(-1, 0);
       }else{
         m.normal = new PVector(1, 0);
       }
       m.penetration = x_overlap;
     }else{
       //Point toward B knowing that n point from A to B
       if(n.y < 0){
         m.normal = new PVector(0, -1);
       }else{
         m.normal = new PVector(0, 1);
       }
       m.penetration = y_overlap;
     }
     return true;
   }
 }
 return false;
}

boolean AABBvsCircle(Manifold m){
  AABB A = (AABB)m.A;
  Circle B = (Circle)m.B;
  
  //Vector form A to B
  PVector n = PVector.sub(B.pos, A.pos);
  
  //Closest point on A to center of B
  PVector closest = n.copy();
  
  //Calculate half extents along each axis
  PVector amin = A.getMin();
  PVector amax = A.getMax();
  float x_extent = (amax.x - amin.x) / 2;
  float y_extent = (amax.y - amin.y) / 2;
  
  //Clamp point to edges of the AABB
  closest.x = constrain(closest.x, -x_extent, x_extent);
  closest.y = constrain(closest.y, -y_extent, y_extent);
  
  boolean inside = false;
  
  //Circle is inside the AABB, so we need to clamp the circle's center
  //to closest edge
  if(n == closest){
    inside = true;
    
    //Find closest axis
    if(abs(n.x) > abs(n.y)){
      //Clamp to closest extent
      if(closest.x > 0)
        closest.x = x_extent;
      else
        closest.x = -x_extent;
      
    }else{//y axis is shorter
      //Clamp to closest extent
      if(closest.y > 0)
        closest.y = y_extent;
      else
        closest.y = -y_extent;
      
    }
  }
  PVector normal = PVector.sub(n, closest);
  float d = normal.magSq();
  float r = B.radius;
  //Early out of the redius is hsorter than distance to closest point and
  //Circle not inside AABB
  if(d > r * r && !inside){
    return false;}
    
  //Avoided sqrt until we needed
  d = sqrt(d);
  
  //Collision normal needs to be flipperd to point outside if circle was
  //inside the AABB
  if(inside){
    m.normal = PVector.mult(normal, -1).normalize();
    m.penetration = r - d;
  }else{
    m.normal = normal.normalize();
    m.penetration = r - d;
  }
  
  return true;
}
