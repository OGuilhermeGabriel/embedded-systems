#define F_CPU 16000000UL

#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>

ISR (INT0_vect){
  PORTB ^= (1<<5);
}

int main(){
  cli();

  DDRB |= (1<<5); //pb5 output
  DDRD &= ~(1<<2); //pd2 input
  PORTD |= (1<<2); //Habilitando pd2 pull up 
 
  EICRA |= (1<<ISC00);
  EIMSK |= (1<<INT0);
  sei();

  while(1){;;}
  return 0;
}
