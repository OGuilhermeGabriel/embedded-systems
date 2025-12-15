#define F_CPU 16000000UL // Defining clock

#include <avr/io.h> // Including library avr
#include <util/delay.h>
#include <avr/interrupt.h>

ISR (TIMER0_COMPA_vect){
  PORTB ^=(1<<5);
}

int main(){
  cli();
  DDRB |= (1 << 5); 
  PORTB &= ~(1<<5);

  TCCR0A = 0b00000010; //definindo o modo de operacao NORMAL
  TCCR0B = 0b00000011; //pre scale
  OCR0A = 249;

  TIMSK0 |= ( 1 << OCIE0A); //habilitando a interrupcao por estouro

  sei();
  while (1)
  {
    ;;
  }

  return 0;
}
