// Portrait Layout - 3 horizontal panels stacked vertically
// Classic comic strip style
void createPortraitLayout() {
  startAction(); // Save undo state
  
  drawingLayer.beginDraw();
  drawingLayer.stroke(0); // Black panels
  drawingLayer.strokeWeight(3); // Medium line weight
  drawingLayer.noFill(); // No fill just outlines
  drawingLayer.rectMode(CORNER); // Draw from corner
  
  int margin = 50; // Space around edges
  int gutter = 30; // Space between panels
  int panelWidth = width - (margin * 2);
  int panelHeight = (height - (margin * 2) - (gutter * 2)) / 3; // Divide height into 3
  
  // Top panel
  drawingLayer.rect(margin, margin, panelWidth, panelHeight);
  
  // Middle panel
  drawingLayer.rect(margin, margin + panelHeight + gutter, panelWidth, panelHeight);
  
  // Bottom panel
  drawingLayer.rect(margin, margin + (panelHeight * 2) + (gutter * 2), panelWidth, panelHeight);
  
  drawingLayer.endDraw();
  
  println("Portrait layout created (3 panels)"); // Print statement for user clarity 
}

// Landscape Layout - 3 vertical panels side by side
void createLandscapeLayout() {
  startAction(); // Save undo state
  
  drawingLayer.beginDraw();
  drawingLayer.stroke(0); // Black panels
  drawingLayer.strokeWeight(3); // Medium line weight
  drawingLayer.noFill(); // No fill just outlines
  drawingLayer.rectMode(CORNER); // Draw from corner
  
  int margin = 50; // Space around edges
  int gutter = 30; // Space between panels
  int panelWidth = (width - (margin * 2) - (gutter * 2)) / 3; // Divide height into 3
  int panelHeight = height - (margin * 2);
  
  // Left panel
  drawingLayer.rect(margin, margin, panelWidth, panelHeight);
  
  // Middle panel
  drawingLayer.rect(margin + panelWidth + gutter, margin, panelWidth, panelHeight);
  
  // Right panel
  drawingLayer.rect(margin + (panelWidth * 2) + (gutter * 2), margin, panelWidth, panelHeight);
  
  drawingLayer.endDraw();
  
  println("Landscape layout created (3 panels)"); // Print statement for user clarity
}

// Classic 4-panel grid (2x2)
void createGridLayout() {
  startAction(); // Save undo state
  
  drawingLayer.beginDraw();
  drawingLayer.stroke(0); // Black panels
  drawingLayer.strokeWeight(3); // Medium line weight
  drawingLayer.noFill(); // No fill just outlines
  drawingLayer.rectMode(CORNER); // Draw from corner
  
  int margin = 50; // Space around edges
  int gutter = 30; // Space between panels
  int panelWidth = (width - (margin * 2) - gutter) / 2; // 2 columns
  int panelHeight = (height - (margin * 2) - gutter) / 2; // 2 rows
  
  // Top-left
  drawingLayer.rect(margin, margin, panelWidth, panelHeight);
  
  // Top-right
  drawingLayer.rect(margin + panelWidth + gutter, margin, panelWidth, panelHeight);
  
  // Bottom-left
  drawingLayer.rect(margin, margin + panelHeight + gutter, panelWidth, panelHeight);
  
  // Bottom-right
  drawingLayer.rect(margin + panelWidth + gutter, margin + panelHeight + gutter, panelWidth, panelHeight);
  
  drawingLayer.endDraw();
  
  println("Grid layout created (4 panels, 2x2)"); // Print statement for user clarity
}
