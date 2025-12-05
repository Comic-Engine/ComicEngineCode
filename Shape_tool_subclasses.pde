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
    beforeDrag = get();  // snapshot for preview only
    dragging = true;
  }

  void mouseDragged() {
    if(dragging){
      image(beforeDrag, 0, 0); // restore original canvas
      stroke(toolColor);
      strokeWeight(toolSize);
      noFill();
      rectMode(CENTER);
      float w = abs(mouseX - startX) * 2;
      float h = abs(mouseY - startY) * 2;
      rect(startX, startY, w, h); // draw preview
    }
  }

  void mouseReleased() {
    if(dragging){
      // **Don't restore beforeDrag**, we want to draw on top of the current canvas
      stroke(toolColor);
      strokeWeight(toolSize);
      noFill();
      rectMode(CENTER);
      float w = abs(mouseX - startX) * 2;
      float h = abs(mouseY - startY) * 2;
      rect(startX, startY, w, h); // draw final rectangle


      redoStack.clear();  

      dragging = false;
      beforeDrag = null;
    }
  }
}
