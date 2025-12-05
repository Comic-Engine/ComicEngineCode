class PencilTool extends Tool {
  PencilTool(float size, color c){
    super(size, c);
  }
  
  void mousePressed() {
    startAction(); // save undo snapshot
  }
  
  void mouseDragged() {
    stroke(toolColor);
    strokeWeight(toolSize);
    line(pmouseX, pmouseY, mouseX, mouseY);
  }
}

class EraserTool extends Tool {
  EraserTool(float size, color c){
    super(size, c);
  }

  void mousePressed() {
    startAction();
  }

  void mouseDragged() {
    stroke(255);
    strokeWeight(toolSize);
    line(pmouseX, pmouseY, mouseX, mouseY);
  }
}

class LineTool extends Tool {
  float startX, startY;
  PImage beforeDrag;
  boolean dragging = false;

  LineTool(float size, color c){
    super(size, c);
  }

  void mousePressed() {
    startAction();
    startX = mouseX;
    startY = mouseY;
    beforeDrag = get();
    dragging = true;
  }

  void mouseDragged() {
    if(dragging){
      image(beforeDrag, 0, 0);
      stroke(toolColor);
      strokeWeight(toolSize);
      line(startX, startY, mouseX, mouseY);
    }
  }

  void mouseReleased() {
    if(dragging){
      image(beforeDrag, 0, 0);
      stroke(toolColor);
      strokeWeight(toolSize);
      line(startX, startY, mouseX, mouseY);

      redoStack.clear();
      
      dragging = false;
      beforeDrag = null;
    }
  }
}
