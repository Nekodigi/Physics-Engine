void ResolveCollision(Manifold m){
  //Extract values from Manifold
  Object A = m.A;
  Object B = m.B;
  PVector normal = m.normal;
  
  //Calculate relative velocity
  PVector rv = PVector.sub(B.vel, A.vel);
  
  //Calculate relative velocity in terms of the normal direction
  float velAlongNormal = PVector.dot(rv, normal);
  
  if(velAlongNormal > 0){
    return;
  }
  
  //Calculate restitusion
  float e = min(A.restitution, B.restitution);
  
  //Calculate impulse scalar
  float j = -(1 + e) * velAlongNormal;
  j /= A.invmass + B.invmass;
  
  //Apply impulse
  PVector impulse = PVector.mult(normal, j);
  A.vel.sub(PVector.mult(impulse, A.invmass));
  B.vel.add(PVector.mult(impulse, B.invmass));
}

void PositionalCorrection(Manifold m){
  //Extract values from Manifold
  Object A = m.A;
  Object B = m.B;
  float penetration = m.penetration;
  PVector normal = m.normal;
  
  final float percent = 0.2;//usually 20% to 80%
  final float slop = 0.01;//usually 0.01 to 0.1
  PVector correction = PVector.mult(normal, max(penetration - slop, 0.) / (A.invmass + B.invmass) * percent);
  A.pos.sub(PVector.mult(correction, A.invmass));
  B.pos.add(PVector.mult(correction, B.invmass));
}
