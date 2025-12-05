class PencilTool extends Tool {
  PencilTool(float size, color c) {
    super(size, c);
  }
}

class EraserTool extends Tool {
  EraserTool(float size, color c) {
    super(size, c);
  }
}

class LineTool extends Tool {
  float startX, startY;
  PImage beforeDrag; // snapshot before drawing the preview
  boolean dragging = false;
  
  LineTool(float size, color c) {
    super(size, c);
  }
  
  void mousePressed() {
    startX = mouseX;
    startY = mouseY;
    beforeDrag = get(); // take snapshot of canvas once
    dragging = true;
  }
  
  void mouseReleased() {
    if(dragging) {
      // restore original canvas
      image(beforeDrag, 0, 0);
      // draw preview line
      stroke(toolColor);
      strokeWeight(toolSize);
      line(startX, startY, mouseX, mouseY);
      dragging = false;
    }
  }
  
  void mouseDragged() {
    if(dragging) {
      // restore original canvas
      image(beforeDrag, 0, 0);
      // draw preview line
      stroke(toolColor);
      strokeWeight(toolSize);
      line(startX, startY, mouseX, mouseY);
    }
  }
}
