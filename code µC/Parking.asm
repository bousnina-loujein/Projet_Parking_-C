
_main:

;Parking.c,31 :: 		void main() {
;Parking.c,32 :: 		TRISB=0xFF;//Input
	MOVLW      255
	MOVWF      TRISB+0
;Parking.c,33 :: 		TRISC=0x00;//Output
	CLRF       TRISC+0
;Parking.c,34 :: 		PORTC=0x00;//Initialisé à 0
	CLRF       PORTC+0
;Parking.c,36 :: 		Lcd_Init(); // Initialize LCD
	CALL       _Lcd_Init+0
;Parking.c,37 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Parking.c,38 :: 		PORTC.RC1=1;
	BSF        PORTC+0, 1
;Parking.c,39 :: 		Delay_us(250);
	MOVLW      166
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	NOP
;Parking.c,40 :: 		PORTC.RC1=0;
	BCF        PORTC+0, 1
;Parking.c,41 :: 		Delay_ms(20);
	MOVLW      52
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_main1:
	DECFSZ     R13+0, 1
	GOTO       L_main1
	DECFSZ     R12+0, 1
	GOTO       L_main1
	NOP
	NOP
;Parking.c,42 :: 		PORTC.RC2=1;
	BSF        PORTC+0, 2
;Parking.c,43 :: 		Delay_us(250);
	MOVLW      166
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	NOP
;Parking.c,44 :: 		PORTC.RC2=0;
	BCF        PORTC+0, 2
;Parking.c,45 :: 		Delay_ms(20);
	MOVLW      52
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	NOP
	NOP
;Parking.c,46 :: 		if(EEPROM_Read(0x02)!=0){
	MOVLW      2
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_main4
;Parking.c,47 :: 		EEPROM_Write(0x02,0);
	MOVLW      2
	MOVWF      FARG_EEPROM_Write_Address+0
	CLRF       FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Parking.c,48 :: 		EEPROM_Write(0x03,9);
	MOVLW      3
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      9
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Parking.c,49 :: 		}
L_main4:
;Parking.c,50 :: 		OPTION_REG.T0CS=0;
	BCF        OPTION_REG+0, 5
;Parking.c,51 :: 		OPTION_REG.PSA=0;
	BCF        OPTION_REG+0, 3
;Parking.c,52 :: 		OPTION_REG.PS2=1;
	BSF        OPTION_REG+0, 2
;Parking.c,53 :: 		OPTION_REG.PS1=1;
	BSF        OPTION_REG+0, 1
;Parking.c,54 :: 		OPTION_REG.PS0=1;
	BSF        OPTION_REG+0, 0
;Parking.c,55 :: 		INTCON.GIE=1;
	BSF        INTCON+0, 7
;Parking.c,56 :: 		INTCON.T0IF=0;
	BCF        INTCON+0, 2
;Parking.c,57 :: 		INTCON.T0IE=1;
	BSF        INTCON+0, 5
;Parking.c,58 :: 		pl=EEPROM_Read(0x03);
	MOVLW      3
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _pl+0
	CLRF       _pl+1
;Parking.c,59 :: 		Aff_Prin();
	CALL       _Aff_Prin+0
;Parking.c,60 :: 		while(1){
L_main5:
;Parking.c,61 :: 		if(temperature()!=temperature())
	CALL       _temperature+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+0
	MOVF       R0+1, 0
	MOVWF      FLOC__main+1
	MOVF       R0+2, 0
	MOVWF      FLOC__main+2
	MOVF       R0+3, 0
	MOVWF      FLOC__main+3
	CALL       _temperature+0
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	MOVF       FLOC__main+0, 0
	MOVWF      R0+0
	MOVF       FLOC__main+1, 0
	MOVWF      R0+1
	MOVF       FLOC__main+2, 0
	MOVWF      R0+2
	MOVF       FLOC__main+3, 0
	MOVWF      R0+3
	CALL       _Equals_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 2
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main7
;Parking.c,62 :: 		Aff_Prin();
	CALL       _Aff_Prin+0
L_main7:
;Parking.c,63 :: 		if(PORTB.RB1){  //Capt1=1
	BTFSS      PORTB+0, 1
	GOTO       L_main8
;Parking.c,64 :: 		if(pl>0){
	MOVF       _pl+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main37
	MOVF       _pl+0, 0
	SUBLW      0
L__main37:
	BTFSC      STATUS+0, 0
	GOTO       L_main9
;Parking.c,65 :: 		strcpy(msg,"Bienvenue");
	MOVLW      _msg+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr1_Parking+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Parking.c,66 :: 		Aff_Prin();
	CALL       _Aff_Prin+0
;Parking.c,67 :: 		PORTC.RC1=1;
	BSF        PORTC+0, 1
;Parking.c,68 :: 		Delay_us(5500);  ///// 5500///////////////////////////////////////////
	MOVLW      15
	MOVWF      R12+0
	MOVLW      71
	MOVWF      R13+0
L_main10:
	DECFSZ     R13+0, 1
	GOTO       L_main10
	DECFSZ     R12+0, 1
	GOTO       L_main10
	NOP
	NOP
;Parking.c,69 :: 		PORTC.RC1=0;
	BCF        PORTC+0, 1
;Parking.c,70 :: 		Delay_ms(20);   //Ouvrir le barriere 1
	MOVLW      52
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_main11:
	DECFSZ     R13+0, 1
	GOTO       L_main11
	DECFSZ     R12+0, 1
	GOTO       L_main11
	NOP
	NOP
;Parking.c,72 :: 		while(PORTB.RB2==0);//Attend Capt2=1
L_main12:
	BTFSC      PORTB+0, 2
	GOTO       L_main13
	GOTO       L_main12
L_main13:
;Parking.c,73 :: 		if(PORTB.RB2){ //Capt2=1
	BTFSS      PORTB+0, 2
	GOTO       L_main14
;Parking.c,74 :: 		pl--;
	MOVLW      1
	SUBWF      _pl+0, 1
	BTFSS      STATUS+0, 0
	DECF       _pl+1, 1
;Parking.c,75 :: 		EEPROM_Write(0x03,pl);
	MOVLW      3
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _pl+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Parking.c,76 :: 		PORTC.RC7=1;
	BSF        PORTC+0, 7
;Parking.c,77 :: 		PORTC.RC6=0;
	BCF        PORTC+0, 6
;Parking.c,78 :: 		PORTC.RC1=1;
	BSF        PORTC+0, 1
;Parking.c,79 :: 		Delay_us(250);
	MOVLW      166
	MOVWF      R13+0
L_main15:
	DECFSZ     R13+0, 1
	GOTO       L_main15
	NOP
;Parking.c,80 :: 		PORTC.RC1=0;
	BCF        PORTC+0, 1
;Parking.c,81 :: 		Delay_ms(20);
	MOVLW      52
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_main16:
	DECFSZ     R13+0, 1
	GOTO       L_main16
	DECFSZ     R12+0, 1
	GOTO       L_main16
	NOP
	NOP
;Parking.c,82 :: 		Aff_Prin();
	CALL       _Aff_Prin+0
;Parking.c,83 :: 		}
L_main14:
;Parking.c,84 :: 		}
L_main9:
;Parking.c,85 :: 		}
L_main8:
;Parking.c,87 :: 		if(PORTB.RB3 && PORTB.RB6){  //Capt3=1 et bp=1
	BTFSS      PORTB+0, 3
	GOTO       L_main19
	BTFSS      PORTB+0, 6
	GOTO       L_main19
L__main35:
;Parking.c,88 :: 		PORTC.RC2=1;
	BSF        PORTC+0, 2
;Parking.c,89 :: 		Delay_us(5500);  ////// 6000    ////////////////////////////////
	MOVLW      15
	MOVWF      R12+0
	MOVLW      71
	MOVWF      R13+0
L_main20:
	DECFSZ     R13+0, 1
	GOTO       L_main20
	DECFSZ     R12+0, 1
	GOTO       L_main20
	NOP
	NOP
;Parking.c,90 :: 		PORTC.RC2=0;
	BCF        PORTC+0, 2
;Parking.c,91 :: 		Delay_ms(20);   //Ouvrir le barriere 2
	MOVLW      52
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_main21:
	DECFSZ     R13+0, 1
	GOTO       L_main21
	DECFSZ     R12+0, 1
	GOTO       L_main21
	NOP
	NOP
;Parking.c,92 :: 		cmp=0;
	CLRF       _cmp+0
	CLRF       _cmp+1
;Parking.c,93 :: 		TMR0=0;
	CLRF       TMR0+0
;Parking.c,94 :: 		while(PORTB.RB4==0){//Attend Capt4=1
L_main22:
	BTFSC      PORTB+0, 4
	GOTO       L_main23
;Parking.c,95 :: 		if(cmp>152)    //////////152    10s
	MOVF       _cmp+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main38
	MOVF       _cmp+0, 0
	SUBLW      152
L__main38:
	BTFSC      STATUS+0, 0
	GOTO       L_main24
;Parking.c,96 :: 		PORTC.RC4=1;
	BSF        PORTC+0, 4
L_main24:
;Parking.c,97 :: 		}
	GOTO       L_main22
L_main23:
;Parking.c,98 :: 		PORTC.RC4=0;
	BCF        PORTC+0, 4
;Parking.c,99 :: 		if(PORTB.RB4){
	BTFSS      PORTB+0, 4
	GOTO       L_main25
;Parking.c,100 :: 		pl++;
	INCF       _pl+0, 1
	BTFSC      STATUS+0, 2
	INCF       _pl+1, 1
;Parking.c,101 :: 		if(pl>9)
	MOVF       _pl+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main39
	MOVF       _pl+0, 0
	SUBLW      9
L__main39:
	BTFSC      STATUS+0, 0
	GOTO       L_main26
;Parking.c,102 :: 		pl=9;
	MOVLW      9
	MOVWF      _pl+0
	MOVLW      0
	MOVWF      _pl+1
L_main26:
;Parking.c,103 :: 		EEPROM_Write(0x03,pl);
	MOVLW      3
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _pl+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Parking.c,104 :: 		strcpy(msg,"Aurevoir");
	MOVLW      _msg+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr2_Parking+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Parking.c,105 :: 		Aff_Prin();
	CALL       _Aff_Prin+0
;Parking.c,106 :: 		PORTC.RC7=0;
	BCF        PORTC+0, 7
;Parking.c,107 :: 		PORTC.RC6=1;
	BSF        PORTC+0, 6
;Parking.c,108 :: 		PORTC.RC2=1;
	BSF        PORTC+0, 2
;Parking.c,109 :: 		Delay_us(250);
	MOVLW      166
	MOVWF      R13+0
L_main27:
	DECFSZ     R13+0, 1
	GOTO       L_main27
	NOP
;Parking.c,110 :: 		PORTC.RC2=0;
	BCF        PORTC+0, 2
;Parking.c,111 :: 		Delay_ms(20);
	MOVLW      52
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_main28:
	DECFSZ     R13+0, 1
	GOTO       L_main28
	DECFSZ     R12+0, 1
	GOTO       L_main28
	NOP
	NOP
;Parking.c,112 :: 		}
L_main25:
;Parking.c,113 :: 		}
L_main19:
;Parking.c,115 :: 		}
	GOTO       L_main5
;Parking.c,116 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_temperature:

;Parking.c,118 :: 		float temperature(){
;Parking.c,119 :: 		if(PORTB.RB0==0){
	BTFSC      PORTB+0, 0
	GOTO       L_temperature29
;Parking.c,121 :: 		ADCON0=0x69;
	MOVLW      105
	MOVWF      ADCON0+0
;Parking.c,122 :: 		ADCON1=0x80;
	MOVLW      128
	MOVWF      ADCON1+0
;Parking.c,123 :: 		ADCON0.go=1;
	BSF        ADCON0+0, 2
;Parking.c,124 :: 		while(ADCON0.go); // Attendre que la conversion soit terminée
L_temperature30:
	BTFSS      ADCON0+0, 2
	GOTO       L_temperature31
	GOTO       L_temperature30
L_temperature31:
;Parking.c,125 :: 		a=((ADRESH << 8) + ADRESL);
	MOVF       ADRESH+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       ADRESL+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _a+0
	MOVF       R0+1, 0
	MOVWF      _a+1
;Parking.c,126 :: 		ac=a;
	CALL       _word2double+0
	MOVF       R0+0, 0
	MOVWF      _ac+0
	MOVF       R0+1, 0
	MOVWF      _ac+1
	MOVF       R0+2, 0
	MOVWF      _ac+2
	MOVF       R0+3, 0
	MOVWF      _ac+3
;Parking.c,127 :: 		ac=ac*80/1023;
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      133
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      192
	MOVWF      R4+1
	MOVLW      127
	MOVWF      R4+2
	MOVLW      136
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _ac+0
	MOVF       R0+1, 0
	MOVWF      _ac+1
	MOVF       R0+2, 0
	MOVWF      _ac+2
	MOVF       R0+3, 0
	MOVWF      _ac+3
;Parking.c,128 :: 		i=0;
	CLRF       _i+0
	CLRF       _i+1
;Parking.c,129 :: 		}
	GOTO       L_temperature32
L_temperature29:
;Parking.c,132 :: 		ADCON0=0x71;
	MOVLW      113
	MOVWF      ADCON0+0
;Parking.c,133 :: 		ADCON1=0x80;
	MOVLW      128
	MOVWF      ADCON1+0
;Parking.c,134 :: 		ADCON0.go=1;
	BSF        ADCON0+0, 2
;Parking.c,135 :: 		a=((ADRESH << 8) + ADRESL);
	MOVF       ADRESH+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       ADRESL+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _a+0
	MOVF       R0+1, 0
	MOVWF      _a+1
;Parking.c,136 :: 		ac=a;          //Conv int to float
	CALL       _word2double+0
	MOVF       R0+0, 0
	MOVWF      _ac+0
	MOVF       R0+1, 0
	MOVWF      _ac+1
	MOVF       R0+2, 0
	MOVWF      _ac+2
	MOVF       R0+3, 0
	MOVWF      _ac+3
;Parking.c,137 :: 		ac=ac*32/1023;
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      0
	MOVWF      R4+2
	MOVLW      132
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      192
	MOVWF      R4+1
	MOVLW      127
	MOVWF      R4+2
	MOVLW      136
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _ac+0
	MOVF       R0+1, 0
	MOVWF      _ac+1
	MOVF       R0+2, 0
	MOVWF      _ac+2
	MOVF       R0+3, 0
	MOVWF      _ac+3
;Parking.c,138 :: 		i=1;
	MOVLW      1
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
;Parking.c,139 :: 		}
L_temperature32:
;Parking.c,140 :: 		return ac;
	MOVF       _ac+0, 0
	MOVWF      R0+0
	MOVF       _ac+1, 0
	MOVWF      R0+1
	MOVF       _ac+2, 0
	MOVWF      R0+2
	MOVF       _ac+3, 0
	MOVWF      R0+3
;Parking.c,141 :: 		}
L_end_temperature:
	RETURN
; end of _temperature

_Aff_Prin:

;Parking.c,142 :: 		void Aff_Prin(){
;Parking.c,143 :: 		ac=temperature();
	CALL       _temperature+0
	MOVF       R0+0, 0
	MOVWF      _ac+0
	MOVF       R0+1, 0
	MOVWF      _ac+1
	MOVF       R0+2, 0
	MOVWF      _ac+2
	MOVF       R0+3, 0
	MOVWF      _ac+3
;Parking.c,144 :: 		ac=ac*100;
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      72
	MOVWF      R4+2
	MOVLW      133
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _ac+0
	MOVF       R0+1, 0
	MOVWF      _ac+1
	MOVF       R0+2, 0
	MOVWF      _ac+2
	MOVF       R0+3, 0
	MOVWF      _ac+3
;Parking.c,145 :: 		ap=ac;   //Conv float to int
	CALL       _double2word+0
	MOVF       R0+0, 0
	MOVWF      FLOC__Aff_Prin+6
	MOVF       R0+1, 0
	MOVWF      FLOC__Aff_Prin+7
	MOVF       FLOC__Aff_Prin+6, 0
	MOVWF      _ap+0
	MOVF       FLOC__Aff_Prin+7, 0
	MOVWF      _ap+1
;Parking.c,146 :: 		a1=ap/1000;
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	MOVF       FLOC__Aff_Prin+6, 0
	MOVWF      R0+0
	MOVF       FLOC__Aff_Prin+7, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      FLOC__Aff_Prin+4
	MOVF       R0+1, 0
	MOVWF      FLOC__Aff_Prin+5
	MOVF       FLOC__Aff_Prin+4, 0
	MOVWF      _a1+0
	MOVF       FLOC__Aff_Prin+5, 0
	MOVWF      _a1+1
;Parking.c,147 :: 		a2=(ap/100)%10;
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FLOC__Aff_Prin+6, 0
	MOVWF      R0+0
	MOVF       FLOC__Aff_Prin+7, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FLOC__Aff_Prin+2
	MOVF       R0+1, 0
	MOVWF      FLOC__Aff_Prin+3
	MOVF       FLOC__Aff_Prin+2, 0
	MOVWF      _a2+0
	MOVF       FLOC__Aff_Prin+3, 0
	MOVWF      _a2+1
;Parking.c,148 :: 		a3=(ap/10)%10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FLOC__Aff_Prin+6, 0
	MOVWF      R0+0
	MOVF       FLOC__Aff_Prin+7, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FLOC__Aff_Prin+0
	MOVF       R0+1, 0
	MOVWF      FLOC__Aff_Prin+1
	MOVF       FLOC__Aff_Prin+0, 0
	MOVWF      _a3+0
	MOVF       FLOC__Aff_Prin+1, 0
	MOVWF      _a3+1
;Parking.c,149 :: 		a4=ap%10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FLOC__Aff_Prin+6, 0
	MOVWF      R0+0
	MOVF       FLOC__Aff_Prin+7, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _a4+0
	MOVF       R0+1, 0
	MOVWF      _a4+1
;Parking.c,150 :: 		X[0]=a1+48;  // Conv int to char
	MOVLW      48
	ADDWF      FLOC__Aff_Prin+4, 0
	MOVWF      _X+0
;Parking.c,151 :: 		X[1]=a2+48;
	MOVLW      48
	ADDWF      FLOC__Aff_Prin+2, 0
	MOVWF      _X+1
;Parking.c,152 :: 		X[2]='.';
	MOVLW      46
	MOVWF      _X+2
;Parking.c,153 :: 		X[3]=a3+48;
	MOVLW      48
	ADDWF      FLOC__Aff_Prin+0, 0
	MOVWF      _X+3
;Parking.c,154 :: 		X[4]=a4+48;
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      _X+4
;Parking.c,156 :: 		Lcd_Out(1, 5, msg);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _msg+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Parking.c,157 :: 		if(i)
	MOVF       _i+0, 0
	IORWF      _i+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_Aff_Prin33
;Parking.c,158 :: 		Lcd_Out(2,1,"T=-");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_Parking+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_Aff_Prin34
L_Aff_Prin33:
;Parking.c,160 :: 		Lcd_Out(2,1,"T= ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_Parking+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_Aff_Prin34:
;Parking.c,161 :: 		Lcd_Out(2,4,X);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _X+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Parking.c,162 :: 		strcpy(ch,"");
	MOVLW      _ch+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr5_Parking+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Parking.c,163 :: 		*ch=176;
	MOVLW      176
	MOVWF      _ch+0
;Parking.c,164 :: 		Lcd_Out(2,9,ch);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _ch+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Parking.c,165 :: 		Lcd_Out(2,10,"C | ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      10
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_Parking+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Parking.c,166 :: 		strcpy(ch,"");
	MOVLW      _ch+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr7_Parking+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Parking.c,167 :: 		*ch=pl+48;
	MOVLW      48
	ADDWF      _pl+0, 0
	MOVWF      _ch+0
;Parking.c,168 :: 		Lcd_Out(2,14,"P:");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr8_Parking+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Parking.c,169 :: 		Lcd_Out(2,16,ch);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _ch+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Parking.c,170 :: 		strcpy(ch,"");
	MOVLW      _ch+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr9_Parking+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Parking.c,171 :: 		}
L_end_Aff_Prin:
	RETURN
; end of _Aff_Prin

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Parking.c,172 :: 		void interrupt(){
;Parking.c,173 :: 		cmp++;
	MOVF       _cmp+0, 0
	ADDLW      1
	MOVWF      R0+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _cmp+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _cmp+0
	MOVF       R0+1, 0
	MOVWF      _cmp+1
;Parking.c,174 :: 		TMR0=0;
	CLRF       TMR0+0
;Parking.c,175 :: 		INTCON.T0IF=0;
	BCF        INTCON+0, 2
;Parking.c,176 :: 		}
L_end_interrupt:
L__interrupt43:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt
