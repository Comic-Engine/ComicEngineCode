class EraserTool extends Tool {
  EraserTool() {
    super(45, color(255)); // White eraser, bigger size
  }

  void mouseDragged() {
    stroke(toolColor);
    strokeWeight(toolSize);
    line(pmouseX, pmouseY, mouseX, mouseY);
  }
}
