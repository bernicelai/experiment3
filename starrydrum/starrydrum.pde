import processing.serial.*;
Serial myPort;

int totalPins =12;
int pinValues[] = new int[totalPins];
int pinValuesPrev[] = new int[totalPins];
int margin = 50;


import processing.sound.*;
SoundFile beat1;
SoundFile beat2;
SoundFile beat3;
SoundFile beat4;
SoundFile beat5;
SoundFile beat6;

void setup(){
 size(900, 900); 
   background(0);
 beat1 = new SoundFile (this, "1.aiff");
 beat2 = new SoundFile (this, "2.wav");
 beat3 = new SoundFile (this, "3.wav"); 
 beat4 = new SoundFile (this, "4.wav");
 beat5 = new SoundFile (this, "5.wav");
 beat6 = new SoundFile (this, "6.wav");
   printArray(Serial.list());
  String portName = Serial.list()[3];
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n');
 
}

 
void draw(){
  
 for(int i = 0;i<pinValues.length;i++)
 if (pinValues[i]==11)
  { fill(0, 9);
  rect(0,0, width, height);
  fill(255);
  ellipse(random(width), random(height), 9,9);
  
   beat2.play(); }
 
  for(int i = 0;i<pinValues.length;i++)
 if (pinValues[i]==2)
  {
      fill(0, 9);
  rect(0,0, width, height);
  fill(255);
  ellipse(random(width), random(height), 4,4);
   beat1.play(); }
   
 for(int i = 0;i<pinValues.length;i++)
 if (pinValues[i]==4)
  {   fill(0, 9);
  rect(0,0, width, height);
  fill(255);
  ellipse(random(width), random(height), 11,11);
   beat4.play(); }
   
   for(int i = 0;i<pinValues.length;i++)
 if (pinValues[i]==7)
  { 
  fill(0, 9);
  rect(0,0, width, height);
  fill(#BDFFFD);
  ellipse(random(width), random(height), 49,49);
   beat5.play();
  }
  
 for(int i = 0;i<pinValues.length;i++)
 if (pinValues[i]==9)
  {
  fill(0, 9);
  rect(0,0, width, height);
  fill(255);
  ellipse(random(width), random(height), 29,29);
    beat6.play();
   
  }
 
}


void serialEvent(Serial myPort) {
 
  String myString = myPort.readStringUntil('\n');
  if (myString != null) {
    
  myString = trim(myString);
  pinValues = int(split(myString,','));
    
  }
  
  printArray(pinValues);
}
