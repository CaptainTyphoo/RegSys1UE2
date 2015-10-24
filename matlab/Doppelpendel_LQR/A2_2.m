%% A2.2 Linearisierung
clear all;
close all; 
clc;

setparDP;

parDP.xR=zeros(1,6);
parDP.uR=0;
parDP.Ta=1e-3;

%% Untere Ruhelage
parDP.xR=[pi 0 pi 0 0 0];
[sysk, sysd]=DP_System(parDP);

%%Eigenwerte und Nullstellen des linearisierten Systems
%Kontinuierlich
puk = pole(sysk);   % doppelter Pol im Ursprung > nicht phasenminimal
zuk = zero(sysk);  

pud = pole(sysd); % es existieren Nullstelen mit |z| >1 -> nicht phasenminimal
zud = zero(sysd);

%% Obere Ruhelage
[sysk, sysd]=DP_System(parDP);

%Eigenwerte und Nullstellen des linearisierten Systems
%Kontinuierlich
%pok = Pole oben kontinuierlich
%zok = Nullstellen oben kontinuierlich
pok = pole(sysk);
zok = zero(sysk); % es existieren Nullstelen mit Re(s)>0 -> nicht phasenminimal

pod = pole(sysd);
zod = zero(sysd); % es existieren Nullstelen mit |z| >1 -> nicht phasenminimal

RR_u = ctrb(sysd);
rank(RR_u)

%% Erreichbarkeit 
RR_o = ctrb(sysd);

rank(RR_o)
