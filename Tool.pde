class Tool {
  float toolSize;
  float toolColor;
  
  Tool(float size, color c) {
    this.toolSize = size;
    this.toolColor = c;
  }
  
  void mouseDragged() {
    stroke(toolColor);
    strokeWeight(toolSize);
    line(pmouseX, pmouseY, mouseX, mouseY);
  }
}
