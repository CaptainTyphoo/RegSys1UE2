%% A2.2 Linearisierung
clear all;
close all; 
clc;

obere_untere_Ruhelage = 0; % Untere Ruhelage
parDP.phi10_error = 0; % Anfangsstörung

Parameter;

%% Untere Ruhelage
[sysk, sysd]=DP_System(parDP);

%%Eigenwerte und Nullstellen des linearisierten Systems
%Kontinuierlich
puk = pole(sysk);   % doppelter Pol im Ursprung > nicht phasenminimal
zuk = zero(sysk);  

pud = pole(sysd); % es existieren Nullstelen mit |z| >1 -> nicht phasenminimal
zud = zero(sysd);

%% Erreichbarkeit
RR_u = ctrb(sysd);
rank(RR_u)

%% Obere Ruhelage
obere_untere_Ruhelage = 1; % Obere Ruhelage
Parameter;
[sysk, sysd]=DP_System(parDP);

%Eigenwerte und Nullstellen des linearisierten Systems
%Kontinuierlich
%pok = Pole oben kontinuierlich
%zok = Nullstellen oben kontinuierlich
pok = pole(sysk);
zok = zero(sysk); % es existieren Nullstelen mit Re(s)>0 -> nicht phasenminimal

pod = pole(sysd);
zod = zero(sysd); % es existieren Nullstelen mit |z| >1 -> nicht phasenminimal



%% Erreichbarkeit 
RR_o = ctrb(sysd);

rank(RR_o)
