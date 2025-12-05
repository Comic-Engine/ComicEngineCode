import g4p_controls.*;

float brushSize;
color brushColor = color(0); // Black

void setup() {
  size(1000, 700);
  createGUI();
  background(255);
}

void draw(){
  if (mousePressed){
    stroke(brushColor);
    strokeWeight(brushSize);
    line(pmouseX, pmouseY, mouseX, mouseY);
  }
}
