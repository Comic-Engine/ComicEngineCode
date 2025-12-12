class Tool {
  float toolSize;
  color toolColor;
  
  Tool(float size, color c) {
    this.toolSize = size;
    this.toolColor = c;
  }
  
  void mousePressed() {
    startAction();
  }
  
  void mouseDragged() {
    drawingLayer.beginDraw();
    drawingLayer.stroke(toolColor);
    drawingLayer.strokeWeight(toolSize);
    drawingLayer.line(pmouseX, pmouseY, mouseX, mouseY);
    drawingLayer.endDraw();
  }
  
  void mouseReleased() {}
}
