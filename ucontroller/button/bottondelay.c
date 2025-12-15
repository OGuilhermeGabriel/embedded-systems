#define F_CPU 16000000UL

#include <avr/io.h>
#include <util/delay.h>

int main(){

  DDRB |= (1<<5); //pb5 output
  DDRD &= ~(1<<2); //pd2 input
  PORTD |= (1<<2); //Habilitando pd2 pull up 

  while(1){
    if ( (PIND & (1 <<PIND2)) == (1 <<PIND2)){
      PORTB |= (1<<PINB5);
    }else{
      PORTB &= ~(1<<PINB5);
    }
    _delay_ms(300);
  }
  return 0;
}
