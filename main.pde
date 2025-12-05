import g4p_controls.*;

Tool currentTool;

float brushSize = 10;
color currentColor = color(0); // Black\

ArrayList<PImage> undoStack = new ArrayList<PImage>();
ArrayList<PImage> redoStack = new ArrayList<PImage>();
PImage snapshot;

void setup() {
  size(1000, 700);
  createGUI();
  background(255);
  
  currentTool = new PencilTool(brushSize, currentColor); // Pencil as default
}

void startAction() {
  snapshot = get();
  undoStack.add(snapshot);
  redoStack.clear();
}

void draw(){
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
