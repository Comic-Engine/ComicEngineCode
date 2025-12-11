/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

synchronized public void win_draw1(PApplet appc, GWinData data) { //_CODE_:Settings:808014:
  appc.background(230);
} //_CODE_:Settings:808014:

public void PencilButtonClick(GButton source, GEvent event) { //_CODE_:PencilButton:261240:
  currentTool = new PencilTool(brushSize, currentColor);
} //_CODE_:PencilButton:261240:

public void EraserButtonClick(GButton source, GEvent event) { //_CODE_:EraserButton:809047:
  currentTool = new EraserTool(brushSize, color(255));
} //_CODE_:EraserButton:809047:

public void ToolSliderChanged(GCustomSlider source, GEvent event) { //_CODE_:ToolSlider:942316:
  brushSize = ToolSlider.getValueF();
  if(currentTool != null){
    currentTool.toolSize = brushSize;
  }
} //_CODE_:ToolSlider:942316:

public void LineButtonClick(GButton source, GEvent event) { //_CODE_:LineButton:506486:
  currentTool = new LineTool(brushSize, currentColor);
} //_CODE_:LineButton:506486:

public void RectangleButtonClick(GButton source, GEvent event) { //_CODE_:RectangleButton:428010:
  currentTool = new RectangleTool(brushSize, currentColor);
} //_CODE_:RectangleButton:428010:

public void TriangleButtonClick(GButton source, GEvent event) { //_CODE_:TriangleButton:994882:
  println("TriangleButton - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:TriangleButton:994882:

public void RedoButtonClick(GImageButton source, GEvent event) { //_CODE_:RedoButton:914227:
  println("Redo clicked! Stack size: " + redoStack.size());
  if(redoStack.size() > 0) {
    PImage next = redoStack.remove(redoStack.size() - 1);
    undoStack.add(get());
    set(0, 0, next);  // Use set() instead of image()
    println("Redo complete! New stack size: " + redoStack.size());
  }
} //_CODE_:RedoButton:914227:

public void UndoButtonClick(GImageButton source, GEvent event) { //_CODE_:UndoButton:312280:
  println("Undo clicked! Stack size: " + undoStack.size());
  if(undoStack.size() > 0) {
    PImage last = undoStack.remove(undoStack.size() - 1);
    redoStack.add(get());
    set(0, 0, last);  // Use set() instead of image()
    println("Undo complete! New stack size: " + undoStack.size());
  }
} //_CODE_:UndoButton:312280:

public void ColorWheel2DSliderChanged(GSlider2D source, GEvent event) { //_CODE_:ColorWheel2DSlider:867200:
  // Get x,y values from slider (0.0 to 1.0)
  float x = ColorWheel2DSlider.getValueXF();
  float y = ColorWheel2DSlider.getValueYF();
  
  // Convert to centered coordinates (-0.5 to 0.5)
  float centerX = x - 0.5;
  float centerY = -(y - 0.5);
  
  // Create PVector and get heading
  PVector V = new PVector(centerX, centerY);
  float angle = V.heading();
  if (angle < 0) angle += TWO_PI; // No negative angles
  
  // Width parameter for Gaussian (controls color spread)
  float w = 1.5;
  
  // Calculate RGB using Gaussian formulas
  float r = 255 * exp(-pow(angle - PI/2, 2) / w);
  float g = 255 * exp(-pow(angle - 7*PI/6, 2) / w);
  float b = 255 * exp(-pow(angle - 11*PI/6, 2) / w);
  
  // Handle wraparound for red
  r += 255 * exp(-pow(angle - PI/2 + TWO_PI, 2) / w);
  r += 255 * exp(-pow(angle - PI/2 - TWO_PI, 2) / w);
  
  // Handle wraparound for blue
  b += 255 * exp(-pow(angle - 11*PI/6 + TWO_PI, 2) / w);
  b += 255 * exp(-pow(angle - 11*PI/6 - TWO_PI, 2) / w);

  // Green at 210° doesn't cross the boundary, so no wraparound needed

  
  // Constrain values to 0-255
  r = constrain(r, 0, 255);
  g = constrain(g, 0, 255);
  b = constrain(b, 0, 255);
  
  baseColor = color(r, g, b);
  
  // Apply brightness transformation
  float finalR, finalG, finalB;
  if (brightnessValue < 0.5) {
    // From white to color (0.0 to 0.5)
    float t = brightnessValue * 2; // Map 0.0-0.5 to 0.0-1.0
    finalR = 255 + (r - 255) * t;
    finalG = 255 + (g - 255) * t;
    finalB = 255 + (b - 255) * t;
  } 
  else {
    // From color to black (0.5 to 1.0)
    float t = (brightnessValue - 0.5) * 2; // Map 0.5-1.0 to 0.0-1.0
    finalR = r * (1 - t);
    finalG = g * (1 - t);
    finalB = b * (1 - t);
  }
  
  currentColor = color(finalR, finalG, finalB);
  
  // Update current tool's color
  if(currentTool != null) {
    currentTool.toolColor = currentColor;
  }
  
  println("Angle: " + degrees(angle) + "°, Base RGB: " + r + ", " + g + ", " + b);

} //_CODE_:ColorWheel2DSlider:867200:

public void ColorBrightnessSliderChanged(GCustomSlider source, GEvent event) { //_CODE_:ColorBrightnessSlider:484316:
  brightnessValue = source.getValueF(); // 0.0 to 1.0
  
  // Get base color components
  float r = red(baseColor);
  float g = green(baseColor);
  float b = blue(baseColor);
  
  // Apply brightness: white → color → black
  float finalR, finalG, finalB;
  if (brightnessValue < 0.5) {
    // From white to color (0.0 to 0.5)
    float t = brightnessValue * 2;
    finalR = 255 + (r - 255) * t;
    finalG = 255 + (g - 255) * t;
    finalB = 255 + (b - 255) * t;
  } else {
    // From color to black (0.5 to 1.0)
    float t = (brightnessValue - 0.5) * 2;
    finalR = r * (1 - t);
    finalG = g * (1 - t);
    finalB = b * (1 - t);
  }
  
  currentColor = color(finalR, finalG, finalB);
  
  // Update tool
  if(currentTool != null) {
    currentTool.toolColor = currentColor;
  }
  
  println("Brightness: " + brightnessValue + ", Final RGB: " + finalR + ", " + finalG + ", " + finalB);
} //_CODE_:ColorBrightnessSlider:484316:

public void GridCheckboxClicked(GCheckbox source, GEvent event) { //_CODE_:GridCheckbox:956630:
  showGrid = !showGrid; // Toggle on/off
  println("Grid: " + (showGrid ? "ON" : "OFF"));
} //_CODE_:GridCheckbox:956630:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  Settings = GWindow.getWindow(this, "Settings", 0, 0, 320, 480, JAVA2D);
  Settings.noLoop();
  Settings.setActionOnClose(G4P.KEEP_OPEN);
  Settings.addDrawHandler(this, "win_draw1");
  PencilButton = new GButton(Settings, 110, 55, 80, 30);
  PencilButton.setText("Pencil");
  PencilButton.addEventHandler(this, "PencilButtonClick");
  EraserButton = new GButton(Settings, 110, 95, 80, 30);
  EraserButton.setText("Eraser");
  EraserButton.addEventHandler(this, "EraserButtonClick");
  ToolSlider = new GCustomSlider(Settings, 55, 190, 100, 40, "grey_blue");
  ToolSlider.setShowValue(true);
  ToolSlider.setLimits(15.0, 0.1, 50.0);
  ToolSlider.setNbrTicks(5);
  ToolSlider.setShowTicks(true);
  ToolSlider.setNumberFormat(G4P.DECIMAL, 2);
  ToolSlider.setOpaque(false);
  ToolSlider.addEventHandler(this, "ToolSliderChanged");
  LineButton = new GButton(Settings, 110, 135, 80, 30);
  LineButton.setText("Line");
  LineButton.addEventHandler(this, "LineButtonClick");
  RectangleButton = new GButton(Settings, 20, 55, 80, 30);
  RectangleButton.setText("Rectangle");
  RectangleButton.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  RectangleButton.addEventHandler(this, "RectangleButtonClick");
  TriangleButton = new GButton(Settings, 20, 95, 80, 30);
  TriangleButton.setText("Triangle");
  TriangleButton.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  TriangleButton.addEventHandler(this, "TriangleButtonClick");
  RedoButton = new GImageButton(Settings, 275, 10, 35, 35, new String[] { "ComicEngineRedoButton.png", "ComicEngineRedoButton.png", "ComicEngineRedoButton.png" } );
  RedoButton.addEventHandler(this, "RedoButtonClick");
  UndoButton = new GImageButton(Settings, 230, 10, 35, 35, new String[] { "ComicEngineUndoButton.png", "ComicEngineUndoButton.png", "ComicEngineUndoButton.png" } );
  UndoButton.addEventHandler(this, "UndoButtonClick");
  ColorWheel2DSlider = new GSlider2D(Settings, 20, 250, 170, 170);
  ColorWheel2DSlider.setLimitsX(0.5, 0.0, 1.0);
  ColorWheel2DSlider.setLimitsY(0.5, 0.0, 1.0);
  ColorWheel2DSlider.setNumberFormat(G4P.DECIMAL, 2);
  ColorWheel2DSlider.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
  ColorWheel2DSlider.setOpaque(true);
  ColorWheel2DSlider.addEventHandler(this, "ColorWheel2DSliderChanged");
  ColorBrightnessSlider = new GCustomSlider(Settings, 20, 430, 170, 30, "grey_blue");
  ColorBrightnessSlider.setLimits(0.5, 0.0, 1.0);
  ColorBrightnessSlider.setNumberFormat(G4P.DECIMAL, 2);
  ColorBrightnessSlider.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
  ColorBrightnessSlider.setOpaque(false);
  ColorBrightnessSlider.addEventHandler(this, "ColorBrightnessSliderChanged");
  GridCheckbox = new GCheckbox(Settings, 195, 200, 100, 20);
  GridCheckbox.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  GridCheckbox.setText("Grid Lines");
  GridCheckbox.setOpaque(false);
  GridCheckbox.addEventHandler(this, "GridCheckboxClicked");
  GridCheckbox.setSelected(true);
  Settings.loop();
}

// Variable declarations 
// autogenerated do not edit
GWindow Settings;
GButton PencilButton; 
GButton EraserButton; 
GCustomSlider ToolSlider; 
GButton LineButton; 
GButton RectangleButton; 
GButton TriangleButton; 
GImageButton RedoButton; 
GImageButton UndoButton; 
GSlider2D ColorWheel2DSlider; 
GCustomSlider ColorBrightnessSlider; 
GCheckbox GridCheckbox; 
