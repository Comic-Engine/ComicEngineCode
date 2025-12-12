class Tool {
  float toolSize; // Size/thickness of the Tool
  color toolColor; // Color of the tool
  
  Tool(float size, color c) {
    this.toolSize = size;
    this.toolColor = c;
  }
  
  void mousePressed() {
    startAction(); // save undo snapshot
  }
  
  void mouseDragged() {
    // Called continously while mouse is dragged
    // Default draws a line from previous to current position
    drawingLayer.beginDraw();
    drawingLayer.stroke(toolColor);
    drawingLayer.strokeWeight(toolSize);
    drawingLayer.line(pmouseX, pmouseY, mouseX, mouseY);
    drawingLayer.endDraw();
  }
  
  void mouseReleased() {} // Default does nothing, to be overridden by specific tools
}
