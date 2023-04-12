// Magnetic Tachometer:
// RPMs are derived from the time delay between subsequent pulses
// Parameters to be calibrated based on the application:
// - timeOut: longer waiting time suited to slower RPM measurements, 
//            shorter waiting time suited to higher RPM measurements.
// - numPeriods: higher number of periods over which to average provides
//               better estimates at higher RPMs at the cost of slower
//               refresh rates.

#define SENS_PIN 2
#define RPS_TO_RPM(RPS) (RPS*60)
#define SECOND_US 1000000

int RPM = 0;
float RPS = 0.0;
const int timeOut = 1000000; // max waiting time for a pulse
float Period = 0.0; // period between pulses
float timeFlag = 0.0; // time when pulses are detected
float timeCurrent = 0.0; // current micros
const int numPeriods = 2; // number of readings over which to average
int countPeriods = 0; // count of the number of readings
float sumPeriods = 0.0; // sum of the periods
float avgPeriod = 0.0; // average of the periods

void setup() {
  // Digital Pin 2 to read the output of the comparator 
  // (set threshold and magnet pole so that pin 2 reads: HIGH when magnet faces the sensor, LOW otherwise)
  pinMode(SENS_PIN,INPUT);
  // attach interrupt to detect pulses
  attachInterrupt(digitalPinToInterrupt(SENS_PIN), pulseEvent, RISING);
  // start serial transmission
  Serial.begin(9600);
  // add delay to avoid radom transmission
  delay(100);
}

void loop() {
  // compute time from last measurement
  timeCurrent = micros();
  // check timeout
  if(timeCurrent - timeFlag >= timeOut){
    // set RPM to zero
    RPM = 0;
  }
  // print to Serial Monitor
  Serial.print("\nRPM: ");
  Serial.print(RPM);
}

void pulseEvent(){
  // compute period between pulses
  Period = micros() - timeFlag;  
  // update time of measurement
  timeFlag = micros();
  // update sum of periods
  sumPeriods+=Period;
  // update number of periods
  countPeriods++;
  // check number of periods
  if(countPeriods >= numPeriods){
    // compute average
    avgPeriod = sumPeriods/numPeriods;
    // convert frequency to RPS
    RPS = SECOND_US/avgPeriod;
    // convert RPS to RPM
    RPM = RPS_TO_RPM(RPS);
    // reset variables
    countPeriods = 0;
    sumPeriods = 0.0;
  }
}
