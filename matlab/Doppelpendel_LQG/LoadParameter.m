%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LoadParameter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
warning off;
clc;

simulation=1;       % 1 f�r Simualtion starten

% Animation Einstellungen
animation_on=0;       % Animation anzeigen 1=ja, wenn ja dann ->
trajektorie_on=0;     % Trajektorie anzeigen
video_on=0;           % Video speichern (ohne Trajektorie)
pfad='video.avi';     % Dateiname f�r Video (mit .avi !)


vorst_plotten = 0;  % 1 f�r Vorsteuerung plotten

% Obere oder untere Ruhelage (1-0)
obere_untere_Ruhelage = 1;
% Anfangsfehler
parDP.phi10_error = 0*0.1;
% Quantisierung ein/aus (1-0)
Quantisierung = 0;
%Kalman-Filter ein/aus (1-2)
Kalman_Filter = 1;
%Beobachter/Modell  R�ckf�hrung ein/aus (0-1)
Beobachter_Rueckfuehrung=1;

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
    disp('Simulations l�uft...')   
    
    if(strfind(version,'2015b'))
        open('Doppelpendel_LQG_2015b.slx')
        sim('Doppelpendel_LQG_2015b.slx')
    elseif(strfind(version,'2015a'))
        open('Doppelpendel_LQG_2015a.slx')
        sim('Doppelpendel_LQG_20145a.slx')
    elseif(strfind(version,'2014b'))
        open('Doppelpendel_LQG_2014b.slx')
        sim('Doppelpendel_LQG_2014b.slx')
    else
        fprintf('Kein Simulinkmodel f�r Version '); fprintf(version); fprintf('gefunden!\n');
    end
end

%% ANIMATION

if(animation_on==1 && simulation==1)
   
    load('statesNL.mat');

    w1=data(2,:)+pi/2;
    w2=data(4,:)+pi/2;
    wagen_pos=data(6,:);

    time=data(1,2)-data(1,1);
    
    if(video_on==1)
        Animation(wagen_pos,w1,w2,time,0,pfad) %Video speichern
    elseif(trajektorie_on==1)
        Animation(wagen_pos,w1,w2,time,1) % Animation mit Trajektorie
    else
        Animation(wagen_pos,w1,w2,time) %reine Animation
    end

end


