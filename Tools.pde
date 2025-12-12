class PencilTool extends Tool {
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
    drawingLayer.line(pmouseX, pmouseY, mouseX, mouseY);
    drawingLayer.endDraw();
  }
}

class EraserTool extends Tool {
  EraserTool(float size, color c){
    super(size, c);
  }

  void mousePressed() {
    startAction();
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
  float startX, startY;
  PImage beforeDrag;
  boolean dragging = false;

  LineTool(float size, color c){
    super(size, c);
  }

  void mousePressed() {
    startAction();
    startX = mouseX;
    startY = mouseY;
    beforeDrag = drawingLayer.get();
    dragging = true;
  }

  void mouseDragged() {
    if(dragging){
      // Restore the canvas state, draw preview line
      drawingLayer.beginDraw();
      drawingLayer.background(255); // Clear first
      drawingLayer.image(beforeDrag, 0, 0); // Restore saved state
      drawingLayer.stroke(toolColor);
      drawingLayer.strokeWeight(toolSize);
      drawingLayer.line(startX, startY, mouseX, mouseY);
      drawingLayer.endDraw();
    }
  }

  void mouseReleased() {
    if(dragging){
      drawingLayer.beginDraw();
      drawingLayer.image(beforeDrag, 0, 0);
      drawingLayer.stroke(toolColor);
      drawingLayer.strokeWeight(toolSize);
      drawingLayer.line(startX, startY, mouseX, mouseY);
      drawingLayer.endDraw();
      
      dragging = false;
      beforeDrag = null;
    }
  }
}

class SprayPaintTool extends Tool {
  SprayPaintTool(float size, color c){
    super(size, c);
  }
  
  void mousePressed() {
    startAction(); // save undo snapshot
  }
  
  void mouseDragged() {
    drawingLayer.beginDraw();
    drawingLayer.noStroke();
    
    // Get color components
    float r = red(toolColor);
    float g = green(toolColor);
    float b = blue(toolColor);
    
    // Spray multiple dots in a circular area
    int numDots = 50; // More dots for denser coverage
    float sprayRadius = toolSize;
    
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
  float textX = 0;
  float textY = 0;
  boolean waitingForClick = true;
  int textSizeValue = 24; // Default text size
  
  TextTool(float size, color c){
    super(size, c);
    textSizeValue = (int)size;
  }
  
  void mousePressed() {
    // Store where user clicked
    textX = mouseX;
    textY = mouseY;
    waitingForClick = false;
    
    println("Text position set at (" + textX + ", " + textY + ")");
    println("Enter text in the text area and click 'Place Text' button");
  }
  
  void mouseDragged() {
    // Text tool doesn't use drag
  }
  
  void mouseReleased() {
    // Text tool doesn't use release
  }
  
  // Call this from your "Place Text" button
  void placeText(String text) {
    if (waitingForClick) {
      println("Click on canvas first to set text position!");
      return;
    }
    
    if (text.length() == 0) {
      println("Text area is empty! Type something first.");
      return;
    }
    
    // Place the text
    startAction(); // Save undo state
    
    drawingLayer.beginDraw();
    drawingLayer.fill(toolColor);
    drawingLayer.textSize(textSizeValue);
    drawingLayer.textAlign(LEFT, BASELINE);
    drawingLayer.text(text, textX, textY);
    drawingLayer.endDraw();
    
    println("Text placed: '" + text + "' at (" + textX + ", " + textY + ")");
    waitingForClick = true; // Ready for next click
  }
}
