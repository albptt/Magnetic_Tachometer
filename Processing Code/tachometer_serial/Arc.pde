// Arc class
class Arc{
  float xpos, ypos, wid, hei, angleOn, angleOff;
  Arc
  (
    float tx, float ty,
    float tw, float th,
    float ang1, float ang2
  )
  {
    xpos = tx;
    ypos = ty;
    wid = tw;
    hei = th; 
    angleOn = ang1;
    angleOff = ang2;
  }
  void update()
  {
    strokeWeight(8);
    arc(xpos, ypos, wid, hei, angleOn, angleOff);
    if(rpm<=100)
    {
      stroke(#03FF00);
    }
    else if(rpm<=300)
    {
      stroke(#FF9100);
    }
    else
    {
      stroke(#FF0000);
    }
  }

}
