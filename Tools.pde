class PencilTool extends Tool {
  // Free hand drawing tool
  // Draws smooth lines by connecting mouse positions each frame
  PencilTool(float size, color c){
    super(size, c);
  }
  
  void mousePressed() {
    startAction(); // save undo snapshot
  }
  
  void mouseDragged() {
    drawingLayer.beginDraw();
    drawingLayer.stroke(toolColor);
    drawingLayer.strokeWeight(toolSize);
    // Draw line from previous position to current
    drawingLayer.line(pmouseX, pmouseY, mouseX, mouseY);
    drawingLayer.endDraw();
  }
}

class EraserTool extends Tool {
  // Removes drawn content by using white color (simple)
  // Works just like pencil tool
  EraserTool(float size, color c){
    super(size, c);
  }

  void mousePressed() {
    startAction(); // Save undo snapshot
  }

  void mouseDragged() {
    drawingLayer.beginDraw();
    drawingLayer.stroke(255);
    drawingLayer.strokeWeight(toolSize);
    drawingLayer.line(pmouseX, pmouseY, mouseX, mouseY);
    drawingLayer.endDraw();
  }
}

class LineTool extends Tool {
  // Draws straight lines
  // User clicks start point, drags to end point, releases to finalize
  // Shows live preview while dragging
  float startX, startY;
  PImage beforeDrag;
  boolean dragging = false;

  LineTool(float size, color c){
    super(size, c);
  }

  void mousePressed() {
    startAction(); // Save undo snapshot
    startX = mouseX;
    startY = mouseY;
    beforeDrag = drawingLayer.get(); // Snapshot for preview
    dragging = true; // Enter drag mode
  }

  void mouseDragged() {
    if(dragging){
      // Restore the canvas state, draw preview line
      drawingLayer.beginDraw();
      drawingLayer.background(255); // Clear first
      drawingLayer.image(beforeDrag, 0, 0); // Restore saved state
      drawingLayer.stroke(toolColor);
      drawingLayer.strokeWeight(toolSize);
      // Draw preview line from start to current mouse position
      drawingLayer.line(startX, startY, mouseX, mouseY);
      drawingLayer.endDraw();
    }
  }

  void mouseReleased() {
    // Finalize the line when mouse is released
    if(dragging){
      drawingLayer.beginDraw();
      drawingLayer.image(beforeDrag, 0, 0); // Restore canvas
      drawingLayer.stroke(toolColor);
      drawingLayer.strokeWeight(toolSize);
      drawingLayer.line(startX, startY, mouseX, mouseY);
      drawingLayer.endDraw();
      
      dragging = false; // Exit drag mode
      beforeDrag = null; // Clear snapshot
    }
  }
}

class SprayPaintTool extends Tool {
  // SprayPaintTool, Creates spray paint effect with particles
  // Randomly distrubuted dots create an airbrush/spray can effect
  SprayPaintTool(float size, color c){
    super(size, c);
  }
  
  void mousePressed() {
    startAction(); // save undo snapshot
  }
  
  void mouseDragged() {
    drawingLayer.beginDraw();
    drawingLayer.noStroke();
    
    // Get color components from tool color
    float r = red(toolColor);
    float g = green(toolColor);
    float b = blue(toolColor);
    
    // Spray multiple dots in a circular area
    int numDots = 50; // More dots for denser coverage
    float sprayRadius = toolSize; // Area of spray effect
    
    for (int i = 0; i < numDots; i++) {
      // Random position within spray radius
      float angle = random(TWO_PI);
      float distance = random(sprayRadius);
      float dotX = mouseX + cos(angle) * distance;
      float dotY = mouseY + sin(angle) * distance;
      
      // More visible in center, fades toward edges
      float fadeAmount = 1 - (distance / sprayRadius);
      float opacity = 50 * fadeAmount * fadeAmount; // Squared for stronger center
      
      // Vary dot size - scales with brushSize and fades toward edges
      float baseDotSize = toolSize / 5; // Center dot scales with brush
      float dotSize = baseDotSize * (0.5 + random(0.5)) * fadeAmount;
      
      // Draw semi transparent dot using (r, g, b, opacity)
      drawingLayer.fill(r, g, b, opacity);
      drawingLayer.ellipse(dotX, dotY, dotSize, dotSize);
    }
    drawingLayer.endDraw();
  }
  
  void mouseReleased() {
    // Spray effect ends when mouse is released
  }
}

class TextTool extends Tool {
  // 2 Step process
  // Click on canvas to set position
  // Type in text area and click "Place Text" button
  // Works with G4P text area component
  float textX = 0; // X position of text to be placed
  float textY = 0; // Y position of text to be placed
  boolean waitingForClick = true; // True = need to click position, False = ready to place text
  int textSizeValue = 24; // Default text size
  
  TextTool(float size, color c){
    super(size, c);
    textSizeValue = (int)size; // Convert float to int for font size
  }
  
  void mousePressed() {
    // Store where user clicked
    textX = mouseX;
    textY = mouseY;
    waitingForClick = false; // Ready to accept text input
    
    // Print statements provide user clarity
    println("Text position set at (" + textX + ", " + textY + ")");
    println("Enter text in the text area and click 'Place Text' button");
  }
  
  void mouseDragged() {
    // Text tool doesn't use drag
  }
  
  void mouseReleased() {
    // Text tool doesn't use release
  }
  
  void placeText(String text) {
    // Check if user clicked on canvas first
    if (waitingForClick) {
      println("Click on canvas first to set text position!");
      return;
    }
    
    // Check if text area has context
    if (text.length() == 0) {
      println("Text area is empty! Type something first.");
      return;
    }
    
    // Place the text
    startAction(); // Save undo snapshot
    
    drawingLayer.beginDraw();
    drawingLayer.fill(toolColor);
    drawingLayer.textSize(textSizeValue);
    drawingLayer.textAlign(LEFT, BASELINE); // Align to position
    drawingLayer.text(text, textX, textY); // Draw text
    drawingLayer.endDraw();
    
    println("Text placed: '" + text + "' at (" + textX + ", " + textY + ")");
    waitingForClick = true; // Ready for next click/ text placement
  }
}
