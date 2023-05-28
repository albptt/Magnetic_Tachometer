// libraries
import android.content.Intent;
import android.os.Bundle;
import android.view.WindowManager;
import android.location.Location.*;
import ketai.sensors.*; 
import ketai.net.bluetooth.*;
import ketai.ui.*;
import ketai.net.*;

// declaration
PImage needle, compassneedle, speedcircle, speedcircleTwo, compasscircle, home, reset, wheel;
PFont myTitle, mySubtitle;
float angle = 0.0; // degrees
float bikeRadius = 0.33; // meters
int rpm = 0;
int rpmMax = 0;
int sumrpm = 0, countrpm = 0;
float meanrpm = 0.0;
float kmh = 0.0, speedms = 0.0;
float kmhMax = 0.0;
float sumkmh = 0;
int countkmh = 0;
float meankmh = 0.0;
int new_timestamp = 0, old_timestamp = 0, interval = 0;
float km = 0.0;
String durationText;
int durationH = 0;
int durationM = 0;
int durationS = 0;
long currentTime = 0;
long startTime = 0;
long elapsedTime = 0;
int state = 0;
int s = 0; // seconds
int m = 0; // minutes
int h = 0; // hours
int wb = 600; // button width
int hb = 180; // button height
double latitude = 0.0, longitude = 0.0, altitude = 0.0;
float accuracy = 0.0, distance = 0.0, bearingTo = 0.0, compass = 0.0, value = 0.0;
String cardinalpoint;
KetaiLocation location;
KetaiSensor sensor;
Location destination;
KetaiBluetooth bt;
String receivedString;
StringBuilder stringBuilder;

// finite automaton states
static final int HOME = 0;
static final int RPM_METER = 1;
static final int KMH_METER = 2;
static final int DISTANCE_METER = 3;
static final int DESTINATION = 4;
static final int COMPASS = 5;
static final int LOG = 6;

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

// code required to enable bluetooth at startup
void onCreate(Bundle savedInstanceState) {
  super.onCreate(savedInstanceState);
  bt = new KetaiBluetooth(this);
}

void onActivityResult(int requestCode, int resultCode, Intent data) {
  bt.onActivityResult(requestCode, resultCode, data);
}

void setup() {
  // full screen mode
  size(displayWidth,displayHeight); // 1080 x 2501
  // make the display always on
  getActivity().getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
  // start BT connections
  bt.start();
  // start discover devices
  bt.discoverDevices();
  bt.getPairedDeviceNames();
  // connect to HC-05 bluetooth module
  bt.connectToDeviceByName("HC-05"); 
  // stringBuilder variable
  stringBuilder = new StringBuilder();
  // actual location
  location = new KetaiLocation(this);
  // destination = Politecnico of Milan 
  destination = new Location("Politecnico of Milan"); 
  // coordinates of destination
  destination.setLatitude(45.4778083);
  destination.setLongitude(9.2272468);
  // provide access to android sensors
  sensor = new KetaiSensor(this);
  sensor.start();
  // load images
  needle = loadImage("needle.png");
  compassneedle = loadImage("compassneedle.png");
  speedcircle = loadImage("speedcircle.png");
  speedcircleTwo = loadImage("speedcircleTwo.png");
  compasscircle = loadImage("compasscircle.png");
  wheel = loadImage("wheel.png");
  home = loadImage("home.png");
  reset = loadImage("reset.png");
  // set font
  myTitle = createFont("Palatino Linotype", 150);
  mySubtitle = createFont("Palatino Linotype", 55);
  // button declarations
  b1 = new Button(width/2-wb/2,height/3.29,wb,hb,"RPM");
  b2 = new Button(width/2-wb/2,height/2.5,wb,hb,"KM/H");
  b3 = new Button(width/2-wb/2,height/2,wb,hb,"DISTANCE");
  b4 = new Button(width/2-wb/2,height/1.66,wb,hb,"DESTINATION");
  b5 = new Button(width/2-wb/2,height/1.42,wb,hb,"COMPASS");
  b6 = new Button(width/2-wb/2,height/1.25,wb,hb,"LOG");
  // arc declaration
  arc = new Arc(width/2, height/3, width/1.6, width/1.6, 0, 360);
  
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
    b6.update();
    
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
      state = DESTINATION;
      b4.pressed = false;
    }
    else if (b5.pressed == true)
    { 
      state = COMPASS;
      b5.pressed = false;
    }
    else if (b6.pressed == true)
    { 
      state = LOG;
      b6.pressed = false;
    }
    
    break;
    
    case RPM_METER:
    drawMeterRPM();
    speedoRPM();
    drawHome();

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
    
    case DESTINATION:
    drawDestinationData();
    drawHome();

    break;
    
    case COMPASS:
    drawCompassData();
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
  image(wheel, width/1.29, height/6.18, 280, 280);
  textFont(myTitle);
  fill(0);
  text("G.L.A.M.", width/9.82, height/6.18);
  textFont(mySubtitle);
  fill(0);
  text("Magnetic Tachometer", width/8.64, height/5.15);
}

// draw lines for tabular data
void drawTable()
{
  strokeWeight(8);
  line(50,height/5.1,width-50,height/5.1);
  line(50,height/3.17,width-50,height/3.17);
  line(50,height/2.3,width-50,height/2.3);
  line(50,height/1.8,width-50,height/1.8);
  line(50,height/1.48,width-50,height/1.48);
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

// draw home icon
void drawHome()
{ 
  dimHome = 180;
  xHomeCoord = width-dimHome-50;
  yHomeCoord = height/1.2;  
  image(home, xHomeCoord+dimHome/2,yHomeCoord+dimHome/2,dimHome,dimHome);
}

// draw reset icon
void drawReset()
{
  dimReset = 150; 
  xResetCoord = 50;
  yResetCoord = height/1.2; 
  image(reset, xResetCoord+dimReset/2,yResetCoord+dimReset/2,dimReset,dimReset);
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
      rpmMax = 0;
      sumrpm = 0;
      sumkmh = 0;
      countrpm = 0;
      countkmh = 0;
      meanrpm = 0;
      meankmh = 0;
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
  image(speedcircle, width/2, height/3, width/1.1, width/1.1);
  // show color feedback
  arc.update();
  // show RPM value
  textSize(80);
  fill(0);
  text("RPM = "+ rpm, width/2.77, height/1.81);
}

// update needle angle RPM
void speedoRPM()
{ 
  pushMatrix();
  translate(width/2,height/3);
  angle = map(rpm,0,520,104,145);
  rotate(angle*0.1);
  tint(255, 0, 0); 
  image(needle,0,0,width/1.5,width/1.5);
  noTint();
  popMatrix();  
}

// draw KM/H meter
void drawMeterKM()
{ // show tachometer
  image(speedcircleTwo, width/2, height/3, width/1.1, width/1.1);
  // show color feedback
  arc.update();
  // show RPM value
  textSize(80);
  fill(0);
  text("KM/H = "+ nf(kmh,0,2), width/3.18, height/1.81);
}

// update needle angle KM/H
void speedoKM()
{ 
  pushMatrix();
  translate(width/2,height/3);
  angle = map(kmh,0,65,104,145);
  rotate(angle*0.1);
  tint(255, 0, 0); 
  image(needle,0,0,width/1.5,width/1.5);
  noTint();
  popMatrix();  
}

// display distance data
void drawDistanceData()
{
  textSize(80);
  fill(0);
  text("SPEED [m/s] = "+ nf(speedms,0,2), width/7.2, height/3.73);
  text("DISTANCE [km] = "+ nf(km,0,2), width/7.2, height/2.58);
  durationText = String.format("DURATION = %02d:%02d:%02d", durationH, durationM, durationS);
  text(durationText, width/7.2, height/1.97);
  text("TIME = "+h+":"+m+":"+s, width/7.2, height/1.59);
}

// get location info
void onLocationEvent(Location loc) 
{
  latitude = loc.getLatitude();
  longitude = loc.getLongitude();
  altitude = loc.getAltitude();
  accuracy = loc.getAccuracy();
}

// get cardinal points
void onOrientationEvent(float x, float y, float z, long time, int accuracy) 
{ 
  // store the rotation around the z-axis
  // azimuth angle between magnetic north and device y-axis, around z-axis
  compass = x;
  // azimuth: z-axis, pitch: x-axis, roll: y-axis
  // range: 0 to 359 degrees
  // 0=North, 90=East, 180=South, 270=West
}

// update triangle angle COMPASS
void speedoDESTINATION()
{
  pushMatrix();
  translate(width/2, height/3);      
  // rotate the triangle toward the destination
  // the angle is calculated by subtracting the device bearing toward the destination from the device orientation toward north stored in compass
  rotate(radians(bearingTo) - radians(compass));                  
  fill(0);
  triangle(-width/4, 0, width/4, 0, 0, -width/2);   
  textSize(70);
  text("Politecnico of Milan", -width/3.66, height/31.26);
  text((int)distance + " meters", -width/5.14, height/15.63);
  popMatrix(); 
}

// display destination data
void drawDestinationData()
{
  if (location == null  || location.getProvider() == "none")
  {
    textSize(80);
    fill(0);
    text("LOCATION DATA IS \n     UNAVAILABLE", width/6, height/4);
    text("PLEASE CHECK YOUR \nLOCATION  SETTINGS", width/7, height/2);
  }
  else
  {
    // direction of destination pointer
    bearingTo = location.getLocation().bearingTo(destination); 
    // distance betweeen actual position (device's location) and destination (Politecnico of Milan)
    distance = round(location.getLocation().distanceTo(destination));
    
    speedoDESTINATION();
    
    textSize(80);
    fill(0);
    text("ACCURACY [m] = " + nf(accuracy,0,2), width/9, height/1.56);
    // getProvider() returns "gps" if GPS is available otherwise "network" (cell network) or "passive" (WiFi MACID)
    text("PROVIDER = " + location.getProvider(), width/9, height/1.39); 
  }
}

// draw COMPASS
void drawCOMPASS()
{
  // show compass
  image(compasscircle, width/2, height/4, width/0.55, width/0.95);
}

// update needle angle COMPASS
void speedoCOMPASS()
{ 
  pushMatrix();
  translate(width/2,height/4);
  value = compass - 30;
  angle = map(value,0,360,0,360);
  rotate(radians(angle));
  image(compassneedle,0,0,width/2,width/2);
  popMatrix();  
}

// display compass data
void drawCompassData()
{
  if (location == null  || location.getProvider() == "none")
  {
    textSize(80);
    fill(0);
    text("LOCATION DATA IS \n     UNAVAILABLE", width/6, height/4);
    text("PLEASE CHECK YOUR \nLOCATION  SETTINGS", width/7, height/2);
  }
  else
  {
    drawCOMPASS();
    speedoCOMPASS();
    
    textSize(78);
    fill(0);
    text("LATITUDE [\u00B0] = " + nf((float)latitude,0,7), width/19.64, height/1.85);
    text("LONGITUDE [\u00B0] = " + nf((float)longitude,0,7), width/19.64, height/1.67);
    text("ALTITUDE [m] = " + nf((float)altitude,0,2), width/19.64, height/1.52); 
    text("ACCURACY [m] = " + nf(accuracy,0,2), width/19.64, height/1.39);
   if((compass < 67.5) && (compass > 22.5))  
          cardinalpoint = "NE";
       else if((compass <= 112.5) && (compass >= 67.5))  
              cardinalpoint = "E";
            else if((compass < 157.5) && (compass > 112.5))  
                    cardinalpoint = "SE";
                 else if((compass <= 202.5) && (compass >= 157.5))  
                        cardinalpoint = "S";
                      else if((compass < 247.5) && (compass > 202.5))  
                              cardinalpoint = "SW";
                           else if((compass <= 292.5) && (compass >= 247.5))  
                                   cardinalpoint = "W";
                                else if((compass < 337.5) && (compass > 292.5))  
                                        cardinalpoint = "NW";
                                     else 
                                        cardinalpoint = "N";
    text("CARDINAL POINT = " + cardinalpoint, width/19.64, height/1.28);  
  }
}

// display log data
void drawLogData()
{
  textSize(80);
  fill(0);
  text("MAX RPM = "+ rpmMax, width/5.68, height/3.73);
  text("MEAN RPM = "+ nf(meanrpm,0,2), width/5.68, height/2.58);
  text("MAX KM/H = "+ nf(kmhMax,0,2), width/5.68, height/1.97);
  text("MEAN KM/H = "+ nf(meankmh,0,2), width/5.68, height/1.59);
}

// transmission data by bluetooth
void onBluetoothDataEvent(String who, byte[] data) 
{
  try
  {
    for (byte b : data)
    {
      if (b == '\n') 
      {
        receivedString = stringBuilder.toString();
        // get RPM
        rpm = Integer.parseInt(receivedString.trim());
        // get KM/H
        kmh = rpm*2*PI*bikeRadius*0.06;
        // get M/S
        speedms = kmh/3.6;
        // get KM
        new_timestamp = millis();
        interval = new_timestamp - old_timestamp;
        old_timestamp = new_timestamp;
        km += speedms*interval/1000000;
        // save RPM MAX for LOG
        if((rpm > rpmMax) && (rpm <= 520)) rpmMax = rpm;
        // save KM/H MAX for LOG
        if((kmh > kmhMax) && (kmh <= 65)) kmhMax = kmh;
        // mean RPM and KMH
        if(rpm != 0)
        {
          sumrpm += rpm;
          countrpm ++;
          meanrpm = sumrpm/countrpm;
          sumkmh += kmh;
          countkmh ++;
          meankmh = sumkmh/countkmh;
        }
        //reset StringBuilder
        stringBuilder.setLength(0); 
      } 
      else
        stringBuilder.append((char) b);
    }
  }
  catch (NumberFormatException e)
  {
    rpm = 0;
  }
}
