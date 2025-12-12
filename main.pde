import g4p_controls.*; // Import G4P Library for GUI components

// Tool Management
Tool currentTool; // Current drawing tool
float brushSize = 10; // Initial brush size

// Color Management
color baseColor = color(0); // Base color from color wheel (before brightness)
color currentColor = color(0); // Final color after brightness
float brightnessValue = 0.5; // Brightness value (0.0 = white, 0.5 = full color, 1,0 = black)

boolean showGrid = true; // Toggle grid visibility
float gridSize = 50.0; // Spacking between grid lines in pixels
PGraphics drawingLayer; // Seperate graphics layer for drawing (excluding grid/UI)

ArrayList<PImage> undoStack = new ArrayList<PImage>(); // History of previous states
ArrayList<PImage> redoStack = new ArrayList<PImage>(); // History of undone states
PImage snapshot; // Temporary storage for state snapshots

// Zoom and Pan
float zoomLevel = 1.0; //Current Zoom level (100%)
float panX = 0; // Horizantal pan offset
float panY = 0; // Vertical pan offset
float minZoom = 0.1; // Minimum zoom (10%)
float maxZoom = 10; // Maximum zoom (1000%)

void setup() {
  size(800, 600); // Set canvas size
  createGUI(); // Initialize G4P GUI components
  
  // Create a separate graphics buffer for the drawing
  // Keeps the actual drawing seperate from overlays such as grid and UI
  drawingLayer = createGraphics(width, height);
  drawingLayer.beginDraw();
  drawingLayer.background(255); // Start with white background
  drawingLayer.endDraw();
  
  currentTool = new PencilTool(brushSize, currentColor); // Pencil as default
}

// Undo System
void startAction() {
  // Called before any drawing action to save current state
  snapshot = drawingLayer.get(); // Capture current drawing state
  undoStack.add(snapshot); // Add to undo history
  redoStack.clear(); // Clear redo history (can't redo after new action)
}

void draw() {
  // Clear and redraw everything each frame
  background(255);
  
  // Apply zoom and pan transformations
  pushMatrix(); // Save current transformation state
  translate(panX, panY); // Apply pan offset
  scale(zoomLevel); // Apply zoom scaling
  
  // Draw the actual drawing layer
  image(drawingLayer, 0, 0);
  
  // Overlay the grid if enabled
  if(showGrid) {
    pushStyle(); // Save current drawing style
    stroke(200, 200, 200, 100); // Light gray semi transparent
    strokeWeight(1 / zoomLevel); // Adjust line weight for zoom
    
    // Draw vertical grid lines
    for(int x = 0; x < width; x += gridSize) {
      line(x, 0, x, height);
    }
    // Draw horizantal grid lines
    for(int y = 0; y < height; y += gridSize) {
      line(0, y, width, y);
    }
    popStyle(); // Restore previous drawing state (works with pushStyle)
  }
  popMatrix(); // Restore transformation state (works with pushMatrix)
}

// Mouse Event Handling
void mouseDragged() {
  // Called continously while mouse button is held and moved
  if(currentTool != null){
    currentTool.mouseDragged();
  }
}

void mousePressed() {
  // Called once when mouse button is first pressed
  if(currentTool != null) {
    currentTool.mousePressed();
  }
}

void mouseReleased() {
  // Called once when mouse button is released
  if(currentTool != null) {
    currentTool.mouseReleased();
  }
}

// Zoom functions
void zoomIn(float factor) {
  // Zoom in by a given factor (i.e. 1.5 = 150%)
  float newZoom = constrain(zoomLevel * factor, minZoom, maxZoom);
  
  // Zoom towards center of screen
  float centerX = width / 2.0;
  float centerY = height / 2.0;
  
  // Adjust pan to keep center point stable during zoom
  // This prevents the canvas from jumping around when zooming
  panX = centerX - (centerX - panX) * (newZoom / zoomLevel);
  panY = centerY - (centerY - panY) * (newZoom / zoomLevel);
  
  zoomLevel = newZoom;
}

void zoomOut(float factor) {
  float newZoom = constrain(zoomLevel / factor, minZoom, maxZoom); // constrain zoomLevel by min and max zoom values
  
  // Zoom from center of screen
  float centerX = width / 2.0;
  float centerY = height / 2.0;
  
  // Adjust pan to keep center point stable
  panX = centerX - (centerX - panX) * (newZoom / zoomLevel);
  panY = centerY - (centerY - panY) * (newZoom / zoomLevel);
  
  zoomLevel = newZoom;
}

void resetZoom() {
  // Reset zoom to 100% and center the canvasw
  zoomLevel = 1.0;
  panX = 0;
  panY = 0;
}

void mouseWheel(MouseEvent event) {
  // Handle mouse wheel scrolling for zoom
  // Scroll up = zoom in, scroll down = zoom out
  float e = event.getCount();
  if (e < 0) {
    zoomIn(1.1); // Zoom in by 10%
  } else {
    zoomOut(1.1); // Zoom out by 10%
  }
}

// Save Function
void saveCanvas() {
  // Save the current canvas as a PNG file
  // Creates a fancy timestampled filename and saves to "saves" folder
  File folder = new File(sketchPath("saves"));   // Create a file if not already created
  if (!folder.exists()) {
    folder.mkdir(); // Make directory
    println("Created 'saves' folder");
  }
  
  // Generate filename with timestamp (YYYY-MM-DD_HH-MM-SS)
  String timestamp = year() + "-" + nf(month(), 2) + "-" + nf(day(), 2) + "_" + 
                     nf(hour(), 2) + "-" + nf(minute(), 2) + "-" + nf(second(), 2);
  String filename = "saves/comic_" + timestamp + ".png";
  
  // Save the drawing layer (without grid)
  drawingLayer.save(filename);
  
  println("Saved: " + filename); // Print statement for user clarity
}


// Image Import Functions
void importImage() {
  // Open file dialog for user to select an image
  // Triggers imageSelected() callback when user chooses a file
  selectInput("Select an image to import:", "imageSelected");
}

void imageSelected(File selection) {
  // Callback function called after user selects an image file
  if (selection == null) {
    println("No file selected");
  } 
  else {
    // Attempt to load the selected image
    PImage img = loadImage(selection.getAbsolutePath());
    
    if (img != null) {
      startAction(); // Save undo state  before importing
      
      // Draw imported image onto canvas at position (0, 0)
      drawingLayer.beginDraw();
      drawingLayer.image(img, 0, 0);
      drawingLayer.endDraw();
      
      println("Image imported: " + selection.getName());
    } 
    else {
      // Error message
      println("Error: Could not load image");
    }
  }
}
