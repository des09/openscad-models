/*
*   One button cycles through 4 fan speeds.
*
*   Computer fans need a 25kHz PWM signal, so we use this PWNM lib:
*       https://forum.arduino.cc/index.php?topic=117425.0
*       https://code.google.com/archive/p/arduino-pwm-frequency-library/downloads
*
*
* Also reads voltage of main battery on a voltage divider.
* if voltage is below target min (ie. max DOD), cut off the fan, flash the alarm led
*
* DOD - volts for AGM batteries:
* 
* 100% 	12.80+
* 75%  	12.60
* 50% 	12.30
* 25% 	12.00
* 0% 	11.80
*/

#include <PWM.h>

int32_t fan_pwm_frequency = 25000;          // frequency (in Hz) for fan PWM
const long debounce = 300;          // the debounce time for the button. Its a heavy click, so longer than usual
const int steps = 5;                // the number of speed steps, one more than speed LED pin count


int fan_pwm_pin = 9;                // the pin that the fan_rpm_pin is attached to
int alarm_led_pin = 13;                   // the LED pin for debug, and low voltage warning
int button_pin = 8;                 // the input pin for fan speed button
int fan_led_pin[] = {2, 3, 4, 5}; // the array of output pins for leds. One for each fan speed > 0


void setup() {
  Serial.begin(57600);
  Serial.println("--- Start FannyBox ---\n");

  //Initialize hi speed timers (except for 0, to save time keeping functions)
  InitTimersSafe();
  
  pinMode(alarm_led_pin, OUTPUT);
  pinMode(button_pin, INPUT);

  setup_pwm(fan_pwm_pin, fan_pwm_frequency);
  setup_leds(fan_led_pin);
  
  Serial.println("-----------------------");
}

/*
* Sets the frequency for PWM,
* and flashes alarm pin if failed
*/
void setup_pwm(int pwm_pin, int32_t frequency) {
  
  bool success = SetPinFrequencySafe(pwm_pin, frequency);

  if (success) {
    Serial.print("PWM on pin ");
    Serial.print(pwm_pin);
    Serial.print(" initialized at ");
    Serial.print(frequency);
    Serial.println(" Hz.");
    
  } else {
    for (int i = 0; i <= 255; i++) {
      digitalWrite(alarm_led_pin, HIGH);
      delay(500);
      digitalWrite(alarm_led_pin, LOW);
      delay(500);
    }
  }
}
  
  
  
/*
*   Set pin mode, and cycle each LED
*/
void setup_leds(int fan_led_pin[]) {
  
  for (int i = 0 ; i < steps - 1; i++) {
    pinMode(fan_led_pin[i], OUTPUT);
  }

  for (int i = 0 ; i < steps - 1; i++) {
    digitalWrite(fan_led_pin[i], HIGH);
    Serial.print("on ");
    Serial.println(i);
    delay(100);
  }
  
  for (int i = 0 ; i < steps - 1 ; i++) {
    digitalWrite(fan_led_pin[i], LOW);
    Serial.print("off ");
    Serial.println(i);
    delay(100);
  }
}

void loop() {
  static int previous = 0;
  int val = read_buttons();

  if (val != previous) {
    setFanSpeed(val);
    previous = val;
  }
}

/*
*   Set new fan speed, 
*   and set the fan speed LEDs
*/
void setFanSpeed(int val) {
  Serial.print("val change to ");
  Serial.print(val);
  
  int fan_speed = val * 255 / (steps - 1);
  Serial.print(", fan speed set to ");
  Serial.println(fan_speed);
  pwmWrite(fan_pwm_pin, fan_speed);

  for (int i = 0 ; i < steps - 1; i++) {
    if (val > i) {
      digitalWrite(fan_led_pin[i], HIGH );
    } else {
      digitalWrite(fan_led_pin[i], LOW );
    }
  } 
}

/*
* Reads and debounces the button.
* Keeps track of, and return an integer
* that is incremented or reset on each button press.
*/
int read_buttons() {
  static int val = 0;
  static long time = 0;

  bool reading = digitalRead(button_pin) == HIGH;

  // if the input just went from LOW to HIGH and we've waited long enough
  // to ignore any noise on the circuit, increment our counter, or reset it.
  // and remember the time

  if (reading && millis() - time > debounce) {
    val = ((val + 1) % steps );
    time = millis();
  }

  return val;
}
