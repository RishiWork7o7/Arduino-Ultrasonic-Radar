#include <Servo.h>

Servo radarServo;

const int servoPin = 6;
const int trigPin = 9;
const int echoPin = 10;

void setup() {
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);

  radarServo.attach(servoPin);

  Serial.begin(9600);
}

float getDistance() {

  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);

  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  long duration = pulseIn(echoPin, HIGH, 30000);

  if (duration == 0) {
    return 400;
  }

  float distance = duration / 58.0;

  return distance;
}

void loop() {

  for (int angle = 15; angle <= 165; angle++) {

    radarServo.write(angle);

    delay(30);

    float distance = getDistance();

    Serial.print(angle);
    Serial.print(",");
    Serial.println(distance);
  }

  for (int angle = 165; angle >= 15; angle--) {

  radarServo.write(angle);

  delay(30);

  float distance = getDistance();

  Serial.print(angle);
  Serial.print(",");
  Serial.println(distance);
  }

}

