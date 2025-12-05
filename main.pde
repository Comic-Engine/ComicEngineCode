import g4p_controls.*;

Tool currentTool;

float brushSize;
color brushColor = color(0); // Black

void setup() {
  createGUI();
  size(1000, 700);
  background(255);
  
  currentTool = new PencilTool();
}

void draw(){
  if (mousePressed){
    currentTool.mouseDragged();
  }
}
