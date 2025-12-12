class RectangleTool extends Tool {
  float startX, startY;
  PImage beforeDrag;
  boolean dragging = false;

  RectangleTool(float size, color c){
    super(size, c);
  }

  void mousePressed() {
    startAction();
    startX = mouseX;
    startY = mouseY;
    beforeDrag = drawingLayer.get();  // snapshot for preview only
    dragging = true;
  }

  void mouseDragged() {
    if(dragging){
      drawingLayer.beginDraw();
      drawingLayer.image(beforeDrag, 0, 0);
      drawingLayer.stroke(toolColor);
      drawingLayer.strokeWeight(toolSize);
      drawingLayer.noFill();
      drawingLayer.rectMode(CENTER);
      float w = abs(mouseX - startX) * 2;
      float h = abs(mouseY - startY) * 2;
      drawingLayer.rect(startX, startY, w, h);
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
      drawingLayer.rectMode(CENTER);
      float w = abs(mouseX - startX) * 2;
      float h = abs(mouseY - startY) * 2;
      drawingLayer.rect(startX, startY, w, h);
      drawingLayer.endDraw();
      
      dragging = false;
      beforeDrag = null;
    }
  }
}

class TriangleTool extends Tool {
  float startX, startY;
  PImage beforeDrag;
  boolean dragging = false;
  
  TriangleTool(float size, color c){
    super(size, c);
  }
  
  void mousePressed() {
    startAction();
    startX = screenToCanvasX(mouseX);
    startY = screenToCanvasY(mouseY);
    beforeDrag = drawingLayer.get();
    dragging = true;
  }
  
  void mouseDragged() {
    if(dragging){
      float canvasX = screenToCanvasX(mouseX);
      float canvasY = screenToCanvasY(mouseY);
      
      drawingLayer.beginDraw();
      drawingLayer.background(255);
      drawingLayer.image(beforeDrag, 0, 0);
      drawingLayer.stroke(toolColor);
      drawingLayer.strokeWeight(toolSize / zoomLevel);
      drawingLayer.noFill();
      
      // Calculate triangle points (equilateral-ish)
      float w = abs(canvasX - startX) * 2;
      float h = abs(canvasY - startY) * 2;
      float topX = startX;
      float topY = startY - h/2;
      float leftX = startX - w/2;
      float leftY = startY + h/2;
      float rightX = startX + w/2;
      float rightY = startY + h/2;
      
      drawingLayer.triangle(topX, topY, leftX, leftY, rightX, rightY);
      drawingLayer.endDraw();
    }
  }
  
  void mouseReleased() {
    if(dragging){
      float canvasX = screenToCanvasX(mouseX);
      float canvasY = screenToCanvasY(mouseY);
      
      drawingLayer.beginDraw();
      drawingLayer.background(255);
      drawingLayer.image(beforeDrag, 0, 0);
      drawingLayer.stroke(toolColor);
      drawingLayer.strokeWeight(toolSize / zoomLevel);
      drawingLayer.noFill();
      
      // Calculate triangle points
      float w = abs(canvasX - startX) * 2;
      float h = abs(canvasY - startY) * 2;
      float topX = startX;
      float topY = startY - h/2;
      float leftX = startX - w/2;
      float leftY = startY + h/2;
      float rightX = startX + w/2;
      float rightY = startY + h/2;
      
      drawingLayer.triangle(topX, topY, leftX, leftY, rightX, rightY);
      drawingLayer.endDraw();
      
      dragging = false;
      beforeDrag = null;
    }
  }
}

class EllipseTool extends Tool {
  float startX, startY;
  PImage beforeDrag;
  boolean dragging = false;
  
  EllipseTool(float size, color c){
    super(size, c);
  }
  
  void mousePressed() {
    startAction();
    startX = screenToCanvasX(mouseX);
    startY = screenToCanvasY(mouseY);
    beforeDrag = drawingLayer.get();
    dragging = true;
  }
  
  void mouseDragged() {
    if(dragging){
      float canvasX = screenToCanvasX(mouseX);
      float canvasY = screenToCanvasY(mouseY);
      
      drawingLayer.beginDraw();
      drawingLayer.background(255);
      drawingLayer.image(beforeDrag, 0, 0);
      drawingLayer.stroke(toolColor);
      drawingLayer.strokeWeight(toolSize / zoomLevel);
      drawingLayer.noFill();
      drawingLayer.ellipseMode(CENTER);
      float w = abs(canvasX - startX) * 2;
      float h = abs(canvasY - startY) * 2;
      drawingLayer.ellipse(startX, startY, w, h);
      drawingLayer.endDraw();
    }
  }
  
  void mouseReleased() {
    if(dragging){
      float canvasX = screenToCanvasX(mouseX);
      float canvasY = screenToCanvasY(mouseY);
      
      drawingLayer.beginDraw();
      drawingLayer.background(255);
      drawingLayer.image(beforeDrag, 0, 0);
      drawingLayer.stroke(toolColor);
      drawingLayer.strokeWeight(toolSize / zoomLevel);
      drawingLayer.noFill();
      drawingLayer.ellipseMode(CENTER);
      float w = abs(canvasX - startX) * 2;
      float h = abs(canvasY - startY) * 2;
      drawingLayer.ellipse(startX, startY, w, h);
      drawingLayer.endDraw();
      
      dragging = false;
      beforeDrag = null;
    }
  }
}

class StarTool extends Tool {
  float startX, startY;
  PImage beforeDrag;
  boolean dragging = false;
  
  StarTool(float size, color c){
    super(size, c);
  }
  
  void mousePressed() {
    startAction();
    startX = screenToCanvasX(mouseX);
    startY = screenToCanvasY(mouseY);
    beforeDrag = drawingLayer.get();
    dragging = true;
  }
  
  void mouseDragged() {
    if(dragging){
      float canvasX = screenToCanvasX(mouseX);
      float canvasY = screenToCanvasY(mouseY);
      
      drawingLayer.beginDraw();
      drawingLayer.background(255);
      drawingLayer.image(beforeDrag, 0, 0);
      drawingLayer.stroke(toolColor);
      drawingLayer.strokeWeight(toolSize / zoomLevel);
      drawingLayer.noFill();
      
      // Draw a 5-pointed star
      float radius = abs(canvasX - startX);
      drawStar(drawingLayer, startX, startY, radius, radius * 0.4, 5);
      
      drawingLayer.endDraw();
    }
  }
  
  void mouseReleased() {
    if(dragging){
      float canvasX = screenToCanvasX(mouseX);
      float canvasY = screenToCanvasY(mouseY);
      
      drawingLayer.beginDraw();
      drawingLayer.background(255);
      drawingLayer.image(beforeDrag, 0, 0);
      drawingLayer.stroke(toolColor);
      drawingLayer.strokeWeight(toolSize / zoomLevel);
      drawingLayer.noFill();
      
      // Draw a 5-pointed star
      float radius = abs(canvasX - startX);
      drawStar(drawingLayer, startX, startY, radius, radius * 0.4, 5);
      
      drawingLayer.endDraw();
      
      dragging = false;
      beforeDrag = null;
    }
  }
  
  // Helper function to draw a star
  void drawStar(PGraphics pg, float x, float y, float radius1, float radius2, int npoints) {
    float angle = TWO_PI / npoints;
    float halfAngle = angle / 2.0;
    pg.beginShape();
    for (float a = -PI/2; a < TWO_PI - PI/2; a += angle) {
      float sx = x + cos(a) * radius1;
      float sy = y + sin(a) * radius1;
      pg.vertex(sx, sy);
      sx = x + cos(a + halfAngle) * radius2;
      sy = y + sin(a + halfAngle) * radius2;
      pg.vertex(sx, sy);
    }
    pg.endShape(CLOSE);
  }
}
