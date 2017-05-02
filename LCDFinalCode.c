/*
 * Name: Sharon Umute
 * Student ID: V00852291
 * Title: display_ext.c 
 * Extension: Pressing the right button allows you to change either message oone or message two
 * Once selection is made, press left button to exit
 */

#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <stdbool.h>
#include "main.h"
#include "lcd_drv.h"
#include <avr/io.h>
#include <util/delay.h>

#define MAX_LENGTH 50


char msg_one[] = "Sharon Umute";
char msg_two[] = "UVIC Comp Sci";
char msg_ast[] = "****************";
char msg_dot[] = "................";
char blank[] = "                ";
char rev_one[80];
char rev_two[80];
char* strings[] = {msg_one, msg_two, msg_ast, msg_dot};


//Reverse the strings
char* reverse_strncpy(char *dst, const char* src, size_t dstsiz)
{
    if (dst != NULL && dstsiz > 0)
    {
        const size_t len = strlen(src);
        const size_t last = len - 1;
        size_t i = 0;

        if (dstsiz > len)
        {
            for (; i < len; i++)
            {
                dst[i] = src[last - i];
            }
        }
        dst[i] = '\0';
        return dst;
    }
    return NULL;
}


//initialize string reversal
void string_init(){
	reverse_strncpy(rev_one, strings[0], sizeof(rev_one));
	reverse_strncpy(rev_two, strings[1], sizeof(rev_two));	
}


//displays line 1
void display_line1(){
	lcd_puts(msg_one);
}


//displays line 2
void display_line2(){
	lcd_puts(msg_two);
}


//displays line 3
void display_line3(){
	lcd_puts(rev_one);
}


//displays line 4
void display_line4(){
	lcd_puts(rev_two);
}


//displays all asterisk
void display_all_ast(){
	lcd_xy(0,0);
	lcd_puts(msg_ast);
	lcd_xy(0,1);
	lcd_puts(msg_ast);
}


//displays all dots
void display_all_dot(){
	lcd_xy(0,0);
	lcd_puts(msg_dot);
	lcd_xy(0,1);
	lcd_puts(msg_dot);
}


//clear the screen
void lcd_clr(){
	lcd_xy(0,0);
	lcd_puts(blank);
	lcd_xy(0,1);
	lcd_puts(blank);
}


//get button pressed data
int button(){
	ADCSRA |= 0x40;
	while (ADCSRA & 0x40)
		;
	unsigned int val = ADCL;
	unsigned int val2 = ADCH;

	val += (val2 << 8);

    if (val < 50) //btnRIGHT
	  return(1);  
    else if (val < 195) //btnUP
	  return(2);
    else if (val < 380)  //btnDOWN
	  return(4);
    else if (val < 555)  //btnLEFT
	  return(8);
    else if (val < 790)
	  return(16);  //btnSELECT
	else{
		return 0;
	}
}


//delay
void delay_seconds(int seconds){
	_delay_ms(1000*seconds);
}


//Change messages
void switch_msg(int valu){
	bool exit=false;
	int option;
	int option2;
	int val;
	if (valu==1){
		lcd_clr();
		lcd_xy(0,0);
		lcd_puts("Press Left");
		lcd_xy(0,1);
		lcd_puts("To EXIT");
		delay_seconds(2);
		lcd_clr();
		lcd_xy(0,0);
		lcd_puts("> Msg One");
		lcd_xy(0,1);
		lcd_puts("  Msg Two");
		option=1;
		while(!exit){
			val =button(); 
			if (val==4){
				lcd_clr();
				lcd_xy(0,0);
				lcd_puts("  Msg One");
				lcd_xy(0,1);
				lcd_puts("> Msg Two");
				option=2;
				val=0;
			}else if(val==2){
				lcd_clr();
				lcd_xy(0,0);
				lcd_puts("> Msg One");
				lcd_xy(0,1);
				lcd_puts("  Msg Two");
				option=1;
				val=0;
			}else if (val==16){
				lcd_clr();
				lcd_xy(0,0);
				lcd_puts("> Hello");
				lcd_xy(0,1);
				lcd_puts("  Muppets");
				option2=1;
				while(!exit){
					val =button(); 
					if (val==4){
						lcd_clr();
						lcd_xy(0,0);
						lcd_puts("  Hello");
						lcd_xy(0,1);
						lcd_puts("> Muppets");
						option2=2;
						val=0;
					}else if(val==2){
						lcd_clr();
						lcd_xy(0,0);
						lcd_puts("> Hello");
						lcd_xy(0,1);
						lcd_puts("  Muppets");
						option2=1;
						val=0;
					}else if (val==16){
						delay_seconds(2);
						if(option==1){
							if(option2==1){
								strlcpy(msg_one, "Hello", sizeof(msg_one));
								reverse_strncpy(rev_one, strings[0], sizeof(rev_one));
							}else{
								strlcpy(msg_one, "Muppets", sizeof(msg_one));
								reverse_strncpy(rev_one, strings[0], sizeof(rev_one));
							}
							
							
							
						}else if(option==2){
							if(option2==1){
								strlcpy(msg_two, "Hello", sizeof(msg_two));
								reverse_strncpy(rev_two, strings[1], sizeof(rev_two));
							}else{
								strlcpy(msg_two, "Muppets", sizeof(msg_two));
								reverse_strncpy(rev_two, strings[1], sizeof(rev_two));
							}
						}
						val=0;
					}else if (val==8){
						exit=true;
						val=0;
					}
				}
				val=0;
			}else if (val==8){
				exit=true;
			}
		}
	}
}



int main( void )
{
	DDRL = 0xFF;
	DDRB = 0xFF;
	ADCSRA = 0x87;
	ADMUX = 0x40;

	lcd_init();
	lcd_clr();
	string_init();

	int i;
	int step=1;
	for (i=0; i<12; i++){

		switch_msg (button());

		//A switch statment was used to better get button data
		//this way it checks buttons after each step, rather than each iteration of the whole process
		switch(step){
			case 1:
				lcd_clr();
				lcd_xy(0,0);
				display_line1();
				lcd_xy(0,1);
				display_line2();
				delay_seconds(1);
				step=2;
			break;
			
			case 2:
				lcd_clr();
				lcd_xy(1,0);
				display_line2();
				lcd_xy(1,1);
				display_line3();
				delay_seconds(1);
				step=3;
			break;

			case 3:
				lcd_clr();
				lcd_xy(0,0);
				display_line3();
				lcd_xy(0,1);
				display_line4();
				delay_seconds(1);
				step=4;
			break;

			case 4:
				lcd_clr();
				lcd_xy(1,0);
				display_line4();
				lcd_xy(1,1);
				display_line1();
				delay_seconds(2);
				lcd_clr();
				step=1;
			break;
		}
	}


	for(;;){
		lcd_clr();
		display_all_ast();
		delay_seconds(1);
		lcd_clr();
		display_all_dot();
		delay_seconds(1);
	}
}
