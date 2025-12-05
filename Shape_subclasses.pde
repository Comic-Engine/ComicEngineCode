class RectangleShape extends Shape {
  RectangleShape(float x1, float y1, float x2, float y2, color c, float size){
    super(x1, y1, x2, y2, c, size);
  }

  void draw(){
    stroke(c);
    strokeWeight(size);
    noFill();
    rectMode(CENTER);
    float w = abs(x2 - x1) * 2;
    float h = abs(y2 - y1) * 2;
    rect(x1, y1, w, h);
  }
}
