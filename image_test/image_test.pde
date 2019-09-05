import processing.video.*;
import controlP5.*;
import processing.sound.*;

AudioIn input;

ControlP5 cp5;

Capture cam;

Amplitude analyzer;
//for cp5 buttons and ability to play/pause
boolean startCamAnimation = false;
boolean startImageAnimation = false;
boolean stationaryState = true;
boolean startColorAnimation = false;
boolean pauseState = false;
boolean bulbasaurState = true;
boolean charmanderState = false;
boolean squirtleState = false;
boolean pikachuState = false;
//The "pixel" number that is displayed on the front view
int pixelNum = 0;
//Image values
PImage bulbasaur;
PImage charmander;
PImage squirtle;
PImage pikachu;
PImage colorImg;
PImage background1;
PImage background2;
//Values for image positions and colour
float endXSide;
float endYSide;
float endXTop;
float endYTop;
color c;
float R;
float G;
float B;
int FRAMERATE = 100;



void setup () {
  bulbasaur = loadImage("bulbasaur.bmp");
  charmander = loadImage("charmander.bmp");
  squirtle = loadImage("squirtle.bmp");
  pikachu = loadImage("pikachu.bmp");
  background1 = loadImage("background1.png");
  background2 = loadImage("background2.png");
  colorImg = loadImage("colorImg.bmp");
  
  size(1440, 860);
  
  cam = new Capture(this, 1280, 720, 30);
  cam.start();
  
  cp5 = new ControlP5(this);
  
  input = new AudioIn(this, 0);
  input.start();
  analyzer = new Amplitude(this);
  analyzer.input(input);
  
  cp5.addButton("Camera").setPosition(1340, 70).setSize(90, 90);
  cp5.addButton("imagePlay").setPosition(1340, 170).setSize(90, 90).setCaptionLabel("Play/Pause TV");
  cp5.addSlider("FRAMERATE").setPosition(1250, 10).setSize(180, 50).setRange(1, 200);
  cp5.addButton("colorImg").setPosition(1340, 270).setSize(90, 90).setCaptionLabel("Colour Test");
  
  imageMode(CENTER);
  image(background1, 720, 426);
}

//cp5 buttons
public void Camera() {
  imageMode(CENTER);
  image(background1, 720, 426);
  cam.resize(1280, 720);
  cam.read();
  cam.resize(42, 42);
  startCamAnimation = true;
  startImageAnimation = false;
  stationaryState = false;
  startColorAnimation = false;
  pauseState = false;
  pixelNum = 0;
}

public void imagePlay() {
  if (startImageAnimation) {
    if (pauseState) {
      pauseState = false;
    }
    else {
      pauseState = true;
    }
  }
  else {
    imageMode(CENTER);
    image(background1, 720, 426);
    startImageAnimation = true;
    startCamAnimation = false;
    startColorAnimation = false;
    stationaryState = false;
    pauseState = false;
    pixelNum = 0;
  }
}

public void colorImg() {
  if (startColorAnimation) {
    if (pauseState) {
      pauseState = false;
    }
    else {
      pauseState = true;
    }
  }
  else {
    imageMode(CENTER);
    image(background1, 720, 426);
    startColorAnimation = true;
    startCamAnimation = false;
    startImageAnimation = false;
    stationaryState = false;
    pauseState = false;
    pixelNum = 0;
  }
}

void draw () {
  if (pauseState) {
    //If paused do nothing
  }
  else {
    frameRate(FRAMERATE);
    imageMode(CORNER);
    image(background2, 0, -2);
    //When program starts do nothing
    if (stationaryState) {
      imageMode(CENTER);
      image(background1, 720, 426);
    }
    //Images displayed depends on button pressed
    if (startImageAnimation) {
      if (bulbasaurState) {
        c = color(bulbasaur.get(pixelNum%42, pixelNum/42));
        R = red(bulbasaur.get(pixelNum%42, pixelNum/42));
        G = green(bulbasaur.get(pixelNum%42, pixelNum/42));
        B = blue(bulbasaur.get(pixelNum%42, pixelNum/42));
        CRT();
        
      }
      else if (charmanderState) {
        c = color(charmander.get(pixelNum%42, pixelNum/42));
        R = red(charmander.get(pixelNum%42, pixelNum/42));
        G = green(charmander.get(pixelNum%42, pixelNum/42));
        B = blue(charmander.get(pixelNum%42, pixelNum/42));
        CRT();
      }
      else if (squirtleState) {
        c = color(squirtle.get(pixelNum%42, pixelNum/42));
        R = red(squirtle.get(pixelNum%42, pixelNum/42));
        G = green(squirtle.get(pixelNum%42, pixelNum/42));
        B = blue(squirtle.get(pixelNum%42, pixelNum/42));
        CRT();
      }
      else if (pikachuState) {
        c = color(pikachu.get(pixelNum%42, pixelNum/42));
        R = red(pikachu.get(pixelNum%42, pixelNum/42));
        G = green(pikachu.get(pixelNum%42, pixelNum/42));
        B = blue(pikachu.get(pixelNum%42, pixelNum/42));
        CRT();
      }
      fill(c);
      rect(870 + 10 * (pixelNum%42), 220 + 10 * int(pixelNum/42), 10, 10);
      pixelNum += 1;
    }
    
    if (startCamAnimation) {
      cam.loadPixels();
      R = red(cam.get(pixelNum%42, pixelNum/42));
      G = green(cam.get(pixelNum%42, pixelNum/42));
      B = blue(cam.get(pixelNum%42, pixelNum/42));
      CRT();
      fill(color(cam.get(pixelNum%42, pixelNum/42)));
      cam.updatePixels();
      rect(870 + 10 * (pixelNum%42), 220 + 10 * int(pixelNum/42), 10, 10);
      pixelNum += 1;
    }
    
    if (startColorAnimation) {
      c = color(colorImg.get(pixelNum%42, pixelNum/42));
      R = red(colorImg.get(pixelNum%42, pixelNum/42));
      G = green(colorImg.get(pixelNum%42, pixelNum/42));
      B = blue(colorImg.get(pixelNum%42, pixelNum/42));
      CRT();
      fill(c);
      rect(870 + 10 * (pixelNum%42), 220 + 10 * int(pixelNum/42), 10, 10);
      pixelNum += 1;
    }
    
    if (pixelNum >= 1764) {
      if (startCamAnimation) {
        startCamAnimation = false;
        pixelNum = 0;
      }
      if (startImageAnimation) {
        imageMode(CENTER);
        image(background1, 720, 426);
        if (bulbasaurState) {
          bulbasaurState = false;
          charmanderState = true;
        }
        else if (charmanderState) {
          charmanderState = false;
          squirtleState = true;
        }
        else if (squirtleState) {
          squirtleState = false;
          pikachuState = true;
        }
        else if (pikachuState) {
          pikachuState = false;
          bulbasaurState = true;
        }
        pixelNum = 0;
      }
      if (startColorAnimation) {
        pixelNum = 0;
        startColorAnimation = false;
      }
    }
  }
}

//CRT animation for top and side view modelling intensity of CRT
void CRT() {
  noFill();
  strokeWeight(3);
  for (int i = 1; i > - 2; i  = i - 2) {
    endXSide = 97.5 * cos(((pixelNum/42 - 20.5) - 0.1 * i * 2) * 0.29 * PI / 20.5)  + 580;
    endYSide = 212.5 * sin(((pixelNum/42 - 20.5) - 0.1 * i * 2) * 0.29 * PI / 20.5) + 215;
    if (i == 1) {
      stroke(0, 0, 255, B);
    }
    if (i == -1) {
      stroke(0, 255, 0, G);
      bezier(80, 215 - 4 * i, 315, 215 - 4 * i, 480, 215 - 4 * i, endXSide, endYSide);
      stroke(255, 0, 0, R);
    }
    bezier(80, 215 - 4 * i, 315, 215 - 4 * i, 480, 215 - 4 * i, endXSide, endYSide);
  }
  for (int i = 1; i > -2; i = i - 1) {
    if (i == 1) {
      stroke(255, 0, 0, R);
    }
    if (i == 0) {
      stroke(0, 0, 255, B);
    }
    if (i == -1) {
      stroke(0, 255, 0, G);
    }
    endXTop = 212.5 * cos(0.5 * PI + ((20.5 - pixelNum%42) + 0.1 * i * 3) * 0.295 * PI / 20.5) + 360;
    endYTop = 97.5 * sin(0.5 * PI + ((20.5 - pixelNum%42) + 0.1 * i * 3) * 0.295 * PI / 20.5) + 730;
    bezier(360 - 6 * i, 510, 360 - 6 * i, 620, 360 - 6 * i, 720, endXTop, endYTop);
  }
  stroke(0);
  strokeWeight(1);
}
