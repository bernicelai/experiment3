//base on Kate Hartman and Nick Puckett's sendAllCapPins example

#include <Wire.h>
#include "Adafruit_MPR121.h"

 
#ifndef _BV
#define _BV(bit) (1 << (bit)) 
#endif


Adafruit_MPR121 cap = Adafruit_MPR121();


uint16_t currtouched = 0;
int tp = 12; 

 

void setup() 
{
  Serial.begin(9600);

  if (!cap.begin(0x5A)) {
  Serial.println("MPR121 not found, check wiring?");
  while (1);
  }
  
  Serial.println("MPR121 found!");
}

 
void loop() 
{
checkEachPin(tp);
Serial.println();
delay(100);
}

 

void checkEachPin(int totalPins) {
currtouched = cap.touched();


 
   if ((currtouched & _BV(2)))
    {
    Serial.print(2);
    }
    else
    {
    Serial.print(0);
    }
    Serial.print(",");


   if ((currtouched & _BV(4)))
    {
    Serial.print(4);
    }
    else
    {
    Serial.print(0);
    }
    Serial.print(",");


   if ((currtouched & _BV(7)))
    {
    Serial.print(7);
    }
    else
    {
    Serial.print(0);
    }
    Serial.print(",");


   if ((currtouched & _BV(9)))
    {
    Serial.print(9);
    }
    else
    {
    Serial.print(0);
    }
    Serial.print(",");


   if ((currtouched & _BV(11)))
    {
    Serial.print(11);
    }
    else
    {
    Serial.print(0);
    }


}
