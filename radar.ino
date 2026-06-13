#include <Servo.h>

Servo radarServo;

const int trigPin = 9;
const int echoPin = 10;

const int servoPin = 6;
const int buzzerPin = 7;

int angle = 0;
int direction = 1;


long getDistance() {

  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);

  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);

  digitalWrite(trigPin, LOW);


  long duration = pulseIn(echoPin, HIGH, 30000);


  if(duration == 0)
    return 999;


  return duration * 0.034 / 2;
}



void setup() {

  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);

  pinMode(buzzerPin, OUTPUT);


  radarServo.attach(servoPin);

  radarServo.write(angle);


  Serial.begin(9600);

}



void loop() {


  long distance = getDistance();



  // Send to Processing

  Serial.print(angle);
  Serial.print(",");
  Serial.println(distance);



  // OBJECT DETECTED

  if(distance <= 20){


    // stop servo

    radarServo.write(angle);



    // keep buzzing until object removed

    while(getDistance() <= 20){


      tone(buzzerPin,2000);


      Serial.print(angle);
      Serial.print(",");
      Serial.println(getDistance());


      delay(50);

    }


    // object removed

    noTone(buzzerPin);

  }




  // NORMAL SCANNING

  radarServo.write(angle);


  angle += direction;



  if(angle >= 180){

    angle = 180;
    direction = -1;

  }


  if(angle <= 0){

    angle = 0;
    direction = 1;

  }


  delay(20);

}