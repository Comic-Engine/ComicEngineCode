class EraserTool extends Tool {
  EraserTool(float size) {
    super(size, color(255));
  }

  void mouseDragged() {
    // Overwrite tool class 
    stroke(toolColor);
    strokeWeight(toolSize);
    line(pmouseX, pmouseY, mouseX, mouseY);
  }
}
