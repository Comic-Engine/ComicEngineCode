class PencilTool extends Tool {
  PencilTool(float size) {
    super(size, color(0));
  }

  void mouseDragged() {
    // Overwrite tool class 
    stroke(toolColor);
    strokeWeight(toolSize);
    line(pmouseX, pmouseY, mouseX, mouseY);
  }
}
