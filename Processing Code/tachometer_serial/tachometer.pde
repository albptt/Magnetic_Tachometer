import processing.serial.*;

Serial port;
PImage needle, speedcircle;
float angle = 0.0;
int rpm = 0;
int state = 0;

// finite automaton states
static final int HOME = 0;
static final int RPM_METER = 1;
static final int KMH_METER = 2;
static final int DISTANCE_METER = 3;
static final int COMPASS = 4;
static final int LOG = 5;

// button variables
Button b1, b2, b3, b4, b5, b6;
// arc variable
Arc arc;

void setup() {
  size(600,600);
  //port = new Serial(this,"COM5",9600);
  //port.bufferUntil('\n'); // set up to read full lines of data
  // load images
  needle = loadImage("needle.png");
  speedcircle = loadImage("speedcircle.png");
  // button declarations
  b1 = new Button(width/3,height/2.5,200,50,"RPM");
  b2 = new Button(width/3,height/1.97,200,50,"KM/H");
  b3 = new Button(width/3,height/1.62,200,50,"DISTANCE");
  b4 = new Button(width/3,height/1.38,200,50,"COMPASS");
  b5 = new Button(width/3,height/1.2,200,50,"LOG");
  b6 = new Button(width/1.2,height/1.2,90,75,"HOME");
  // arc declaration
  arc = new Arc(width/2, height/4, width/3, width/3, 0, 360);
}

void draw(){
  background(255);
 
  
  switch (state)
  {
    case HOME:
    b1.update();
    b2.update();
    b3.update();
    b4.update();
    b5.update();
    
    if (b1.pressed == true)
    { 
      state = RPM_METER;
      b1.pressed = false;
    }
    else if (b2.pressed == true)
    { 
      state = KMH_METER;
      b2.pressed = false;
    }
    else if (b3.pressed == true)
    { 
      state = DISTANCE_METER;
      b3.pressed = false;
    }
    else if (b4.pressed == true)
    { 
      state = COMPASS;
      b4.pressed = false;
    }
    else if (b5.pressed == true)
    { 
      state = LOG;
      b5.pressed = false;
    }
    break;
    
    case RPM_METER:
    drawMeterRPM();
    speedo();
    b6.update();
    if (b6.pressed == true)
    {
      state = HOME;
      b6.pressed = false;
      stroke(0);
    }
    break;
    
    case KMH_METER:
    //drawMeterRPM();
    //speedo();
    b6.update();
    if (b6.pressed == true)
    {
      state = HOME;
      b6.pressed = false;
    }
    break;
    
    case DISTANCE_METER:
    
    b6.update();
    if (b6.pressed == true)
    {
      state = HOME;
      b6.pressed = false;
    }
    break;
    
    case COMPASS:
    
    b6.update();
    if (b6.pressed == true)
    {
      state = HOME;
      b6.pressed = false;
    }
    break;
    
    case LOG:
    
    b6.update();
    if (b6.pressed == true)
    {
      state = HOME;
      b6.pressed = false;
    }
    break;
    
  }
  
}

// draw RPM meter
void drawMeterRPM()
{ // show tachometer
  imageMode(CENTER);
  image(speedcircle, width/2, height/4, width/2, width/2);
  // show color feedback
  arc.update();
  // show RPM value
  textSize(10);
  fill(0);
  //textAlign(CENTER);
  text("RPM = "+ rpm, width/2.12, height/3);
}

// update needle angle
void speedo()
{ 
  pushMatrix();
  translate(width/2,height/4);
  angle = map(rpm,0,520,104,145);
  rotate(angle*0.1);
  tint(255, 0, 0); 
  image(needle,0,0,width/3.5,width/3.5);
  noTint();
  popMatrix();  
}

// get data from serial port
void serialEvent(Serial port) 
{  
  // get measure
  String inputString = port.readStringUntil('\n');
  // check correctnes
  if(inputString != null) 
  {
      try 
    {
      // convert to integer
      rpm = Integer.parseInt(inputString.trim()); 
    } 
      catch (NumberFormatException e) 
    {
      rpm = 0;
    }
  }
}
