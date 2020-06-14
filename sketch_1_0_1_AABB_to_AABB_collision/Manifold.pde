class Manifold{
  Object A;
  Object B;
  float penetration;
  PVector normal;
  
  Manifold(Object A, Object B){
    this.A = A;
    this.B = B;
  }
}
