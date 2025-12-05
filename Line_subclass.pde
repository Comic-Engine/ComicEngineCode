class LineTool extends Tool {
  float startX, startY;
  boolean dragging = false;
  
  LineTool(float size, color c) {
    super(size, c);
  }
  
  void mousePressed() {
    startX = mouseX;
    startY = mouseY;
    dragging = true;
  }
  
  void mouseReleased() {
    if(dragging) {
      stroke(toolColor);
      strokeWeight(toolSize);
      line(startX, startY, mouseX, mouseY);
      dragging = false;
    }
  }
  
  void mouseDragged() {
    // Does nothing overriding Tool class
  }
  
  void preview() {
    if (dragging) {
      stroke(toolColor);
      strokeWeight(toolSize);
      line(startX, startY, mouseX, mouseY);
    }
  }
}
