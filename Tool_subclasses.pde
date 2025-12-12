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
