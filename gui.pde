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
  currentTool = new TriangleTool(brushSize, currentColor);
} //_CODE_:TriangleButton:994882:

public void RedoButtonClick(GImageButton source, GEvent event) { //_CODE_:RedoButton:914227:
  println("Redo clicked! Stack size: " + redoStack.size());
  if(redoStack.size() > 0) {
    PImage next = redoStack.remove(redoStack.size() - 1);
    undoStack.add(drawingLayer.get()); // Save current state
    
    // Restore to drawing layer (not main display)
    drawingLayer.beginDraw();
    drawingLayer.image(next, 0, 0);
    drawingLayer.endDraw();
  }
} //_CODE_:RedoButton:914227:

public void UndoButtonClick(GImageButton source, GEvent event) { //_CODE_:UndoButton:312280:
  println("Undo clicked! Stack size: " + undoStack.size());
  if(undoStack.size() > 0) {
    PImage last = undoStack.remove(undoStack.size() - 1);
    redoStack.add(drawingLayer.get()); // Save current state
    
    // Restore to drawing layer (not main display)
    drawingLayer.beginDraw();
    drawingLayer.image(last, 0, 0);
    drawingLayer.endDraw();
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
  showGrid = source.isSelected();
  println("Grid: " + (showGrid ? "ON" : "OFF"));
} //_CODE_:GridCheckbox:956630:

public void GridThicknessSliderChanged(GCustomSlider source, GEvent event) { //_CODE_:GridThicknessSlider:449857:
  gridSize = source.getValueF();
} //_CODE_:GridThicknessSlider:449857:

public void ZoomInButtonClick(GImageButton source, GEvent event) { //_CODE_:ZoomInButton:310758:
  zoomIn(1.5);
  println("Zoom Level: " + zoomLevel);
} //_CODE_:ZoomInButton:310758:

public void ZoomOutButtonClick(GImageButton source, GEvent event) { //_CODE_:ZoomOutButton:264610:
  zoomOut(1.5);
  println("Zoom Level: " + zoomLevel);
} //_CODE_:ZoomOutButton:264610:

public void ZoomResetClick(GButton source, GEvent event) { //_CODE_:ZoomReset:711430:
  resetZoom();
  println("Zoom Reset to 1.0");
} //_CODE_:ZoomReset:711430:

public void EllipseButtonClick(GButton source, GEvent event) { //_CODE_:EllipseButton:419522:
  currentTool = new EllipseTool(brushSize, currentColor);
} //_CODE_:EllipseButton:419522:

public void StarButtonClick(GButton source, GEvent event) { //_CODE_:StarButton:523301:
  currentTool = new StarTool(brushSize, currentColor);
} //_CODE_:StarButton:523301:

public void SprayPaintButtonClick(GButton source, GEvent event) { //_CODE_:SprayPaintButton:955701:
  currentTool = new SprayPaintTool(brushSize, currentColor);
} //_CODE_:SprayPaintButton:955701:

public void SpeechBubbleButtonClick(GButton source, GEvent event) { //_CODE_:SpeechBubbleButton:288353:
  currentTool = new SpeechBubbleTool(brushSize, currentColor);
} //_CODE_:SpeechBubbleButton:288353:

public void YellBubbleButtonClick(GButton source, GEvent event) { //_CODE_:YellBubbleButton:906303:
  currentTool = new YellBubbleTool(brushSize, currentColor);
} //_CODE_:YellBubbleButton:906303:

public void AnnounceBubbleButtonClick(GButton source, GEvent event) { //_CODE_:AnounceBubbleButton:900458:
  currentTool = new AnnounceBubbleTool(brushSize, currentColor);
} //_CODE_:AnounceBubbleButton:900458:

public void ThoughtBubbleButtonClick(GButton source, GEvent event) { //_CODE_:ThoughtBubbleButton:691306:
  currentTool = new ThoughtBubbleTool(brushSize, currentColor);
} //_CODE_:ThoughtBubbleButton:691306:

public void SaveButtonClicked(GButton source, GEvent event) { //_CODE_:SaveButton:485838:
  saveCanvas();
} //_CODE_:SaveButton:485838:

public void ImportButtonClick(GButton source, GEvent event) { //_CODE_:ImportButton:456505:
  importImage();
} //_CODE_:ImportButton:456505:

public void TextAreaChange(GTextArea source, GEvent event) { //_CODE_:TextArea:610195:
// Don't need to do anything here, user types away
} //_CODE_:TextArea:610195:

public void PlaceTextButtonClick(GButton source, GEvent event) { //_CODE_:PlaceTextButton:295333:
  if(currentTool instanceof TextTool) {
    String text = TextArea.getText(); // Get text from your TextArea
    ((TextTool)currentTool).placeText(text);
    TextArea.setText(""); // Clear text area after placing
  }
} //_CODE_:PlaceTextButton:295333:

public void TextToolButtonClick(GButton source, GEvent event) { //_CODE_:TextToolButton:875166:
  currentTool = new TextTool(24, currentColor);
  println("Text tool activated. Click on canvas to set text position.");
} //_CODE_:TextToolButton:875166:

public void PortraitLayoutButtonClick(GButton source, GEvent event) { //_CODE_:PotraitLayoutButton:426362:
  createPortraitLayout(); 
} //_CODE_:PotraitLayoutButton:426362:

public void LandscapeLayoutButtonClick(GButton source, GEvent event) { //_CODE_:LandscapeLayoutButton:284219:
  createLandscapeLayout();
} //_CODE_:LandscapeLayoutButton:284219:

public void GridLayoutButtonClick(GButton source, GEvent event) { //_CODE_:GridLayoutButton:624262:
  createGridLayout();
} //_CODE_:GridLayoutButton:624262:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  Settings = GWindow.getWindow(this, "Settings", 0, 0, 480, 520, JAVA2D);
  Settings.noLoop();
  Settings.setActionOnClose(G4P.KEEP_OPEN);
  Settings.addDrawHandler(this, "win_draw1");
  PencilButton = new GButton(Settings, 110, 55, 80, 30);
  PencilButton.setText("Pencil");
  PencilButton.addEventHandler(this, "PencilButtonClick");
  EraserButton = new GButton(Settings, 110, 95, 80, 30);
  EraserButton.setText("Eraser");
  EraserButton.addEventHandler(this, "EraserButtonClick");
  ToolSlider = new GCustomSlider(Settings, 200, 250, 100, 50, "grey_blue");
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
  RedoButton = new GImageButton(Settings, 380, 10, 50, 50, new String[] { "ComicEngineRedoButton.png", "ComicEngineRedoButton.png", "ComicEngineRedoButton.png" } );
  RedoButton.addEventHandler(this, "RedoButtonClick");
  UndoButton = new GImageButton(Settings, 320, 10, 50, 50, new String[] { "ComicEngineUndoButton.png", "ComicEngineUndoButton.png", "ComicEngineUndoButton.png" } );
  UndoButton.addEventHandler(this, "UndoButtonClick");
  ColorWheel2DSlider = new GSlider2D(Settings, 15, 250, 170, 170);
  ColorWheel2DSlider.setLimitsX(0.5, 0.0, 1.0);
  ColorWheel2DSlider.setLimitsY(0.5, 0.0, 1.0);
  ColorWheel2DSlider.setNumberFormat(G4P.DECIMAL, 2);
  ColorWheel2DSlider.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
  ColorWheel2DSlider.setOpaque(true);
  ColorWheel2DSlider.addEventHandler(this, "ColorWheel2DSliderChanged");
  ColorBrightnessSlider = new GCustomSlider(Settings, 15, 440, 170, 30, "grey_blue");
  ColorBrightnessSlider.setLimits(0.5, 0.0, 1.0);
  ColorBrightnessSlider.setNumberFormat(G4P.DECIMAL, 2);
  ColorBrightnessSlider.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
  ColorBrightnessSlider.setOpaque(false);
  ColorBrightnessSlider.addEventHandler(this, "ColorBrightnessSliderChanged");
  GridCheckbox = new GCheckbox(Settings, 325, 310, 100, 20);
  GridCheckbox.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  GridCheckbox.setText("Grid Lines");
  GridCheckbox.setOpaque(false);
  GridCheckbox.addEventHandler(this, "GridCheckboxClicked");
  GridCheckbox.setSelected(true);
  GridThicknessSlider = new GCustomSlider(Settings, 325, 250, 100, 50, "grey_blue");
  GridThicknessSlider.setShowValue(true);
  GridThicknessSlider.setLimits(40.0, 5.0, 75.0);
  GridThicknessSlider.setNbrTicks(14);
  GridThicknessSlider.setShowTicks(true);
  GridThicknessSlider.setNumberFormat(G4P.DECIMAL, 0);
  GridThicknessSlider.setOpaque(false);
  GridThicknessSlider.addEventHandler(this, "GridThicknessSliderChanged");
  ZoomInButton = new GImageButton(Settings, 380, 75, 50, 50, new String[] { "ZoomInButton.png", "ZoomInButton.png", "ZoomInButton.png" } );
  ZoomInButton.addEventHandler(this, "ZoomInButtonClick");
  ZoomOutButton = new GImageButton(Settings, 320, 75, 50, 50, new String[] { "ZoomOutButton.png", "ZoomOutButton.png", "ZoomOutButton.png" } );
  ZoomOutButton.addEventHandler(this, "ZoomOutButtonClick");
  ZoomReset = new GButton(Settings, 335, 135, 80, 30);
  ZoomReset.setText("Zoom Reset");
  ZoomReset.setLocalColorScheme(GCScheme.RED_SCHEME);
  ZoomReset.addEventHandler(this, "ZoomResetClick");
  EllipseButton = new GButton(Settings, 20, 135, 80, 30);
  EllipseButton.setText("Ellipse");
  EllipseButton.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  EllipseButton.addEventHandler(this, "EllipseButtonClick");
  StarButton = new GButton(Settings, 20, 175, 80, 30);
  StarButton.setText("Star");
  StarButton.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  StarButton.addEventHandler(this, "StarButtonClick");
  SprayPaintButton = new GButton(Settings, 110, 175, 80, 30);
  SprayPaintButton.setText("Spray Paint");
  SprayPaintButton.addEventHandler(this, "SprayPaintButtonClick");
  SpeechBubbleButton = new GButton(Settings, 200, 55, 80, 30);
  SpeechBubbleButton.setText("Speech Bubble");
  SpeechBubbleButton.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  SpeechBubbleButton.addEventHandler(this, "SpeechBubbleButtonClick");
  YellBubbleButton = new GButton(Settings, 200, 95, 80, 30);
  YellBubbleButton.setText("Yell Bubble");
  YellBubbleButton.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  YellBubbleButton.addEventHandler(this, "YellBubbleButtonClick");
  AnounceBubbleButton = new GButton(Settings, 200, 135, 80, 30);
  AnounceBubbleButton.setText("Anounce Bubble");
  AnounceBubbleButton.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  AnounceBubbleButton.addEventHandler(this, "AnnounceBubbleButtonClick");
  ThoughtBubbleButton = new GButton(Settings, 200, 175, 80, 30);
  ThoughtBubbleButton.setText("Thought Bubble");
  ThoughtBubbleButton.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  ThoughtBubbleButton.addEventHandler(this, "ThoughtBubbleButtonClick");
  ThicknessLabel = new GLabel(Settings, 180, 230, 140, 20);
  ThicknessLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  ThicknessLabel.setText("Tool Thickness");
  ThicknessLabel.setOpaque(false);
  GridLabel = new GLabel(Settings, 305, 230, 140, 20);
  GridLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  GridLabel.setText("Grid Size");
  GridLabel.setOpaque(false);
  ColorWheelLabel = new GLabel(Settings, 10, 215, 180, 20);
  ColorWheelLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  ColorWheelLabel.setText("Color Wheel (Angle Based)");
  ColorWheelLabel.setOpaque(false);
  ColorBrightnessLabel = new GLabel(Settings, 0, 425, 200, 20);
  ColorBrightnessLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  ColorBrightnessLabel.setText("Color Brightness (White to Black)");
  ColorBrightnessLabel.setOpaque(false);
  GLabel = new GLabel(Settings, 0, 375, 15, 15);
  GLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  GLabel.setText("_");
  GLabel.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  GLabel.setOpaque(true);
  RLabel = new GLabel(Settings, 95, 235, 15, 15);
  RLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  RLabel.setText("_");
  RLabel.setLocalColorScheme(GCScheme.RED_SCHEME);
  RLabel.setOpaque(true);
  BLabel = new GLabel(Settings, 185, 375, 15, 15);
  BLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  BLabel.setText("_");
  BLabel.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  BLabel.setOpaque(true);
  SaveButton = new GButton(Settings, 65, 15, 80, 30);
  SaveButton.setText("Save");
  SaveButton.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
  SaveButton.addEventHandler(this, "SaveButtonClicked");
  ImportButton = new GButton(Settings, 155, 15, 80, 30);
  ImportButton.setText("Import");
  ImportButton.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
  ImportButton.addEventHandler(this, "ImportButtonClick");
  TextArea = new GTextArea(Settings, 225, 345, 180, 80, G4P.SCROLLBARS_NONE);
  TextArea.setPromptText("Enter Some Text to Bring your Comic to Life!");
  TextArea.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  TextArea.setOpaque(true);
  TextArea.addEventHandler(this, "TextAreaChange");
  PlaceTextButton = new GButton(Settings, 325, 435, 80, 30);
  PlaceTextButton.setText("Place Text");
  PlaceTextButton.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  PlaceTextButton.addEventHandler(this, "PlaceTextButtonClick");
  TextToolButton = new GButton(Settings, 225, 435, 80, 30);
  TextToolButton.setText("Activate Text");
  TextToolButton.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  TextToolButton.addEventHandler(this, "TextToolButtonClick");
  PotraitLayoutButton = new GButton(Settings, 50, 480, 80, 30);
  PotraitLayoutButton.setText("Potrait");
  PotraitLayoutButton.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
  PotraitLayoutButton.addEventHandler(this, "PortraitLayoutButtonClick");
  LandscapeLayoutButton = new GButton(Settings, 185, 480, 80, 30);
  LandscapeLayoutButton.setText("Landscape");
  LandscapeLayoutButton.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
  LandscapeLayoutButton.addEventHandler(this, "LandscapeLayoutButtonClick");
  GridLayoutButton = new GButton(Settings, 320, 480, 80, 30);
  GridLayoutButton.setText("2 x 2");
  GridLayoutButton.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
  GridLayoutButton.addEventHandler(this, "GridLayoutButtonClick");
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
GCustomSlider GridThicknessSlider; 
GImageButton ZoomInButton; 
GImageButton ZoomOutButton; 
GButton ZoomReset; 
GButton EllipseButton; 
GButton StarButton; 
GButton SprayPaintButton; 
GButton SpeechBubbleButton; 
GButton YellBubbleButton; 
GButton AnounceBubbleButton; 
GButton ThoughtBubbleButton; 
GLabel ThicknessLabel; 
GLabel GridLabel; 
GLabel ColorWheelLabel; 
GLabel ColorBrightnessLabel; 
GLabel GLabel; 
GLabel RLabel; 
GLabel BLabel; 
GButton SaveButton; 
GButton ImportButton; 
GTextArea TextArea; 
GButton PlaceTextButton; 
GButton TextToolButton; 
GButton PotraitLayoutButton; 
GButton LandscapeLayoutButton; 
GButton GridLayoutButton; 
