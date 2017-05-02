;
;NAME: Sharon Umute
;Student Number: V00852291
;CSC 230 Assignment 3 A01 B04
;Extension: Pressing a button increase speed of sign
;

#define LCD_LIBONLY
.include "lcd.asm"



.cseg


start:
	ldi r16, 0x87
	sts ADCSRA, r16
	ldi r16, 0x40
	sts ADMUX, r16

	ldi r29, 0x1E
	
	call lcd_init		
	call init_strings
	call display_strings

lp2:jmp lp2


reverse_strings:
	msg3_p: .db "etumU norahS", 0	
	msg4_p: .db "icS retupmoC :CIVU", 0

	ret



check_button:
		; start a2d
		lds	r16, ADCSRA	
		ori r16, 0x40
		sts	ADCSRA, r16

		; wait for it to complete
wait:	lds r16, ADCSRA
		andi r16, 0x40
		brne wait

		; read the value
		lds r16, ADCL
		lds r17, ADCH

		clr r24
		cpi r17, 0
		brne skip		
		ldi r24,1
skip:	ret



init_strings:
	push r16
	; copy strings from program memory to data memory
	ldi r16, high(msg1)		; this the destination
	push r16
	ldi r16, low(msg1)
	push r16
	ldi r16, high(msg1_p << 1) ; this is the source
	push r16
	ldi r16, low(msg1_p << 1)
	push r16
	call str_init			; copy from program to data
	pop r16					; remove the parameters from the stack
	pop r16
	pop r16
	pop r16

	ldi r16, high(msg2)
	push r16
	ldi r16, low(msg2)
	push r16
	ldi r16, high(msg2_p << 1)
	push r16
	ldi r16, low(msg2_p << 1)
	push r16
	call str_init
	pop r16
	pop r16
	pop r16
	pop r16

	ldi r16, high(msgast)
	push r16
	ldi r16, low(msgast)
	push r16
	ldi r16, high(msgast_p << 1)
	push r16
	ldi r16, low(msgast_p << 1)
	push r16
	call str_init
	pop r16
	pop r16
	pop r16
	pop r16

	ldi r16, high(msgdot)
	push r16
	ldi r16, low(msgdot)
	push r16
	ldi r16, high(msgdot_p << 1)
	push r16
	ldi r16, low(msgdot_p << 1)
	push r16
	call str_init
	pop r16
	pop r16
	pop r16
	pop r16
	pop r16

	call reverse_strings

	ldi r16, high(msg3)		; this the destination
	push r16
	ldi r16, low(msg3)
	push r16
	ldi r16, high(msg3_p << 1) ; this is the source
	push r16
	ldi r16, low(msg3_p << 1)
	push r16
	call str_init			; copy from program to data
	pop r16					; remove the parameters from the stack
	pop r16
	pop r16
	pop r16

	ldi r16, high(msg4)		; this the destination
	push r16
	ldi r16, low(msg4)
	push r16
	ldi r16, high(msg4_p << 1) ; this is the source
	push r16
	ldi r16, low(msg4_p << 1)
	push r16
	call str_init			; copy from program to data
	pop r16					; remove the parameters from the stack
	pop r16
	pop r16
	pop r16

	ret


	

set_row_counter_0_coloumn_counter_0:
			call button_interupt
			ldi r16, 0x00
			push r16
			ldi r16, 0x00
			push r16
			call lcd_gotoxy
			pop r16
			pop r16
			call button_interupt
			ret

display_line_1:
			call button_interupt
			ldi r16, high(msg1)
			push r16
			ldi r16, low(msg1)
			push r16
			call lcd_puts
			pop r16
			pop r16
			call button_interupt
			ret

set_row_counter_1_coloumn_counter_0:
			call button_interupt
			ldi r16, 0x01
			push r16
			ldi r16, 0x00
			push r16
			call lcd_gotoxy
			pop r16
			pop r16
			call button_interupt
			ret

set_row_counter_1_coloumn_counter_1:
			call button_interupt
			ldi r16, 0x01
			push r16
			ldi r16, 0x01
			push r16
			call lcd_gotoxy
			pop r16
			pop r16
			call button_interupt
			ret

display_line_2:
			call button_interupt
			ldi r16, high(msg2)
			push r16
			ldi r16, low(msg2)
			push r16
			call lcd_puts
			pop r16
			pop r16
			call button_interupt
			ret

			
delay_1_second:
			push r26
			push r22
			push r23
			push r31
			
			call button_interupt
			mov r26, r29
			extra: 
				ldi r23, 0xFF ; r22 outer loop counter
			outer: 
				ldi r22, 0xFF ; r22 inner counter
			inner: 
				nop
				nop
				nop
				nop
				nop
				dec r22
				brne inner
				dec r23
				brne outer
				dec r26
				brne extra
			endLoop: 
				pop r31
				pop r23
				pop r22
				pop r26
				ret



set_row_counter_0_coloumn_counter_1:
			call button_interupt
			ldi r16, 0x00
			push r16
			ldi r16, 0x01
			push r16
			call lcd_gotoxy
			pop r16
			pop r16
			call button_interupt
			ret

display_line_3:
			call button_interupt
			ldi r16, high(msg3)
			push r16
			ldi r16, low(msg3)
			push r16
			call lcd_puts
			pop r16
			pop r16
			call button_interupt
			ret

display_line_4:
			call button_interupt
			ldi r16, high(msg4)
			push r16
			ldi r16, low(msg4)
			push r16
			call lcd_puts
			pop r16
			pop r16
			call button_interupt
			ret

display_all_ast:
				call button_interupt
				ldi r16, high(msgast)
				push r16
				ldi r16, low(msgast)
				push r16
				call lcd_puts
				pop r16
				pop r16
				call button_interupt
				ret

display_all_dot:
				call button_interupt
				ldi r16, high(msgdot)
				push r16
				ldi r16, low(msgdot)
				push r16
				call lcd_puts
				pop r16
				pop r16
				call button_interupt
				ret

do_many_times:
			call lcd_clr
			call set_row_counter_0_coloumn_counter_0
			call display_all_ast
			call set_row_counter_1_coloumn_counter_0
			call display_all_ast
			call delay_1_second
			call lcd_clr
			call set_row_counter_0_coloumn_counter_0
			call display_all_dot
			call set_row_counter_1_coloumn_counter_0
			call display_all_dot
			call delay_1_second

			dec r22
			cpi r22, 0x00
			brne again2
			ret

			again2:
				call button_interupt
				call do_many_times
				ret


button_interupt:
		;Extension: when button pressed. increase speed of sign by 2 until 0
		push r24
		push r19
		push r16
		push r17
		push r30
		push r31

		ldi r30, 2
		ldi r31, 0

		call check_button
		mul r24, r30
		cpi r29, 0x2
		brlt endr
		sub r29, r24
		endr:
		pop r31
		pop r30
		pop r17
		pop r16
		pop r19
		pop r24
		ret


display_strings:

	push r16

	call lcd_clr
	
	push r20
	push r22

	ldi r20, 0x3
	

	do_3_times:
		
		call button_interupt
		call set_row_counter_0_coloumn_counter_0
		call button_interupt
		call display_line_1
		call button_interupt
		call set_row_counter_1_coloumn_counter_0
		call button_interupt
		call display_line_2 
		call button_interupt
		call delay_1_second
		call button_interupt
		call lcd_clr
		call button_interupt
		call set_row_counter_0_coloumn_counter_1
		call button_interupt
		call display_line_2
		call button_interupt
		call set_row_counter_1_coloumn_counter_1
		call button_interupt
		call display_line_3
		call button_interupt
		call delay_1_second
		call button_interupt
		call lcd_clr
		call button_interupt
		call set_row_counter_0_coloumn_counter_0
		call button_interupt
		call display_line_3
		call button_interupt
		call set_row_counter_1_coloumn_counter_0
		call button_interupt
		call display_line_4
		call button_interupt
		call delay_1_second
		call button_interupt
		call lcd_clr
		call button_interupt
		call set_row_counter_0_coloumn_counter_1
		call button_interupt
		call display_line_4
		call button_interupt
		call set_row_counter_1_coloumn_counter_1
		call button_interupt
		call display_line_1
		call button_interupt
		call delay_1_second
		call button_interupt
		call delay_1_second
		call button_interupt
		call lcd_clr
		call button_interupt
		
		dec r20
		cpi r20, 0x00
		brne again
		

		ldi r22, 0x5
		call button_interupt
		call do_many_times
		call lcd_clr
		pop r22
		pop r20
		pop r16
		
		end:
			jmp end
		

		again:
			call button_interupt
			call do_3_times
			ret
		

		

		


msg1_p:	.db "Sharon Umute", 0	
msg2_p: .db "UVIC: Computer Sci", 0
msgast_p: .db "****************", 0
msgdot_p: .db "........................................", 0
	
.dseg
;
; The program copies the strings from program memory
; into data memory.  These are the strings
; that are actually displayed on the lcd
;
msg1:	.byte 200
msg2:	.byte 200
msg3:	.byte 200
msg4:	.byte 200
msgast:	.byte 200
msgdot:	.byte 200

