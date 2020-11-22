import processing.serial.*;
Serial myPort;

int totalPins =12;
int pinValues[] = new int[totalPins];
int pinValuesPrev[] = new int[totalPins];
int margin = 50;

int num = 1;
float rspeed= 1.5;
int level = 1,need= level;
boolean gameBegin = false,win = false, lose = false, gameOver = false;
int count = 0;
Needle [] needles = new Needle[99];

import processing.sound.*;
SoundFile shoot;

void setup()
{
  size(500, 799);
  needles[0]=new Needle(num);
  shoot = new SoundFile (this, "shoot.wav");
  
  printArray(Serial.list());
  String portName = Serial.list()[3];
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n');
}
void draw()
{
  translate(width/2, height/2.5); //center
   for(int i = 0;i<pinValues.length;i++)
   if(pinValues[i]==9 && gameBegin == false)
  {
    gameBegin = true;
  }
  
  if(gameBegin == false)
  {
    showBegin();
    return;
  }
 if(win)
 {
   count+=1;
   if(count>10)
   {
   showWin(); gameOver=true;
   }
 }
 if (lose)
 {
   showLose();gameOver=true;
 }
  for(int i = 0;i<pinValues.length;i++)
 if(pinValues[i]==11)
{
  gameOver = false;
}
 if(gameOver)
 {
   return;
 }
 for(int i = 0;i<pinValues.length;i++)
{ if((pinValues[i]==7)&&(pinValuesPrev[i]==0))
{
  needles[num-1].speed = 30;
  num++;
  needles[num-1] = new Needle(num);
  shoot.play();
}  pinValuesPrev[i] = pinValues[i]; }
 
  background(255);
  needles[0].display();
  for (int i =1;i<num;i++)
  {
    needles[i].display();
  }
  
  if(num>1 && needles[num-2].spinning())
  {
    need = level-num+1;
    needles[num-1].display();
 
    for(int i=0; i<num-2;i++)
  {
    if(abs(needles[i].needle_angle-needles[num-2].needle_angle)<6)
    {
      needles[i].c=#FF0000;
      needles[num-2].c=#FF0000;
      lose = true;
    }
  }
  if (need == 0 && !lose)
  {
    win=true;
  }
  
  }
  
  noStroke();
  fill(0);
  ellipse(0,0,160,160);
  
  textAlign(CENTER);
  textSize(50);
  fill(255);
  text(need,0,23);
  fill(0);
  text("Level:"+level,-width/5,-height/4);

}

class Needle
{
  int num;
  float x,y;
  int w=2, l=120, r=20; //needles length, parameter
  int c = #000000;
  float speed,needle_angle=0;
  Needle(int num)
  {
    x = 0;
    y = 350;
    this.num = num;
    speed = 0;
  }
  void display()
  {
  if (!spinning())
  {
  noStroke();
  fill(c);
  rectMode(CENTER); 
  rect(x, y, w, l);
  ellipse(x, y+l/2, r,r);
  textAlign(CENTER);
  fill(255);
  textSize(15);
  text(num,x,y+l/2+5);
  y-=speed;
  }
  else
  {
  pushMatrix();
  
  rotate(radians(needle_angle));
  noStroke();
  fill(c);
  rectMode(CENTER); 
  rect(x, y, w, l);
  ellipse(x, y+l/2, r,r);
  textAlign(CENTER);
  fill(255);
  textSize(15);
  text(num,x,y+l/2+5); 
  popMatrix();
  needle_angle+=rspeed;
  needle_angle=needle_angle%360;
  }
  }
  boolean spinning()
  {
    if(y<=70+l/2)return true;//
    else return false;
  }
}
void showBegin()
{
  background(0);
  textAlign(CENTER);
  fill(255);
  textSize(35);
  text("Core Ball",0,-50);
  text("Level"+level,0,0);
  textSize(20);
  text("Press S to start" , 0,50);
}
void showWin()
{
   win=false;
  fill(0,0,255,80);
  rect(0,0,width,2*height);
  textAlign(CENTER);
  fill(255);
  textSize(31);
  text("You win!",0,0);
  level +=1;
  text("Press C to continue Level " + level, 0,50);
  num = 1;
  need = level;
  needles = new Needle[100];
  needles[0]=new Needle(num);
  count = 0;
}

void showLose()
{
  lose=false;
  fill(255,0,0,80);
  rect(0,0,width,2*height);
  textAlign(CENTER);
  fill(255,0,0);
  textSize(31);
  text("You lose",0,0);
  text("Press C to restart Level " + level, 0,50);
  num = 1;
  need = level;
  needles = new Needle[100];
  needles[0]=new Needle(num);
  count = 0;
}

 
void serialEvent(Serial myPort) {
 
  String myString = myPort.readStringUntil('\n');
  if (myString != null) {
    
  myString = trim(myString);
  pinValues = int(split(myString,','));
    
  }
  
  printArray(pinValues);
}
