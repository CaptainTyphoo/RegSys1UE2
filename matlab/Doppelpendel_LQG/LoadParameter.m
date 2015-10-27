%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LoadParameter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
warning off;
clc;

simulation=1;       % 1 für Simualtion starten
vorst_plotten = 0;  % 1 für Vorsteuerung plottem

% Obere oder untere Ruhelage (1-0)
obere_untere_Ruhelage = 0;
% Anfangsfehler
parDP.phi10_error = 0*0.1;
% Quantisierung ein/aus (1-0)
Quantisierung = 0;
%Kalman-Filter ein/aus (1-2)
Kalman_Filter = 2;
%Beobachter/Modell  Rï¿½ckfï¿½hrung ein/aus (0-1)
Beobachter_Rueckfuehrung=0;

%Parameter laden
run Parameter
%Systeme laden
[sysk,sysd] = DP_System(parDP);
%Eigenwerte berechnen
disp('Eigenwerte offener Kreis')
Eigenwerte=pole(sysk)
disp('Nullstellen offener Kreis')
Nullstellen=zero(sysk)


%Tuning Parameter laden
run Tuning_Parameter
%LQR-Entwurf
[parLQR] = LQR_Entwurf(sysd,parLQR);

%Kalman-Filter-Entwurf

% C anpassen
cc=zeros(2,6);
cc(1,1)=1;
cc(2,5)=1;
sysk.c=cc;


[parKAL] = Kalman_Entwurf(sysk,sysd,parKAL);
%Vorsteuerungsentwurf
[parFF] = Vorsteuerung_Entwurf(sysk,parFF);

%Vorsteuerung Plotten
if(vorst_plotten==1)
    Vorsteuerung_Plotten(parFF)
end

if(simulation==1)
    disp('Simulations lÃ¤uft...')
    open('Doppelpendel_LQG.slx')
    sim('Doppelpendel_LQG.slx')
end


