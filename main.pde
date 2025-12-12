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

float zoomLevel = 1.0;
float panX = 0;
float panY = 0;
float minZoom = 0.1;
float maxZoom = 10;

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
  
  // Apply zoom and pan transformations
  pushMatrix();
  translate(panX, panY);
  scale(zoomLevel);
  
  // Draw the drawing layer
  image(drawingLayer, 0, 0);
  
  // Overlay the grid if enabled
  if(showGrid){
    pushStyle();
    stroke(200, 200, 200, 100);
    strokeWeight(1 / zoomLevel); // Adjust grid line weight for zoom
    
    for(int x = 0; x < width; x += gridSize) {
      line(x, 0, x, height);
    }
    
    for(int y = 0; y < height; y += gridSize) {
      line(0, y, width, y);
    }
    popStyle();
  }
  popMatrix();
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

// Zoom functions
void zoomIn(float factor) {
  float newZoom = constrain(zoomLevel * factor, minZoom, maxZoom);
  
  // Zoom towards center of screen
  float centerX = width / 2.0;
  float centerY = height / 2.0;
  
  // Adjust pan to keep center point stable
  panX = centerX - (centerX - panX) * (newZoom / zoomLevel);
  panY = centerY - (centerY - panY) * (newZoom / zoomLevel);
  
  zoomLevel = newZoom;
}

void zoomOut(float factor) {
  float newZoom = constrain(zoomLevel / factor, minZoom, maxZoom);
  
  // Zoom from center of screen
  float centerX = width / 2.0;
  float centerY = height / 2.0;
  
  // Adjust pan to keep center point stable
  panX = centerX - (centerX - panX) * (newZoom / zoomLevel);
  panY = centerY - (centerY - panY) * (newZoom / zoomLevel);
  
  zoomLevel = newZoom;
}

void resetZoom() {
  zoomLevel = 1.0;
  panX = 0;
  panY = 0;
}

// Mouse wheel zoom (optional - nice feature!)
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (e < 0) {
    zoomIn(1.1);
  } else {
    zoomOut(1.1);
  }
}
