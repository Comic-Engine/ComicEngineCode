import g4p_controls.*;

Tool currentTool;

float brushSize = 10;
color baseColor = color(0);
color currentColor = color(0); // Black
float brightnessValue = 1.0;

boolean showGrid = true;
int gridSize = 50; // Pixels between grid lines

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
  if(showGrid){
    drawGrid();
  }
}

void drawGrid() {
  push(); // Save drawing settings
  stroke(200, 200, 200, 150); // Light gray, semi-transparent
  strokeWeight(1);
  
  // Vertical lines
  for(int x = 0; x < width; x += gridSize) {
    line(x, 0, x, height);
  }
  
  // Horizontal lines
  for(int y = 0; y < height; y += gridSize) {
    line(0, y, width, y);
  }
  
  pop(); // Restore drawing settings
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
