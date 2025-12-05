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
  if (mousePressed){
    currentTool.mouseDragged();
  }
}
