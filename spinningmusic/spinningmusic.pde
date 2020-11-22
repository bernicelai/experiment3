//credit to thedotisblack creative coding

import processing.serial.*; 

import processing.sound.*; 
SoundFile music1;
SoundFile music2;
SoundFile music3;
SoundFile music4;
SoundFile music5;

Serial myPort;              

 
int totalPins =12;
int pinValues[] = new int[totalPins];
int pinValuesPrev[] = new int[totalPins];
int margin = 50;

float angle;


void setup() {
  size(960, 1080);;
  surface.setLocation(957, 0);
  rectMode(CENTER);
  stroke (0, 15, 30);
  strokeWeight(25);
  
 
  music1 = new SoundFile(this, "1l.wav");
  music2 = new SoundFile(this, "2ironq.wav");
  music3 = new SoundFile(this, "3i.wav");
  music4 = new SoundFile(this, "4iron.wav");
  music5 = new SoundFile(this, "5r.wav");

 
  
  printArray(Serial.list());

  String portName = Serial.list()[3];
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n');
}



void draw() 
{

  for(int i = 0;i<pinValues.length;i++)
  {
    
  if (pinValues[i]==11)
  {background(204);
  translate(width/2, height/2);
  for (int r=0; r<100; r++) {
    fill(255);
    scale(0.95);
    rotate (radians(angle));
    rect(0,0,600,600);}angle+=0.06;}
    
    
   if (pinValues[i]==9)
  {background(204);
  translate(width/2, height/2);
  for (int r=0; r<100; r++) {
    fill(r*10, 15, 30);
    scale(0.95);
    rotate (radians(angle));
    rect(0,0,600,600);}angle+=0.07;}
    
  if (pinValues[i]==7)
  {background(204);
  translate(width/2, height/2);
  for (int r=0; r<100; r++) {
    fill(r*10, 100, 200);
    scale(0.95);
    rotate (radians(angle));
    rect(0,0,600,600);}angle+=0.17;}
    
  if (pinValues[i]==4)
  {background(204);
  translate(width/2, height/2);
  for (int r=0; r<100; r++) {
    fill(r*10, 29, 99);
    scale(0.95);
    rotate (radians(angle));
    rect(0,0,600,600);}angle+=0.2;}
    
   if (pinValues[i]==2)
  {background(204);
  translate(width/2, height/2);
  for (int r=0; r<100; r++) {
    fill(r*10, 99, 99);
    scale(0.95);
    rotate (radians(angle));
    rect(0,0,600,600);}angle+=0.25;}
    


    //11
    if((pinValues[i]==11)&&(pinValuesPrev[i]==0))
   {music1.play();}
   
   if((pinValues[i]==0)&&(pinValuesPrev[i]==11))
   {music1.pause();}
   
   
    //9
    if((pinValues[i]==9)&&(pinValuesPrev[i]==0))
   {music2.play();}
   
   if((pinValues[i]==0)&&(pinValuesPrev[i]==9))
   {music2.pause();}
   
   
    //7
    if((pinValues[i]==7)&&(pinValuesPrev[i]==0))
   {music3.play();}
   
    if((pinValues[i]==0)&&(pinValuesPrev[i]==7))
   {music3.pause();}
   
   //4
  if((pinValues[i]==4)&&(pinValuesPrev[i]==0))
   {music4.play();}
   
  if((pinValues[i]==0)&&(pinValuesPrev[i]==4))
   {music4.pause();}
   
   
  //2
  if((pinValues[i]==2)&&(pinValuesPrev[i]==0))
   {music5.play();}
   
  if((pinValues[i]==0)&&(pinValuesPrev[i]==2))
   {music5.pause();}
   
   
 
 pinValuesPrev[i] = pinValues[i]; }}


 
void serialEvent(Serial myPort) {
 
  String myString = myPort.readStringUntil('\n');
  if (myString != null) {
    
  myString = trim(myString);
  pinValues = int(split(myString,','));
    
  }
  
  printArray(pinValues);
}
