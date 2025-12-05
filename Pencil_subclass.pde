class PencilTool extends Tool {
  PencilTool() {
    super(25, color(0));
  }

  void mouseDragged() {
    stroke(toolColor);
    strokeWeight(toolSize);
    line(pmouseX, pmouseY, mouseX, mouseY);
  }
}
