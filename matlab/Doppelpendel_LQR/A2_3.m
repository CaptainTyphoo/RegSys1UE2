%% A2.3 Stabilisierung
clear all;
close all; 
clc;

obere_untere_Ruhelage = 1; % Obere Ruhelage
parDP.phi10_error=0.1; % Anfangsstörung 0.1rad
%parDP.phi10_error=0; % keine Anfangsstörung
Parameter;
[sysk, sysd]=DP_System(parDP);
parLQR = LQR_Entwurf(sysd,parLQR);

