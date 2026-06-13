import processing.serial.*;


Serial myPort;


int angle = 0;
int distance = 0;


void setup(){

  size(1000,600);


  println(Serial.list());


  // CHANGE NUMBER IF NEEDED
  myPort = new Serial(this, Serial.list()[0],9600);


  myPort.bufferUntil('\n');

}



void draw(){


  background(0);


  translate(width/2,height-50);



  // Radar circles

  stroke(0,255,0);
  noFill();


  arc(0,0,800,800,PI,TWO_PI);
  arc(0,0,600,600,PI,TWO_PI);
  arc(0,0,400,400,PI,TWO_PI);
  arc(0,0,200,200,PI,TWO_PI);



  // Angle lines

  for(int i=0;i<=180;i+=30){

    float x = 400*cos(radians(i));
    float y = -400*sin(radians(i));


    line(0,0,x,y);

  }



  // Moving sweep

  stroke(0,255,0);
  strokeWeight(3);


  float sx = 400*cos(radians(angle));
  float sy = -400*sin(radians(angle));


  line(0,0,sx,sy);



  // Object detection


  if(distance < 100){


    float x = distance*4*cos(radians(angle));
    float y = -distance*4*sin(radians(angle));


    stroke(255,0,0);
    fill(255,0,0);


    ellipse(x,y,15,15);

  }



  resetMatrix();


  fill(0,255,0);

  textSize(22);


  text("ARDUINO ULTRASONIC RADAR",30,40);


  text("ANGLE : "+angle+"°",30,80);

  text("DISTANCE : "+distance+" cm",30,110);



}



void serialEvent(Serial myPort){


  String data = myPort.readStringUntil('\n');


  if(data != null){


    data = trim(data);


    String values[] = split(data,',');



    if(values.length==2){


      angle = int(values[0]);

      distance = int(values[1]);

    }

  }

}
