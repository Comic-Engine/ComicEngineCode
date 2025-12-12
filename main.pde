import g4p_controls.*;

Tool currentTool;

float brushSize = 10;
color baseColor = color(0);
color currentColor = color(0); // Black
float brightnessValue = 1.0;

boolean showGrid = true;
float gridSize = 50.0; // Pixels between grid lines
PGraphics drawingLayer; // Seperate lauer for drawing (no grid)

ArrayList<PImage> undoStack = new ArrayList<PImage>();
ArrayList<PImage> redoStack = new ArrayList<PImage>();
PImage snapshot;

void setup() {
  size(1000, 700);
  createGUI();
  
  // Create a separate graphics buffer for the drawing
  drawingLayer = createGraphics(width, height);
  drawingLayer.beginDraw();
  drawingLayer.background(255);
  drawingLayer.endDraw();
  
  currentTool = new PencilTool(brushSize, currentColor); // Pencil as default
}

void startAction() {
  snapshot = drawingLayer.get();
  undoStack.add(snapshot);
  redoStack.clear();
}

void draw(){
  // Clear and redraw everything each frame
  background(255);
  
  // Draw the drawing layer
  image(drawingLayer, 0, 0);
  
  // Overlay the grid if enabled
  if(showGrid){
    pushStyle();
    stroke(200, 200, 200, 100);
    strokeWeight(1);
    
    for(int x = 0; x < width; x += gridSize) {
      line(x, 0, x, height);
    }
    
    for(int y = 0; y < height; y += gridSize) {
      line(0, y, width, y);
    }
    popStyle();
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
