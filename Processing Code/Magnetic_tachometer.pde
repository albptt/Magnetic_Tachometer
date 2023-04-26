import processing.serial.*;
import meter.*;

Serial port;

Meter m1, m2;

float r = 0.04; //bike radius in m
int rpm = 0;
int kmh = 0;


void setup(){
  // Empty window
  size(950, 400);
  background(0);
  
  port = new Serial(this, "COM8", 9600);
  
  // METER FOR RPM
  m1 = new Meter(this, 25, 80); 
  
  // Meter name
  m1.setTitle("RPM");
  m1.setTitleFontSize(19);
  m1.setTitleFontName("Arial bold");
  
  // Meter scale
  String[] scaleLabels1 = {"0", "50", "100", "150", "200", "250", "300", "350", "400", "450", "500", "550", "600", "650", "700", "750", "800", "850", "900", "950", "1000"};
  m1.setScaleLabels(scaleLabels1);
  m1.setScaleFontSize(16);
  m1.setScaleFontName("Times New Roman bold");
  m1.setScaleFontColor(color(#FF0000));
  
  // Digital values
  m1.setDisplayDigitalMeterValue(true);
  
  // Some other characteristics
  m1.setArcColor(color(#00BFFF));
  m1.setArcThickness(10);
  m1.setMaxScaleValue(1000);
  m1.setNeedleThickness(3);
  m1.setMinInputSignal(0);
  m1.setMaxInputSignal(1000);  
  
  // References for the first meter
  int mx = m1.getMeterX();
  int my = m1.getMeterY();
  int mw = m1.getMeterWidth();
  
  // METER FOR KM/H
  m2 = new Meter(this, mx + mw + 20, my);
  
  // Meter name
  m2.setTitle("KM/H");
  m2.setTitleFontSize(19);
  m2.setTitleFontName("Arial bold");
  
  // Meter scale
  String[] scaleLabels2 = {"0", "5", "10", "15", "20", "25", "30"};
  m2.setScaleLabels(scaleLabels2);
  m2.setScaleFontSize(16);
  m2.setScaleFontName("Times New Roman bold");
  m2.setScaleFontColor(color(#FF0000));
  
  // Digital values
  m2.setDisplayDigitalMeterValue(true);
  
  // Some other characteristics
  m2.setArcColor(color(#00BFFF));
  m2.setArcThickness(10);
  m2.setMaxScaleValue(30);
  m2.setNeedleThickness(3);
  m2.setMinInputSignal(0);
  m2.setMaxInputSignal(30);  
}

void draw(){
  textSize(30);
  text("MAGNETIC TACHOMETER", 330, 50);
    
  m1.updateMeter(rpm);
  m2.updateMeter(kmh);
    
  
}

void serialEvent(Serial port) {
  String inputString = port.readStringUntil('\n');
  if (inputString != null) {
    try {
      rpm = Integer.parseInt(inputString.trim()); // convert to integer
      kmh = (int)(2 * PI * r * rpm * 3.6/60);
    } catch (NumberFormatException e) {
      rpm = 0;
      kmh = 0;
    }
  }
}
