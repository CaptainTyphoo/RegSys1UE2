%% A2.3 Stabilisierung

clear all;
close all;
clc;

simulation=1;  %Wenn 1 dann wird Simluation auch gleich gestartet

% Animation Einstellungen
animation_on=1;
trajektorie_on=0;
video_on=1;
pfad='video.avi';


% Macht genau das was A2_3 soll, Parameter daher dort einstellen
run LoadParameter

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
