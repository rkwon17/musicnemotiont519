class Circle
{
  float r;
  float xpos;
  float ypos;
  color c;

  Circle()
  {
    xpos = (width)/4;
    ypos = (height)/4;
    r = 25;
   c = color(255,255,255);
    
  }
  void display()
  {
    noStroke();
    //fill(255,80);
     //c = color(255,255,0);
 
    ellipse(xpos,ypos,r*2,r*2);
  //createShape(ELLIPSE, xpos, ypos, r*2, r*2);
  
  }


  
}
