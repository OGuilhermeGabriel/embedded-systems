#define F_CPU 16000000L

#include <avr/io.h>
#include <avr/interrupt.h>

volatile uint16_t ovf_count = 0; //cont::ador de overflow
volatile uint8_t state = 0; //states para pb5 = high e pb5 = low  

ISR(TIMER0_OVF_vect) {
    ovf_count++;
    if(state == 0){
          //Led apagado: espera 2s
          if (ovf_count >= 122) {      // aproximadamente 2s = 122 overflows * (2⁸*1024/16000000)
            PORTB |= (1<<PB5);       // alterna LED
            state = 1;
            ovf_count = 0;           // zera contagem
          }
    }else{//Led aceso: espera 4s 
          if(ovf_count >= 244){  
            PORTB &= ~(1<<PB5);
            state = 0; 
            ovf_count = 0; 
          }
    }
}

//ovf 256/16MHZ= 16 micro seg

int main() {

    // PB5 como saída
    DDRB |= (1 << PB5);
    PORTB &= ~(1 << PB5);   //começa desligado
    state = 0; 
    ovf_count = 0; 

    TCCR0A = 0b00000000; 
    TCCR0B |= (1<<CS02)|(1<<CS00); //prescaler de 1024
    TCNT0 = 0; //zerando o contador 
    TIMSK0 |=  (1<<TOIE0); // habilitando a interrupção quando ocorre o estouro do contador
    sei();

    //ovf 256/16MHZ= 16 micro seg

    while (1) {;;}

    return 0;
}
