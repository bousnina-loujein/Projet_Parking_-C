clc,
clear all,
close all
T1=[-55,-50,-45,-40,-35,-30,-20,-15,-10,-5];
U1=[-368,-335,-300,-268,-234,-200,-135,-100,-66,-32];
T2=[0,5,10,15,20,30,40,50,60,70,80,90,100,110,140,150];
U2=[0,50,100,150,200,300,400,500,600,700,800,900,1000,1100,1400,1500];
T=[T1,T2];
U=[U1,U2];

% Créer les matrices de coordonnées (grille)
plot(T,U,'-o');
title('Différence de potentiel en fonction de la temptérautre');
xlabel('T(°C)');
ylabel('U(mV)');
grid on;
