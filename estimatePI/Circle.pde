class Circle {
  float diam;
  
  Circle(float d) {
    diam = d; 
  }
  
  void update(){
    noFill();
    stroke(200, 100, 100);
    ellipse(width/2, height/2, diam, diam);
  } 
  
}
