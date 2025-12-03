int brushSize = 8;
color brushColor = color(0); // Black

void setup() {
  size(1000, 700);
  background(255);
}

void draw(){
  if (mousePressed){
    stroke(brushColor);
    strokeWeight(brushSize);
    line(pmouseX, pmouseY, mouseX, mouseY);
  }
}
