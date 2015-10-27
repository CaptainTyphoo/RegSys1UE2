function [] = Animation( wagen_pos,w1,w2,Ta,trajek,pfad)
%Doppel-Pendel Animation
%
% Input:  
%         wagen_pos (nx1) ...n>1  -> wird automatisch skaliert
%         w1, w2    (nx1)....n>1  -> Winkel in rad
%         Ta         Abttastzeit in s, notwendig für richte Pause und fps
% Input optional
%         trajekt   int    .... wenn 1, dann wird trajektorie gezeichnet
%         pfad      string .... wenn vorhanden (mit ".avi" hinten!!!) 
%                   dann wird die Anmiation als .avi File gespeichert 
%                   (Achtung es wird dadurch sehr langsam)


if(length(wagen_pos)~=length(w1) || length(w1)~=length(w2) || length(w1)<2 || length(w2)<2 || length(wagen_pos)<2)
 fprintf('input vectors must have same size and must be > 1 \n');
  return
end
if(nargin==6)
    if(Ta<(1/25))
        shrink=ceil((1/25)/Ta);
        w1=w1(1:shrink:end);
        w2=w2(1:shrink:end);
        wagen_pos=wagen_pos(1:shrink:end);
    else
        spread=ceil(Ta/(1/25));
        w1=reshape(repmat(w1,1,spread)',[],1);
        w2=reshape(repmat(w2,1,spread)',[],1);
        wagen_pos=reshape(repmat(wagen_pos,1,spread)',[],1);
    end
    writerObj = VideoWriter(pfad);
    open(writerObj);
end


%Balken
balken_width=200;
balken_heigth=5;
balken_color=[0.6 0.6 0.6];

%Wagen
wagen_width=20;
wagen_heigth=balken_heigth+4;
wagen_color=[0.1 0.1 1];

%
wagen_pos=wagen_pos-min(wagen_pos);
wagen_pos=wagen_pos./max(wagen_pos).*(balken_width-2*balken_heigth-wagen_width)+balken_heigth;


%Pendel
pendel_width=7;
pendel_heigth1=42;
pendel_heigth2=48;
pendel_color1=[1 0.3 0.3];
pendel_color2=[0.3 1 0.3];



if (exist('animation_plot','var'))
   figure(animation_plot);
else
    animation_plot=figure('Name','Simulation Plot Window','NumberTitle','off','units','normalized','outerposition',[0 0 1 1]);
    
    %Configure Figure
    pendel_heigth=pendel_heigth1+pendel_heigth2;
    xlim([-pendel_heigth balken_width+pendel_heigth]);
    ylim([-(2*pendel_heigth+balken_width)/2 (2*pendel_heigth+balken_width)/2]);
    axis square;
    
    
    %Plot Balken UND Stuezen
    rectangle('Position',[0 0 balken_width balken_heigth],'FaceColor',balken_color);
    rectangle('Position',[0 -balken_width/4 balken_heigth  balken_width/4],'FaceColor',balken_color);
    rectangle('Position',[balken_width-balken_heigth -balken_width/4 balken_heigth  balken_width/4],'FaceColor',balken_color);
end



%Start Parameter


%Dummies
pendel1=line([0,0],[0,0]);
pendel2=line([0,0],[0,0]);
wagen=rectangle('Position',[0 0 0 0]);

hold on;
for j=1:length(w1);

delete(pendel1);
delete(pendel2);
delete(wagen);

%Plot Wagen
wagen=rectangle('Position',[wagen_pos(j) -(wagen_heigth-balken_heigth)/2 wagen_width wagen_heigth],'Curvature',0.2,'FaceColor',wagen_color,'EdgeColor',wagen_color);

%Plot Pendel1
x_start=round(wagen_pos(j)+wagen_width/2,0);
y_start=round(wagen_heigth/2,0);
x_end=x_start+cos(w1(j))*pendel_heigth1;
y_end=y_start+sin(w1(j))*pendel_heigth1;
pendel1=line([x_start,x_end],[y_start,y_end],'Color',pendel_color1,'LineWidth',pendel_width);

%Plot Pendel2
x_start=x_end;
y_start=y_end;
x_end=x_start+cos(w2(j))*pendel_heigth2;
y_end=y_start+sin(w2(j))*pendel_heigth2;


pendel2=line([x_start,x_end],[y_start,y_end],'Color',pendel_color2,'LineWidth',pendel_width);
 
if(nargin>4 && trajek==1 && j>1) 
   line([x_end_old x_end],[y_end_old y_end],'Color',[1 0.5 0.5]);
end


if(nargin==6)
   writeVideo(writerObj,getframe(gcf));
   title(sprintf('%d von %d',j,length(w1)));
else
    pause(Ta);
end

x_end_old=x_end;
y_end_old=y_end;

end


hold off;

if(nargin==6)
    close(writerObj);
end

end


