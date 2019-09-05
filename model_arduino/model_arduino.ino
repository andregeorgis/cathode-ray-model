// defines pins numbers
const int trigPinRight = 3;
const int echoPinRight = 4;
const int trigPinTop = 7;
const int echoPinTop = 8;
const int trigPinBottom = 9;
const int echoPinBottom = 10;
const int trigPinLeft = 11;
const int echoPinLeft = 12;
const int inputPinRight = 5;
const int inputPinTop = 4;
const int inputPinBottom = 2;
const int inputPinLeft = 1;
// defines variables
long durationRight;
int distanceRight;
long durationTop;
int distanceTop;
long durationBottom;
int distanceBottom;
long durationLeft;
int distanceLeft;
int currentRight;
int currentTop;
int currentBottom;
int currentLeft;
//arrays for loops
int trigPin[4] = {trigPinRight, trigPinTop, trigPinBottom, trigPinLeft};
int echoPin[4] = {echoPinRight, echoPinTop, echoPinBottom, echoPinLeft};
int inputPin[4] = {inputPinRight, inputPinTop, inputPinBottom, inputPinLeft};
float duration[4] = {durationRight, durationTop, durationBottom, durationLeft};
int distance[4] = {distanceRight, distanceTop, distanceBottom, distanceLeft};
int current[4] = {currentRight, currentTop, currentBottom, currentLeft};

void setup() {
  pinMode(trigPinRight, OUTPUT);
  pinMode(echoPinRight, INPUT);
  pinMode(trigPinTop, OUTPUT);
  pinMode(echoPinTop, INPUT);
  pinMode(trigPinBottom, OUTPUT); 
  pinMode(echoPinBottom, INPUT); 
  pinMode(trigPinLeft, OUTPUT);
  pinMode(echoPinLeft, INPUT);
  pinMode(inputPinRight, INPUT);
  pinMode(inputPinTop, INPUT);
  pinMode(inputPinBottom, INPUT);
  pinMode(inputPinLeft, INPUT);
  Serial.begin(9600); // Starts the serial communication
}
void loop() {
  for (int i = 0; i < 4; i++) {
    digitalWrite(trigPin[i], LOW); // Clears the trigPin1
    delayMicroseconds(2);

    digitalWrite(trigPin[i], HIGH); // Sets the trigPin1 on HIGH state for 10 micro seconds
    delayMicroseconds(10);
    digitalWrite(trigPin[i], LOW);
    
    duration[i] = pulseIn(echoPin[i], HIGH);// Reads the echoPin1, returns the sound wave travel time in microseconds
        
    distance[i] = (duration[i])*0.034/2; // Calculating the distance in cm

    Serial.print(distance[i]);
    Serial.print(", ");
      
  }
//Potentiometer Values
  for (int i=0; i<4; i++) {
    current[i] = analogRead(inputPin[i]);
    if (i < 3) {
      Serial.print(current[i]);
      Serial.print(", ");
    }
    else {
      Serial.println(current[i]);
    }
  }
}
