import g4p_controls.*;

Tool currentTool;

float brushSize = 10;
color currentColor = color(0); // Black

void setup() {
  size(1000, 700);
  createGUI();
  background(255);
  
  currentTool = new PencilTool(brushSize, currentColor); // Pencil as default
}

void draw(){
  if (currentTool != null) {
    currentTool.preview();
  }
}

void mouseDragged() {
  if(currentTool != null){
    currentTool.mouseDragged();
  }
}

void mousePressed(){
  if(currentTool != null) {
    currentTool.mousePressed();
  }
}

void mouseReleased() {
  if(currentTool != null) {
    currentTool.mouseReleased();
  }
}
