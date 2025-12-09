#define F_CPU 16000000UL

#include <avr/io.h>
#include <util/delay.h>

//function para inicializar os leds 
static void init_leds(void) {
    //banco de regs B PORTB: pinos digitais 8..12 (PB0..PB4) PB4 -> xmas star
    DDRB |= (1<<PB0) | (1<<PB1) | (1<<PB2) | (1<<PB3) | (1<<PB4);
    //banco de regs D PORTD: pinos digitais 0..4 (PD0..PD4) PD0 -> tronco da arvore
    DDRD |= (1<<PD0) | (1<<PD1) | (1<<PD2) | (1<<PD3) | (1<<PD4);
}

//function para ligar todos 
static void all_on(void) {
    PORTB |= (1<<PB0) | (1<<PB1) | (1<<PB2) | (1<<PB3) | (1<<PB4);
    PORTD |= (1<<PD0) | (1<<PD1) | (1<<PD2) | (1<<PD3) | (1<<PD4);
}

//function para desligar todos
static void all_off(void) {
    PORTB &= ~((1<<PB0) | (1<<PB1) | (1<<PB2) | (15<<PB3) | (1<<PB4));
    PORTD &= ~((1<<PD0) | (1<<PD1) | (1<<PD2) | (1<<PD3) | (1<<PD4));
}

static void efeito_subindo(void) {
    // acende em sequência alguns pinos REGs B: esquerda da árvore, REGs D: direita
    uint8_t patternB[] = {(1<<PB3), (1<<PB2), (1<<PB1), (1<<PB0)};
    uint8_t patternD[] = {(1<<PD1), (1<<PD2), (1<<PD3), (1<<PD4)};
    for (uint8_t i = 0; i < sizeof(patternB); i++) {
        all_off();
        // fazendo a estrela piscar (chamando a function)
        PORTD |= (1<<PD0);   //fazendo o tronco da árvore ligar  
        PORTB |= patternB[i];
        PORTD |= patternD[i];
        _delay_ms(150);
    }
}

int main(void) {
    init_leds();

    while (1) {
        all_on();
        _delay_ms(600);
        all_off();
        _delay_ms(300);
        efeito_subindo();
    }
}
