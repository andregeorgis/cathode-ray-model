import controlP5.*;
import processing.serial.*;

ControlP5 cp5;

Serial mySerial;
//Values for position of images
float endXSide;
float endYSide;
float endXTop;
float endYTop;
float endXFront;
float endYFront;
float imgYTop;
float imgYBottom;
float imgXRight;
float imgXLeft;
float topCurrent;
float leftCurrent;
float bottomCurrent;
float rightCurrent;
float sideMagnetElectric;
float topMagnetElectric;
int control;
float current1;
float current2;
//Image values
PImage[] magnet = new PImage[4];
PImage[] coil = new PImage[11];
PImage[] electric = new PImage[12];
PImage background;
//For cp5 buttons
boolean magnetNButtonState = true;
boolean magnetSButtonState = false;
boolean electric1ButtonState = false;
boolean electric2ButtonState = false;
boolean electric3ButtonState = false;
boolean coilButtonState = false;
//For Serial communication
float[] variablesFloat;
String[] variablesString;
int stop = 10;
String myString = null;

void setup() {
  size(1440, 860);
  
  String myPort = Serial.list() [1];
  mySerial = new Serial(this, myPort, 9600);
  delay(2000);
  
  cp5 = new ControlP5(this);
  
  cp5.addButton("northPole").setPosition(1240, 0).setSize(90, 90).setCaptionLabel("North Pole");
  cp5.addButton("southPole").setPosition(1350, 0).setSize(90, 90).setCaptionLabel("South Pole");
  cp5.addButton("electric2").setPosition(1350, 100).setSize(90, 90).setCaptionLabel("Electric Distance 2");
  cp5.addButton("electric1").setPosition(1240, 100).setSize(90, 90).setCaptionLabel("Electric Distance 1");
  cp5.addButton("electric3").setPosition(1240, 200).setSize(90, 90).setCaptionLabel("Electric Voltage");
  cp5.addButton("coil").setPosition(1350, 200).setSize(90, 90).setCaptionLabel("Coils");
 
  for (int i = 0; i < magnet.length; i++) {
    magnet[i] = loadImage("magnet" + str(i + 1) + ".png");
  }
  for (int i = 0; i < coil.length; i++) {
    coil[i] = loadImage("coil" + str(i + 1) + ".png");
  }
  for (int i = 0; i < electric.length; i++) {
    electric[i] = loadImage("electric" + str(i + 1) + ".png");
  }
  background = loadImage("background.png");
  frameRate(300);
}

void draw() {
  //Serial Communication
  while (mySerial.available() > 0) {
    myString = mySerial.readStringUntil(stop);
    if (myString != null) {
      variablesString = new String[8];
      variablesString = myString.split(",");
      variablesFloat = new float[8];
      for (int i = 0; i < 4; i++) {
        if (variablesString[i] != "") {
          variablesFloat[i] = Integer.parseInt(trim(variablesString[i]));
          println(variablesFloat[i]);
          if (variablesFloat[i] > 10) {
            variablesFloat[i] = 10;
          }
          variablesFloat[i] = (10 - variablesFloat[i]) * 10;
        }
      }
      for (int i = 4; i <8; i++) {
        if (variablesString[i] != "") {
          variablesFloat[i] = Integer.parseInt(trim(variablesString[i]));
          variablesFloat[i] = (variablesFloat[i] - 512) / 128;
        }
      }
    imgXRight = variablesFloat[0];
    imgYTop = variablesFloat[1];
    imgYBottom = variablesFloat[2];
    imgXLeft = variablesFloat[3];
    rightCurrent = variablesFloat[4];
    topCurrent = variablesFloat[5];
    bottomCurrent = variablesFloat[6];
    leftCurrent = variablesFloat[7];
    }
  }
  
  //Displaying images depending on which button has been pressed 
  imageMode(CENTER);
  if (magnetNButtonState) {
    image(background, 720, 426);
    image(magnet[2], 1080, 730 - imgYBottom, 100, 200);
    image(magnet[0], 1080, 130 + imgYTop, 100, 200);
    image(magnet[3], 780 + imgXLeft, 430, 200, 100);
    image(magnet[1], 1380 - imgXRight, 430, 200, 100);
    control = 1;
    sideMagnetElectric = imgXLeft - imgXRight;
    topMagnetElectric = imgYBottom - imgYTop;
    crt1Animation();
  }
  if (magnetSButtonState) {
    image(background, 720, 426);
    image(magnet[0], 1080, 730 - imgYBottom, 100, 200);
    image(magnet[2], 1080, 130 + imgYTop, 100, 200);
    image(magnet[1], 780 + imgXLeft, 430, 200, 100);
    image(magnet[3], 1380 - imgXRight, 430, 200, 100);
    control = -1;
    sideMagnetElectric = imgXLeft - imgXRight;
    topMagnetElectric = imgYBottom - imgYTop;
    crt1Animation();
  }
  if (electric1ButtonState) {
    image(background, 720, 426);
    image(electric[6], 1080, 730 - imgYBottom, 300, 100);
    image(electric[0], 1080, 130 + imgYTop, 300, 100);
    image(electric[3], 780 + imgXLeft, 430, 100, 300);
    image(electric[5], 1380 -imgXRight, 430, 100, 300);
    control = 1;
    topMagnetElectric = -(imgXLeft + imgXRight)/2;
    sideMagnetElectric = -(imgYBottom + imgYTop)/2;
    crt1Animation();
  }
  if (electric2ButtonState) {
    image(background, 720, 426);
    image(electric[2], 1080, 730 - imgYBottom, 300, 100);
    image(electric[4], 1080, 130 + imgYTop, 300, 100);
    image(electric[7], 780 + imgXLeft, 430, 100, 300);
    image(electric[1], 1380 - imgXRight, 430, 100, 300);
    control = -1;
    topMagnetElectric = -(imgXLeft + imgXRight)/2;
    sideMagnetElectric = -(imgYBottom + imgYTop)/2;
    crt1Animation();
  }
  if (electric3ButtonState) {
    image(background, 720, 426);
    if (topCurrent == bottomCurrent) {
      image(electric[10], 1080, 680, 300, 100);
      image(electric[8], 1080, 180, 300, 100);
    }
    if (topCurrent > bottomCurrent) {
      image(electric[6], 1080, 680, 300, 100);
      image(electric[0], 1080, 180, 300, 100);
    }
    if (topCurrent < bottomCurrent) {
      image(electric[2], 1080, 680, 300, 100);
      image(electric[4], 1080, 180, 300, 100);
    }
    if (leftCurrent == rightCurrent) {
      image(electric[11], 830, 430, 100, 300);
      image(electric[9], 1330, 430, 100, 300);
    }
    if (leftCurrent > rightCurrent) {
      image(electric[3], 830, 430, 100, 300);
      image(electric[5], 1330, 430, 100, 300);
    }
    if (leftCurrent < rightCurrent) {
      image(electric[7], 830, 430, 100, 300);
      image(electric[1], 1330, 430, 100, 300);
    }
    current1 = leftCurrent - rightCurrent;
    current2 = bottomCurrent - topCurrent;
    control = 2;
    crt2Animation();
  }
  if (coilButtonState) {
    image(background, 720, 426);
    image(coil[0], 1080, 280, 200, 100);
    image(coil[1], 930, 420, 100, 200);
    if (topCurrent > 0) {
      tint(#D3D3D3, topCurrent * 255 / 4);
      image(coil[2], 1077, 260, 200, 100);
      image(coil[10], 1120, 260 + topCurrent * 25, 50, 50);
      noTint();
      imageMode(CORNER);
      image(coil[6], 1031, 270, 100, 1.3 * topCurrent * 25);
      imageMode(CENTER);
    }
    if (topCurrent < 0) {
      tint(#D3D3D3, abs(topCurrent) * 255 / 4);
      image(coil[3], 1077, 260, 200, 100);
      image(coil[10], 1030, 260 + topCurrent * 25, 50, 50);
      noTint();
      imageMode(CORNER);
      image(coil[7], 1031, 270, 100, 1.3 * topCurrent * 25);
      imageMode(CENTER);
    }
    if (leftCurrent > 0) {
      tint(#D3D3D3, leftCurrent * 255 / 4);
      image(coil[4], 910, 420, 100, 200);
      image(coil[10], 910 + leftCurrent * 25, 380, 50, 50);
      noTint();
      imageMode(CORNER);
      image(coil[8], 920, 370, 1.3 * leftCurrent * 25, 100);
      imageMode(CENTER);
    }
    if (leftCurrent < 0) {
      tint(#D3D3D3, abs(leftCurrent) * 255 / 4);
      image(coil[5], 910, 420, 100, 200);
      image(coil[10], 910 + leftCurrent * 25, 470, 50, 50);
      noTint();
      imageMode(CORNER);
      image(coil[9], 920, 370, 1.3 * leftCurrent * 25, 100);
      imageMode(CENTER);
    }
    current2 = leftCurrent;
    current1 = topCurrent;
    control = 1;
    crt2Animation();
  }
}

//cp5 buttons
public void northPole() {
  magnetNButtonState = true;
  magnetSButtonState = false;
  electric1ButtonState = false;
  electric2ButtonState = false;
  electric3ButtonState = false;
  coilButtonState = false;
}

public void southPole() {
  magnetNButtonState = false;
  magnetSButtonState = true;
  electric1ButtonState = false;
  electric2ButtonState = false;
  electric3ButtonState = false;
  coilButtonState = false;
}

public void electric1() {
  magnetNButtonState = false;
  magnetSButtonState = false;
  electric1ButtonState = true;
  electric2ButtonState = false;
  electric3ButtonState = false;
  coilButtonState = false;
}

public void electric2() {
  magnetNButtonState = false;
  magnetSButtonState = false;
  electric1ButtonState = false;
  electric2ButtonState = true;
  electric3ButtonState = false;
  coilButtonState = false;
}

public void electric3() {
  magnetNButtonState = false;
  magnetSButtonState = false;
  electric1ButtonState = false;
  electric2ButtonState = false;
  electric3ButtonState = true;
  coilButtonState = false;
}

public void coil() {
  magnetNButtonState = false;
  magnetSButtonState = false;
  electric1ButtonState = false;
  electric2ButtonState = false;
  coilButtonState = true;
}

//CRT animation using values regarding distance; ultrasonic sensor
void crt1Animation() {
  strokeWeight(10);
  stroke(0);
  noFill();
  point(1080 + control * (topMagnetElectric), 429 + control * (sideMagnetElectric));
  strokeWeight(5);
  for (int i = 1; i > - 2; i  = i - 2) {
    endXSide = 97.5 * cos(control * (sideMagnetElectric - control * i * 2) * 0.29 * PI / 100)  + 580;
    endYSide = 212.5 * sin(control * (sideMagnetElectric - control *  i * 2) * 0.29 * PI / 100) + 215;
    if (i == 1) {
      stroke(0, 0, 255);
    }
    if (i == -1) {
      stroke(255, 0, 0);
    }
    bezier(80, 215 - 4 * i, 315, 215 - 4 * i, 480, 215 - 4 * i, endXSide, endYSide);
  }
  for (int i = 1; i > -2; i = i - 1) {
    if (i == 1) {
      stroke(255, 0, 0);
    }
    if (i == 0) {
      stroke(0, 0, 255);
    }
    if (i == -1) {
      stroke(0, 255, 0);
    }
    endXTop = 212.5 * cos(0.5 * PI - control * (topMagnetElectric - control * i * 3) * 0.295 * PI / 100) + 360;
    endYTop = 97.5 * sin(0.5 * PI - control * (topMagnetElectric - control * i * 3) * 0.295 * PI / 100) + 730;
    bezier(360 - 6 * i, 510, 360 - 6 * i, 620, 360 - 6 * i, 720, endXTop, endYTop);
  }
}

//CRT animation using values regarding current/voltage; potentiometer
void crt2Animation() {
  stroke(0);
  noFill();
  strokeWeight(10);
  point(1080 - current1 * 25 / control, 429 + current2 * 25 / control);
  strokeWeight(5);
  for (int i = 1; i > - 2; i  = i - 2) {
    endXSide = 97.5 * cos((current2 - 0.04 * i * 2 * control) * 0.29 * PI / (4 * control))  + 580;
    endYSide = 212.5 * sin((current2 - 0.04 * i * 2 * control) * 0.29 * PI / (4 * control)) + 215;
    if (i == 1) {
      stroke(0, 0, 255);
    }
    if (i == -1) {
      stroke(255, 0, 0);
    }
    bezier(80, 215 - 4 * i, 315, 215 - 4 * i, 480, 215 - 4 * i, endXSide, endYSide);
  }
  for (int i = 1; i > -2; i = i - 1) {
    if (i == 1) {
      stroke(255, 0, 0);
    }
    if (i == 0) {
      stroke(0, 0, 255);
    }
    if (i == -1) {
      stroke(0, 255, 0);
    }
    endXTop = 212.5 * cos(0.5 * PI + (current1 + 0.04 * i * 3 * control) * 0.295 * PI / (4 * control)) + 360;
    endYTop = 97.5 * sin(0.5 * PI + (current1 + 0.04 * i * 3 * control) * 0.295 * PI / (4 * control)) + 730;
    bezier(360 - 6 * i, 510, 360 - 6 * i, 620, 360 - 6 * i, 720, endXTop, endYTop);
  }
}
