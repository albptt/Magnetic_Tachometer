 import processing.serial.*;

Serial port;
PImage needle, speedcircle, speedcircleTwo, home, reset, wheel;
PFont myTitle, mySubtitle;
float angle = 0.0; // degrees
float bikeRadius = 0.33; // meters
int rpm = 0;
int rpmMax = 0, rpmMin = 0;
float kmh = 0.0;
float kmhMax = 0.0, kmhMin = 0.0;
int new_timestamp, old_timestamp, interval;
float km = 0.0;
String durationText;
int durationH = 0;
int durationM = 0;
int durationS = 0;
long currentTime = 0;
long startTime = 0;
long elapsedTime = 0;
int state = 0;
int s; // seconds
int m; // minutes
int h; // hours
float location = 0.0;

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
// home icon
float xHomeCoord;
float yHomeCoord;
int dimHome;
// reset icon
float xResetCoord;
float yResetCoord;
int dimReset;

void setup() {
  //size(displayWidth,displayHeight);
  size(600,600);
  //port = new Serial(this,"COM5",9600);
  //port.bufferUntil('\n'); // set up to read full lines of data
  // load images
  needle = loadImage("needle.png");
  speedcircle = loadImage("speedcircle.png");
  speedcircleTwo = loadImage("speedcircleTwo.png");
  home = loadImage("home.png");
  wheel = loadImage("wheel.png");
  reset = loadImage("reset.png");
  // set font
  myTitle = createFont("Palatino Linotype", 70);
  mySubtitle = createFont("Palatino Linotype", 30);
  // button declarations
  b1 = new Button(width/3,height/2.5,200,50,"RPM");
  b2 = new Button(width/3,height/1.97,200,50,"KM/H");
  b3 = new Button(width/3,height/1.62,200,50,"DISTANCE");
  b4 = new Button(width/3,height/1.38,200,50,"COMPASS");
  b5 = new Button(width/3,height/1.2,200,50,"LOG");
  // arc declaration
  arc = new Arc(width/2, height/4, width/3, width/3, 0, 360);
  
  startTime = millis();
}

void draw(){
  background(255);
  imageMode(CENTER);
  updateTime();
  updateDuration();
  
  switch (state)
  {
    case HOME:
    drawTitle();
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
    drawHome();
    speedoRPM();

    break;
    
    case KMH_METER:
    drawMeterKM();
    speedoKM();
    drawHome();

    break;
    
    case DISTANCE_METER:
    drawTable();
    drawDistanceData();
    drawReset();
    drawHome();

    break;
    
    case COMPASS:
    drawHome();

    break;
    
    case LOG:
    drawTable();
    drawLogData();
    drawReset();
    drawHome();
    break;
    
  }
  
}

// set title
void drawTitle()
{
  image(wheel, width/1.3, height/5.5, 150,150);
  textFont(myTitle);
  fill(0);
  text("G.L.A.M.", width/8, height/5.5);
  textFont(mySubtitle);
  fill(0);
  text("Magnetic Tachometer", width/8, height/4);
}

// draw lines for tabular data
void drawTable()
{
  line(50,50,width-50,50);
  line(50,150,width-50,150);
  line(50,250,width-50,250);
  line(50,350,width-50,350);
  line(50,450,width-50,450);
}

// update time
void updateTime()
{
  s = second(); 
  m = minute(); 
  h = hour(); 
}

// update duration
void updateDuration()
{
  currentTime = millis();
  elapsedTime = currentTime - startTime;
  // Format the elapsed time
  durationH = (int) (elapsedTime / 3600000);
  durationM = (int) ((elapsedTime % 3600000) / 60000);
  durationS = (int) ((elapsedTime % 60000) / 1000);
  
}

// display distance data
void drawDistanceData()
{
  textSize(30);
  fill(0);
  text("DISTANCE [km] = "+ km, 150, 110);
  text("LOCATION = "+ location, 150, 210);
  durationText = String.format("DURATION = %02d:%02d:%02d", durationH, durationM, durationS);
  text(durationText, 150, 310);
  text("TIME = "+h+":"+m+":"+s, 150, 410);
}

// display log data
void drawLogData()
{
  textSize(30);
  fill(0);
  text("MAX RPM = "+ rpmMax, 150, 110);
  text("MIN RPM = "+ rpmMin, 150, 210);
  text("MAX KM/H = "+ kmhMax, 150, 310);
  text("MIN KM/H = "+ kmhMin, 150, 410);
}

// draw reset icon
void drawReset()
{
  xResetCoord = 50;
  yResetCoord = height/1.2;
  dimReset = 75;  
  image(reset, xResetCoord+dimReset/2,yResetCoord+dimReset/2,dimReset,dimReset);
}

// draw home icon
void drawHome()
{ 
  xHomeCoord = width-100;
  yHomeCoord = height/1.2;
  dimHome = 75;  
  image(home, xHomeCoord+dimHome/2,yHomeCoord+dimHome/2,dimHome,dimHome);
}

// return to homepage by pressing home icon 
void mousePressed()
{
  // return to homepage by pressing icon
  if(state != HOME){
    if( (mouseX > xHomeCoord && mouseX < xHomeCoord+dimHome) && (mouseY > yHomeCoord && mouseY < yHomeCoord+dimHome) ) 
    { 
      state = HOME;
      stroke(0);
    }
  }
  // reset data by pressing reset icon
  if(state == LOG || state == DISTANCE_METER){
    if( (mouseX > xResetCoord && mouseX < xResetCoord+dimReset) && (mouseY > yResetCoord && mouseY < yResetCoord+dimReset) ) 
    { 
      kmhMax = 0.0;
      kmhMin = 0.0;
      rpmMax = 0;
      rpmMin = 0;
      km = 0;
      durationH = 0;
      durationM = 0;
      durationS = 0;
      startTime = millis();
      stroke(0);
    }
  }
}  

// draw RPM meter
void drawMeterRPM()
{ // show tachometer
  //imageMode(CENTER);
  image(speedcircle, width/2, height/4, width/2, width/2);
  // show color feedback
  arc.update();
  // show RPM value
  textSize(10);
  fill(0);
  //textAlign(CENTER);
  text("RPM = "+ rpm, width/2.12, height/3);
}

// draw KM/H meter
void drawMeterKM()
{ // show tachometer
  //imageMode(CENTER);
  image(speedcircleTwo, width/2, height/4, width/2, width/2);
  // show color feedback
  arc.update();
  // show RPM value
  textSize(10);
  fill(0);
  //textAlign(CENTER);
  text("KM/H = "+ kmh, width/2.18, height/3);
}

// update needle angle RPM
void speedoRPM()
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

// update needle angle KM/H
void speedoKM()
{ 
  pushMatrix();
  translate(width/2,height/4);
  angle = map(kmh,0,65,104,145);
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
      // get km/h
      kmh = rpm*2*PI*bikeRadius*0.06;
      // get km
      new_timestamp = millis();
      interval = new_timestamp - old_timestamp;
      old_timestamp = new_timestamp;
      km += kmh*interval/1000;
      // save RPM values for LOG
      if(rpm > rpmMax) rpmMax = rpm;
      else if(rpm < rpmMin) rpmMin = rpm;
      // save KM/H values for LOG
      if(kmh > kmhMax) kmhMax = kmh;
      else if(kmh < kmhMin) kmhMin = kmh;
    } 
      catch (NumberFormatException e) 
    {
      rpm = 0;
    }
  }
}
