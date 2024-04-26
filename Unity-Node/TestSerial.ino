#define SW 8 
#include <Keypad.h>
const byte n_rows = 4;
const byte n_cols = 4;

char keys [n_rows][n_cols] = {
  {'1','2','3','A'},
  {'4','5','6','B'},
  {'7','8','9','C'},
  {'*','0','#','D'}
  
};

byte colPins[n_rows] = {D3, D2, D1, D0};
byte rowPins[n_cols] = {D7, D6, D5, D4};

Keypad myKeypad = Keypad(makeKeymap(keys), rowPins, colPins, n_rows, n_cols);

int up = 0;
int right = 0;
int left = 0;

void setup() {
  Serial.begin(9600);

}

void loop() {
  char myKey = myKeypad.getKey();
  up = 0;
  right = 0;
  left = 0;

  switch(myKey){
    case '2':
      up = 1;
      break;
    case '4':
      left = 1;
      break;
    case '6':
      right = 1;
      break;
  }

  Serial.print(left);
  Serial.print(",");
  Serial.print(up);
  Serial.print(",");
  Serial.print(right);
  Serial.print(",");
  Serial.println(!digitalRead(SW));

}
