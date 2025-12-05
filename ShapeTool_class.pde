class ShapeTool extends Tool {
  Shape currentShape = null;
  String shapeType = "rectangle"; // Integrate gui  later
  PImage snapshot;
  
  ShapeTool(float size, color c) {
    super(size, c);
  }
  
  void mousePressed() {
    snapshot = get();
    currentShape = new RectangleShape(mouseX, mouseY, mouseX, mouseY, toolColor, toolSize);
  }
  
  void mouseDragged() {
    if(currentShape != null){
      currentShape.x2 = mouseX;
      currentShape.y2 = mouseY;
      image(snapshot, 0, 0);
      currentShape.draw();
    }
  }
  
  void mouseReleased() {
    if(currentShape != null) {
      shapes.add(currentShape);
      snapshot = null;
    }
  }
  
}
