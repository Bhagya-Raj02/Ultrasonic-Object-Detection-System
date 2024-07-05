//Ultrasonic Sensor Interfacing with 8051 
//Detects object proximity and activates a buzzer 
  
ORG 0x0000  //Start address 
  
//Define I/O port addresses 
TRIG_PIN EQU P3.5       //Trigger pin (output) 
ECHO_PIN EQU P3.2     //Echo pin (input) 
BUZZER_PIN EQU P1.0  //Buzzer pin (output) 
  
//Initialize Timer0 for delay 
MOV TMOD, #01H    //Timer0 in mode 1 (16-bit) 
SETB TRIG_PIN    //Set trigger pin high 
  
MAIN: 
    CALL SEND_PULSE    //Send ultrasonic pulse 
    CALL MEASURE_DISTANCE    //Calculate distance 
    CJNE R0, #20, NO_BUZZER    //If distance < 20 cm, activate buzzer 
    CLR BUZZER_PIN    //Otherwise, turn off buzzer 
    SJMP MAIN    //Repeat 
  
NO_BUZZER: 
    SETB BUZZER_PIN   //Activate buzzer 
    SJMP MAIN   //Repeat 
  
//Subroutine to send ultrasonic pulse 
SEND_PULSE: 
    MOV TH0, #0   //Clear Timer0 
    MOV TL0, #0 
    CLR TRIG_PIN   // Set trigger pin low 
    NOP   //Wait for 10us (approximate) 
    NOP 
    NOP 
    SETB TRIG_PIN   //Set trigger pin high 
    RET