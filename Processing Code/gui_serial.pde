import processing.serial.*;

Serial port;
PFont font;
String rpmString = "RPM: 0";
int rpm = 0;

void setup() {
  size(480,640);
  port = new Serial(this,Serial.list()[2],9600);
  font = createFont("Monospaced",100);
  //frameRate(120);
  port.bufferUntil('\n'); // set up to read full lines of data
}

void draw() {
  background(0);
  fill(255);
  textFont(font);
  textAlign(CENTER);
  text(rpmString,240,320);
}

void serialEvent(Serial port) {
  String inputString = port.readStringUntil('\n');
  if (inputString != null) {
    try {
      rpm = Integer.parseInt(inputString.trim()); // convert to integer
      rpmString = "RPM: " + rpm; // update string to display new RPM value
    } catch (NumberFormatException e) {
      rpmString = "RPM: 0";
      //println("Error parsing RPM value: " + e.getMessage()); // handle parsing errors
    }
  }
}
