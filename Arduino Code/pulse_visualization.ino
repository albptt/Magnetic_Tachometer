// Pulse visualization:
// Digital pulses obtained as the output of the comparator are shown.
// Given the automatic scaling by Arduino's Serial Plotter, value_0 and value_5 are used to fix the zoom between LOW and HIGH values of pulses.

#define SENS_PIN 2

int sensorValue = 0;
const int value_5 = 5; // upper limit of the diagram
const int value_0 = 0; // lower limit of the diagram

void setup() {
  // Digital Pin 2 to read the output of the comparator 
  pinMode(SENS_PIN, INPUT);
  // start serial transmission
  Serial.begin(9600);
  // add delay to avoid radom transmission
  delay(100);
}

void loop() {
  // read the input pin
  sensorValue= digitalRead(SENS_PIN);
  // print the input value
  Serial.println(sensorValue);
  Serial.print(" ");
  // set lower boundary
  Serial.print(value_0);
  Serial.print(" ");
  // set upper boundary
  Serial.print(value_5);
  Serial.print(" ");
}