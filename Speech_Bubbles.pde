// Normal Speech Bubble - classic comic speech bubble with tail
class SpeechBubbleTool extends Tool {
  float startX, startY;
  PImage beforeDrag;
  boolean dragging = false;
  
  SpeechBubbleTool(float size, color c){
    super(size, c);
  }
  
  void mousePressed() {
    startAction(); // Save undo snapshot
    startX = mouseX;
    startY = mouseY;
    beforeDrag = drawingLayer.get();
    dragging = true;
  }
  
  void mouseDragged() {
    if(dragging){
      drawingLayer.beginDraw();
      drawingLayer.image(beforeDrag, 0, 0);
      drawingLayer.stroke(toolColor);
      drawingLayer.strokeWeight(toolSize);
      drawingLayer.fill(255); // White fill for text area
      
      float w = abs(mouseX - startX) * 2;
      float h = abs(mouseY - startY) * 2;
      
      // Draw main bubble (ellipse)
      drawingLayer.ellipseMode(CENTER);
      drawingLayer.ellipse(startX, startY, w, h);
      
      // Draw tail pointing down-left
      float tailX = startX - w * 0.25;
      float tailY = startY + h * 0.35;
      drawingLayer.triangle(
        tailX, tailY,
        tailX - w * 0.15, tailY + h * 0.25,
        tailX + w * 0.05, tailY + h * 0.15
      );
      
      drawingLayer.endDraw();
    }
  }
  
  void mouseReleased() {
    if(dragging){
      drawingLayer.beginDraw();
      drawingLayer.image(beforeDrag, 0, 0);
      drawingLayer.stroke(toolColor);
      drawingLayer.strokeWeight(toolSize);
      drawingLayer.fill(255);
      
      float w = abs(mouseX - startX) * 2;
      float h = abs(mouseY - startY) * 2;
      
      drawingLayer.ellipseMode(CENTER);
      drawingLayer.ellipse(startX, startY, w, h);
      
      float tailX = startX - w * 0.25;
      float tailY = startY + h * 0.35;
      drawingLayer.triangle(
        tailX, tailY,
        tailX - w * 0.15, tailY + h * 0.25,
        tailX + w * 0.05, tailY + h * 0.15
      );
      
      drawingLayer.endDraw();
      
      dragging = false;
      beforeDrag = null;
    }
  }
}

// Yelling Bubble - jagged spiky edges for shouting
// Convey loud or aggressive speech
class YellBubbleTool extends Tool {
  float startX, startY;
  PImage beforeDrag;
  boolean dragging = false;
  
  YellBubbleTool(float size, color c){
    super(size, c);
  }
  
  void mousePressed() {
    startAction();
    startX = mouseX;
    startY = mouseY;
    beforeDrag = drawingLayer.get();
    dragging = true;
  }
  
  void mouseDragged() {
    if(dragging){
      drawingLayer.beginDraw();
      drawingLayer.image(beforeDrag, 0, 0);
      drawingLayer.stroke(toolColor);
      drawingLayer.strokeWeight(toolSize);
      drawingLayer.fill(255);
      
      float w = abs(mouseX - startX);
      float h = abs(mouseY - startY);
      
      // Draw spiky polygon
      drawSpikeyBubble(drawingLayer, startX, startY, w, h, 12);
      
      drawingLayer.endDraw();
    }
  }
  
  void mouseReleased() {
    if(dragging){
      drawingLayer.beginDraw();
      drawingLayer.image(beforeDrag, 0, 0);
      drawingLayer.stroke(toolColor);
      drawingLayer.strokeWeight(toolSize);
      drawingLayer.fill(255);
      
      float w = abs(mouseX - startX);
      float h = abs(mouseY - startY);
      
      drawSpikeyBubble(drawingLayer, startX, startY, w, h, 12);
      
      drawingLayer.endDraw();
      
      dragging = false;
      beforeDrag = null;
    }
  }
  
  // Helper function to draw a spiky bubble shape (similar to star)
  void drawSpikeyBubble(PGraphics pg, float cx, float cy, float w, float h, int spikes) {
    // PGraphics to draw on
    // cx - center X
    // cy - center Y
    // w - horizantal radius
    // h - vertical radius
    pg.beginShape();
    for (int i = 0; i < spikes; i++) {
      float angle = TWO_PI / spikes * i;
      
      // Outer spike point
      float x1 = cx + cos(angle) * w;
      float y1 = cy + sin(angle) * h;
      pg.vertex(x1, y1);
      
      // Inner point (between spikes) jaggy effect
      float angle2 = angle + TWO_PI / spikes / 2;
      float x2 = cx + cos(angle2) * w * 0.7;
      float y2 = cy + sin(angle2) * h * 0.7;
      pg.vertex(x2, y2);
    }
    pg.endShape(CLOSE);
  }
}

// Announcement/Broadcast Bubble
// Formal rectangular shape with decorative corners for narration
class AnnounceBubbleTool extends Tool {
  float startX, startY;
  PImage beforeDrag;
  boolean dragging = false;
  
  AnnounceBubbleTool(float size, color c){
    super(size, c);
  }
  
  void mousePressed() {
    startAction();
    startX = mouseX;
    startY = mouseY;
    beforeDrag = drawingLayer.get();
    dragging = true;
  }
  
  void mouseDragged() {
    if(dragging){
      drawingLayer.beginDraw();
      drawingLayer.image(beforeDrag, 0, 0);
      drawingLayer.stroke(toolColor);
      drawingLayer.strokeWeight(toolSize);
      drawingLayer.fill(255);
      
      float w = abs(mouseX - startX) * 2;
      float h = abs(mouseY - startY) * 2;
      
      // Main rectangle with rounded corners
      drawingLayer.rectMode(CENTER);
      drawingLayer.rect(startX, startY, w, h, 10);
      
      // Decorative corner triangles
      float cornerSize = min(w, h) * 0.15;
      
      // Top left corner
      drawingLayer.triangle(
        startX - w/2, startY - h/2,
        startX - w/2 + cornerSize, startY - h/2,
        startX - w/2, startY - h/2 + cornerSize
      );
      
      // Top right corner
      drawingLayer.triangle(
        startX + w/2, startY - h/2,
        startX + w/2 - cornerSize, startY - h/2,
        startX + w/2, startY - h/2 + cornerSize
      );
      
      // Bottom left corner
      drawingLayer.triangle(
        startX - w/2, startY + h/2,
        startX - w/2 + cornerSize, startY + h/2,
        startX - w/2, startY + h/2 - cornerSize
      );
      
      // Bottom right corner
      drawingLayer.triangle(
        startX + w/2, startY + h/2,
        startX + w/2 - cornerSize, startY + h/2,
        startX + w/2, startY + h/2 - cornerSize
      );
      
      drawingLayer.endDraw();
    }
  }
  
  void mouseReleased() {
    if(dragging){
      drawingLayer.beginDraw();
      drawingLayer.image(beforeDrag, 0, 0);
      drawingLayer.stroke(toolColor);
      drawingLayer.strokeWeight(toolSize);
      drawingLayer.fill(255);
      
      float w = abs(mouseX - startX) * 2;
      float h = abs(mouseY - startY) * 2;
      
      drawingLayer.rectMode(CENTER);
      drawingLayer.rect(startX, startY, w, h, 10);
      
      float cornerSize = min(w, h) * 0.15;
      
      drawingLayer.triangle(
        startX - w/2, startY - h/2,
        startX - w/2 + cornerSize, startY - h/2,
        startX - w/2, startY - h/2 + cornerSize
      );
      
      drawingLayer.triangle(
        startX + w/2, startY - h/2,
        startX + w/2 - cornerSize, startY - h/2,
        startX + w/2, startY - h/2 + cornerSize
      );
      
      drawingLayer.triangle(
        startX - w/2, startY + h/2,
        startX - w/2 + cornerSize, startY + h/2,
        startX - w/2, startY + h/2 - cornerSize
      );
      
      drawingLayer.triangle(
        startX + w/2, startY + h/2,
        startX + w/2 - cornerSize, startY + h/2,
        startX + w/2, startY + h/2 - cornerSize
      );
      
      drawingLayer.endDraw();
      
      dragging = false;
      beforeDrag = null;
    }
  }
}

// Thought/Dream Bubble
// cloud-like with small bubbles leading to it and overlapping circles to create cloud effect
class ThoughtBubbleTool extends Tool {
  float startX, startY;
  PImage beforeDrag;
  boolean dragging = false;
  
  ThoughtBubbleTool(float size, color c){
    super(size, c);
  }
  
  void mousePressed() {
    startAction();
    startX = mouseX;
    startY = mouseY;
    beforeDrag = drawingLayer.get();
    dragging = true;
  }
  
  void mouseDragged() {
    if(dragging){
      drawingLayer.beginDraw();
      drawingLayer.image(beforeDrag, 0, 0);
      drawingLayer.stroke(toolColor);
      drawingLayer.strokeWeight(toolSize);
      drawingLayer.fill(255);
      
      float w = abs(mouseX - startX) * 2;
      float h = abs(mouseY - startY) * 2;
      
      // Draw cloud-like thought bubble (multiple overlapping circles)
      drawingLayer.ellipseMode(CENTER);
      
      // Main large circle in center
      drawingLayer.ellipse(startX, startY, w * 0.8, h * 0.8);
      
      // Smaller circles around the edge for cloud effect and texture
      float r = w * 0.2;
      drawingLayer.ellipse(startX - w * 0.3, startY - h * 0.15, r, r);
      drawingLayer.ellipse(startX + w * 0.3, startY - h * 0.15, r, r);
      drawingLayer.ellipse(startX - w * 0.25, startY + h * 0.2, r, r);
      drawingLayer.ellipse(startX + w * 0.25, startY + h * 0.2, r, r);
      drawingLayer.ellipse(startX, startY - h * 0.3, r * 0.9, r * 0.9);
      
      // Small thought bubbles leading away (toward speaker)
      float bubbleX = startX - w * 0.3;
      float bubbleY = startY + h * 0.4;
      drawingLayer.ellipse(bubbleX, bubbleY, w * 0.12, h * 0.12);
      drawingLayer.ellipse(bubbleX - w * 0.15, bubbleY + h * 0.15, w * 0.08, h * 0.08);
      
      drawingLayer.endDraw();
    }
  }
  
  void mouseReleased() {
    if(dragging){
      drawingLayer.beginDraw();
      drawingLayer.image(beforeDrag, 0, 0);
      drawingLayer.stroke(toolColor);
      drawingLayer.strokeWeight(toolSize);
      drawingLayer.fill(255);
      
      float w = abs(mouseX - startX) * 2;
      float h = abs(mouseY - startY) * 2;
      
      drawingLayer.ellipseMode(CENTER);
      
      drawingLayer.ellipse(startX, startY, w * 0.8, h * 0.8);
      
      float r = w * 0.2;
      drawingLayer.ellipse(startX - w * 0.3, startY - h * 0.15, r, r);
      drawingLayer.ellipse(startX + w * 0.3, startY - h * 0.15, r, r);
      drawingLayer.ellipse(startX - w * 0.25, startY + h * 0.2, r, r);
      drawingLayer.ellipse(startX + w * 0.25, startY + h * 0.2, r, r);
      drawingLayer.ellipse(startX, startY - h * 0.3, r * 0.9, r * 0.9);
      
      float bubbleX = startX - w * 0.3;
      float bubbleY = startY + h * 0.4;
      drawingLayer.ellipse(bubbleX, bubbleY, w * 0.12, h * 0.12);
      drawingLayer.ellipse(bubbleX - w * 0.15, bubbleY + h * 0.15, w * 0.08, h * 0.08);
      
      drawingLayer.endDraw();
      
      dragging = false;
      beforeDrag = null;
    }
  }
}
