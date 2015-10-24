%% A2.3 Stabilisierung
clear all;
close all; 
clc;
a1 = 100;
a2 = 100;
a3 = 1;
a4 = 1;
a5 = 1;
parLQR.Q = diag([a1 a2 a1 a2 a3 a4 a5]);
parLQR.R = 1;
parLQR.N=zeros(7,1);
obere_untere_Ruhelage = 1; % Obere Ruhelage
parDP.phi10_error=0.1; % Anfangsst?rung 0.1rad
Parameter;
[sysk, sysd]=DP_System(parDP);
parLQR = LQR_Entwurf(sysd,parLQR);

