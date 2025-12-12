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
