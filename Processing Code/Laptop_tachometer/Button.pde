// button class
class Button{
  float xpos, ypos, wid, hei;
  String label;
  boolean over = false, pressed = false; 
  Button
  (
    float tx, float ty,
    float tw, float th,
    String tlabel
  )
  {
    xpos = tx;
    ypos = ty;
    wid = tw;
    hei = th; 
    label = tlabel;
  }
  
  void update()
  {
    smooth();
    fill(0);
    strokeWeight(4);
    rect(xpos, ypos, wid, hei, 10);
    // center text
    fill(255);
    textSize(24); 
    text(label, xpos+wid/2-(textWidth(label)/2), ypos+hei/2+(textAscent()/2)); 
    // check if mouse pressed
    if(mouseX>xpos && mouseY>ypos && mouseX<xpos+wid && mouseY<ypos+hei)
    {
      over = true;
      if(mousePressed)
      {
        pressed = true;
      }else
      {
        pressed = false;
      }
    }else
     {
        over = false;
     }
  }
}
