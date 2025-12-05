class RectangleTool extends Tool {
  float startX, startY;
  PImage beforeDrag;
  RectangleShape currentRectangle;
  boolean dragging = false;
  RectangleTool(float size, color c){
    super(size, c);
  }
  
  void mousePressed() {
    startX = mouseX;
    startY = mouseY;
    beforeDrag = get(); // snapshot of canvas
    currentRectangle = new RectangleShape(startX, startY, startX, startY, toolColor, toolSize);
    dragging = true;
  }
  
  void mouseDragged() {
    if(dragging){
      image(beforeDrag, 0, 0); // restore canvas
      currentRectangle.x2 = mouseX;
      currentRectangle.y2 = mouseY;
      currentRectangle.draw();
    }
  }
  
  void mouseReleased() {
    if(dragging){
      image(beforeDrag, 0, 0); // final restore
      currentRectangle.x2 = mouseX;
      currentRectangle.y2 = mouseY;
      currentRectangle.draw();
      shapes.add(currentRectangle); // finalize
      dragging = false;
      currentRectangle = null;
      beforeDrag = null;
    }
  }
}
