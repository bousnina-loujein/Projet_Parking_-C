// LCD module connections
sbit LCD_RS at RD5_bit;
sbit LCD_EN at RD4_bit;
sbit LCD_D4 at RD3_bit;
sbit LCD_D5 at RD2_bit;
sbit LCD_D6 at RD1_bit;
sbit LCD_D7 at RD0_bit;

sbit LCD_RS_Direction at TRISD5_bit;
sbit LCD_EN_Direction at TRISD4_bit;
sbit LCD_D4_Direction at TRISD3_bit;
sbit LCD_D5_Direction at TRISD2_bit;
sbit LCD_D6_Direction at TRISD1_bit;
sbit LCD_D7_Direction at TRISD0_bit;
// End LCD module connections


float temperature();
void Aff_Prin();

unsigned int pl;//nbre des places libres
char msg[]="Bienvenue";
unsigned char ch[1]="";
unsigned int a;
float ac;
unsigned int ap,a1,a2,a3,a4;
unsigned char X[5];    /// valeur de type float 76.00
unsigned int i=0;
volatile unsigned int cmp = 0;
int j=0;
void main() {
     TRISB=0xFF;//Input
     TRISC=0x00;//Output
     PORTC=0x00;//Initialisé à 0
     //Sound_Init(&PORTC, 4);
     Lcd_Init(); // Initialize LCD
     Lcd_Cmd(_LCD_CURSOR_OFF);
     
     PORTC.RC1=1;
     Delay_us(250);
     PORTC.RC1=0;
     Delay_ms(20);
     PORTC.RC2=1;
     Delay_us(250);
     PORTC.RC2=0;
     Delay_ms(20);
     
     
     if(EEPROM_Read(0x02)!=0){
     EEPROM_Write(0x02,0);
     EEPROM_Write(0x03,9);
     }
     OPTION_REG.T0CS=0;
     OPTION_REG.PSA=0;
     OPTION_REG.PS2=1;
     OPTION_REG.PS1=1;
     OPTION_REG.PS0=1;
     
     INTCON.GIE=1;
     INTCON.T0IF=0;
     INTCON.T0IE=1;
     pl=EEPROM_Read(0x03);
     Aff_Prin();
     while(1){
              if(temperature()!=temperature())
              Aff_Prin();
              if(PORTB.RB1){  //Capt1=1
              if(pl>0){
                    strcpy(msg,"Bienvenue");
                    Aff_Prin();
                    PORTC.RC1=1;
                    Delay_us(5500);  ///// 5500///////////////////////////////////////////
                    PORTC.RC1=0;
                    Delay_ms(20);   //Ouvrir le barriere 1
                   //while(PORTB.RB1);//Attend Capt1==0
                    while(PORTB.RB2==0);//Attend Capt2=1
                    if(PORTB.RB2){ //Capt2=1
                                   pl--;
                                   EEPROM_Write(0x03,pl);
                                   PORTC.RC7=1;
                                   PORTC.RC1=1;
                                   Delay_us(250);
                                   PORTC.RC1=0;
                                   Delay_ms(20);
                                   Aff_Prin();
                    }
                    }
              }
              
              
              if(PORTB.RB3 && PORTB.RB6){  //Capt3=1 et bp=1
                    PORTC.RC2=1;
                    Delay_us(5500);  ////// 6000    ////////////////////////////////
                    PORTC.RC2=0;
                    Delay_ms(20);   //Ouvrir le barriere 2
                    cmp=0;
                    TMR0=0;
                    while(PORTB.RB4==0){//Attend Capt4=1
                     if(cmp>152)    //////////152    10s
                      PORTC.RC4=1;
                    }
                    PORTC.RC4=0;
                    if(PORTB.RB4){
                    pl++;
                    if(pl>9)
                    pl=9;
                    EEPROM_Write(0x03,pl);
                    strcpy(msg,"Aurevoir");
                    Aff_Prin();
                    PORTC.RC6=1;
                    PORTC.RC2=1;
                    Delay_us(250); //// ////
                    PORTC.RC2=0;
                    Delay_ms(20);
                    }
              }
              
     }
}

float temperature(){
   if(PORTB.RB0==0){
     //Lecture analogique au niveaux de RE0
     ADCON0=0x69;
     ADCON1=0x80;
     ADCON0.go=1;
     while(ADCON0.go); // Attendre que la conversion soit terminée
     a=((ADRESH << 8) + ADRESL);   // justification à dte
     ac=a;
     ac=ac*80/1023;
     i=0;
     }
     else{
     //Lecture analogique au niveaux de RE1
     ADCON0=0x71;
     ADCON1=0x80;
     ADCON0.go=1;
     a=((ADRESH << 8) + ADRESL);
     ac=a;          //Conv int to float
     ac=ac*32/1023;
     i=1;
     }
     return ac;
}
void Aff_Prin(){
     ac=temperature();
     ac=ac*100;
     ap=ac;   //Conv float to int
     a1=ap/1000;
     a2=(ap/100)%10;
     a3=(ap/10)%10;
     a4=ap%10;
     X[0]=a1+48;  // Conv int to char //xx.x
     X[2]='.';
     X[3]=a3+48;
     X[4]=a4+48;

     Lcd_Out(1, 5, msg);
     if(i)
     Lcd_Out(2,1,"T=-");
     else
     Lcd_Out(2,1,"T= ");
     Lcd_Out(2,4,X);
     strcpy(ch,"");
     *ch=176;
     Lcd_Out(2,9,ch);
     Lcd_Out(2,10,"C | ");
     strcpy(ch,"");
     *ch=pl+48;
     Lcd_Out(2,14,"P:");
     Lcd_Out(2,16,ch);
     strcpy(ch,"");
}
void interrupt(){
cmp++;
TMR0=0;
INTCON.T0IF=0;
}