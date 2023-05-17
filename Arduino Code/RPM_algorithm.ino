// Magnetic Tachometer:
// RPMs are derived from the time delay between subsequent pulses

#define SENS_PIN 2
#define N 1 // moving window dimension

#include <SoftwareSerial.h>
#include <String.h>
SoftwareSerial bluetooth(0,1);

float timeOut = 0;
int RPM = 0;
float RPS = 0.0;
float Period[N]; // period between pulses
double timeFlag = 0.0; // time when pulses are detected
double timeNow = 0.0; 
double timeCurrent = 0.0; // current micros
double sumPeriods = 0.0; // sum of the periods
double avgPeriod = 0.0; // average of the periods
int firstPulse=0;
String data;

void setup() {
  // Digital Pin 2 to read the output of the comparator 
  // (set threshold and magnet pole so that pin 2 reads: HIGH when magnet faces the sensor, LOW otherwise)
  pinMode(SENS_PIN,INPUT);
  // attach interrupt to detect pulses
  attachInterrupt(digitalPinToInterrupt(SENS_PIN), pulseEvent, RISING);
  // initialize baud rate for transmission
  Serial.begin(9600);
  bluetooth.begin(9600);
  // add delay to avoid random transmission
  delay(100);
  // initialize window
  for(int i=0; i<N; i++)
    Period[i]=0;
}

void loop() {
  // compute time from last measurement
  timeCurrent = micros();
  // update timeOut from last measurement
  timeOut = (60.0 / (RPM+1))* 1.3 * 1000000;
  // check for timeOut
  if(timeCurrent - timeFlag > timeOut){
    RPM=0;
  }
  // send data via Bluetooth
  data = String(RPM) + "\n";
  bluetooth.print(data);
}

void pulseEvent(){
  // save current time
  timeNow = micros();
  // shift window
  for(int i=0; i < N-1; i++)
    Period[i]=Period[i+1];
  // compute period between pulses
  Period[N-1] = timeNow - timeFlag; 
  // update time of measurement
  timeFlag = timeNow;
  // update sum of periods
  for(int i=0; i < N; i++)
    sumPeriods+=Period[i];
  // compute average period between pulses
  avgPeriod = sumPeriods / N;
  // convert frequency to RPS
  RPS = 1000000 / avgPeriod;
  // convert RPS to RPM
  RPM = RPS * 60;
  // reset sumPeriods
  sumPeriods = 0.0;
}