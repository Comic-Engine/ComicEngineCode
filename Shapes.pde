class RectangleTool extends Tool {
  float startX, startY; // Center point where user clicked
  PImage beforeDrag; // Snapshot of canvas before dragging (for preview)
  boolean dragging = false; // Track if user is currently dragging

  RectangleTool(float size, color c){
    super(size, c);
  }

  void mousePressed() {
    // Called when mouse is first pressed
    startAction(); // Save undo snapshot
    startX = mouseX;
    startY = mouseY;
    beforeDrag = drawingLayer.get(); // Take snapshot of current canvas
    dragging = true; // Begin drag mode
  }

  void mouseDragged() {
    if(dragging){
      drawingLayer.beginDraw();
      drawingLayer.image(beforeDrag, 0, 0); // Restore original canvas
      drawingLayer.stroke(toolColor); // Set outline color
      drawingLayer.strokeWeight(toolSize); // Set outline thickness
      drawingLayer.noFill(); // No fill just outline
      drawingLayer.rectMode(CENTER); // Draw from center point
      float w = abs(mouseX - startX) * 2; // Calculate width based on drag distance
      float h = abs(mouseY - startY) * 2; // Calculate height based on drag distance
      drawingLayer.rect(startX, startY, w, h); // Draw preview rectangle
      drawingLayer.endDraw();
    }
  }

  void mouseReleased() {
    if(dragging){
      drawingLayer.beginDraw();
      drawingLayer.image(beforeDrag, 0, 0); // Restore original canvas
      drawingLayer.stroke(toolColor);
      drawingLayer.strokeWeight(toolSize);
      drawingLayer.noFill();
      drawingLayer.rectMode(CENTER);
      float w = abs(mouseX - startX) * 2;
      float h = abs(mouseY - startY) * 2;
      drawingLayer.rect(startX, startY, w, h); // Draw final rectangle
      drawingLayer.endDraw();
      
      dragging = false; // Exit drag mode
      beforeDrag = null; // Clear snapshot, preview rectangles no longer serve purpose
    }
  }
}

class TriangleTool extends Tool {
  // Draws triangle on canvas
  // Creates somewhat equilateral triangle centered on the click point
  float startX, startY;
  PImage beforeDrag;
  boolean dragging = false;
  
  TriangleTool(float size, color c){
    super(size, c);
  }
  
  void mousePressed() {
    startAction(); // Save undo snapshot
    startX = mouseX;
    startY = mouseY;
    beforeDrag = drawingLayer.get();
    dragging = true;
  }
  
  void mouseDragged() {
    if(dragging){
      drawingLayer.beginDraw();
      drawingLayer.image(beforeDrag, 0, 0);
      drawingLayer.stroke(toolColor);
      drawingLayer.strokeWeight(toolSize);
      drawingLayer.noFill();
      
      // Calculate triangle points (equilateral-ish)
      float w = abs(mouseX - startX) * 2;
      float h = abs(mouseY - startY) * 2;
      // Top point
      float topX = startX;
      float topY = startY - h/2;
      // Bottom left point
      float leftX = startX - w/2;
      float leftY = startY + h/2;
      // Bottom right point
      float rightX = startX + w/2;
      float rightY = startY + h/2;
      
      drawingLayer.triangle(topX, topY, leftX, leftY, rightX, rightY); // Draw triangle
      drawingLayer.endDraw();
    }
  }
  
  void mouseReleased() {
    if(dragging){
      drawingLayer.beginDraw();
      drawingLayer.image(beforeDrag, 0, 0);
      drawingLayer.stroke(toolColor);
      drawingLayer.strokeWeight(toolSize);
      drawingLayer.noFill();
      
      // Calculate triangle points
      float w = abs(mouseX - startX) * 2;
      float h = abs(mouseY - startY) * 2;
      float topX = startX;
      float topY = startY - h/2;
      float leftX = startX - w/2;
      float leftY = startY + h/2;
      float rightX = startX + w/2;
      float rightY = startY + h/2;
      
      drawingLayer.triangle(topX, topY, leftX, leftY, rightX, rightY); // Draw final triangle
      drawingLayer.endDraw();
      
      dragging = false; // Exit drag mode
      beforeDrag = null; // Clear snapshot, preview triangles no longer serve purpose
    }
  }
}

class EllipseTool extends Tool {
  // Draws ellipses/circles on the canvas
  float startX, startY;
  PImage beforeDrag;
  boolean dragging = false;
  
  EllipseTool(float size, color c){
    super(size, c);
  }
  
  void mousePressed() {
    startAction(); // Save undo snapshot
    startX = mouseX;
    startY = mouseY;
    beforeDrag = drawingLayer.get();
    dragging = true;
  }
  
  void mouseDragged() {
    if(dragging){
      drawingLayer.beginDraw();
      drawingLayer.image(beforeDrag, 0, 0);
      drawingLayer.stroke(toolColor);
      drawingLayer.strokeWeight(toolSize);
      drawingLayer.noFill();
      drawingLayer.ellipseMode(CENTER);
      float w = abs(mouseX - startX) * 2;
      float h = abs(mouseY - startY) * 2;
      drawingLayer.ellipse(startX, startY, w, h); // Preview
      drawingLayer.endDraw();
    }
  }
  
  void mouseReleased() {
    if(dragging){
      drawingLayer.beginDraw();
      drawingLayer.image(beforeDrag, 0, 0);
      drawingLayer.stroke(toolColor);
      drawingLayer.strokeWeight(toolSize);
      drawingLayer.noFill();
      drawingLayer.ellipseMode(CENTER);
      // Calculate ellipse dimensions
      float w = abs(mouseX - startX) * 2;
      float h = abs(mouseY - startY) * 2;
      drawingLayer.ellipse(startX, startY, w, h);
      drawingLayer.endDraw();
      
      dragging = false; // Exit drag
      beforeDrag = null; // Clear snapshot, preview ellipses no longer serve purpose
    }
  }
}

class StarTool extends Tool {
  // Draws 5 pointed star on the canvas
  // Radius is determined by dragging distance from center
  float startX, startY;
  PImage beforeDrag;
  boolean dragging = false;
  
  StarTool(float size, color c){
    super(size, c);
  }
  
  void mousePressed() {
    startAction(); // Save undo snapshot
    startX = mouseX;
    startY = mouseY;
    beforeDrag = drawingLayer.get();
    dragging = true;
  }
  
  void mouseDragged() {
    if(dragging){
      drawingLayer.beginDraw();
      drawingLayer.image(beforeDrag, 0, 0);
      drawingLayer.stroke(toolColor);
      drawingLayer.strokeWeight(toolSize);
      drawingLayer.noFill();
      
      // Calculate star radius from drag distance
      float radius = abs(mouseX - startX);
      drawStar(drawingLayer, startX, startY, radius, radius * 0.4, 5);
      
      drawingLayer.endDraw();
    }
  }
  
  void mouseReleased() {
    if(dragging){
      drawingLayer.beginDraw();
      drawingLayer.image(beforeDrag, 0, 0);
      drawingLayer.stroke(toolColor);
      drawingLayer.strokeWeight(toolSize);
      drawingLayer.noFill();
      
      // Draw a 5-pointed star
      float radius = abs(mouseX - startX);
      drawStar(drawingLayer, startX, startY, radius, radius * 0.4, 5);
      
      drawingLayer.endDraw();
      
      dragging = false;
      beforeDrag = null;
    }
  }
  
  // Helper function to draw a star, inspired
  void drawStar(PGraphics pg, float x, float y, float radius1, float radius2, int npoints) {
    // pg - PGraphics object to draw on
    // x - Center x coordinate
    // y - Center y coordinate
    // radius 1 - outer radius (star points)
    // radius 2 - inner radius (star valleys)
    // npoints - number of points (5 for classic star)
    float angle = TWO_PI / npoints; // Angle between points
    float halfAngle = angle / 2.0; // Angle to inner points
    pg.beginShape();
    // Start from top and work around clockwise
    for (float a = -PI/2; a < TWO_PI - PI/2; a += angle) {
      // Outer point
      float sx = x + cos(a) * radius1;
      float sy = y + sin(a) * radius1;
      pg.vertex(sx, sy);
      // Inner point (valley if you will)
      sx = x + cos(a + halfAngle) * radius2;
      sy = y + sin(a + halfAngle) * radius2;
      pg.vertex(sx, sy);
    }
    pg.endShape(CLOSE);
  }
}
