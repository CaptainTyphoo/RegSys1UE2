%% Gewichtung Regler
parLQR.Ta = parDP.Ta;
parKAL.Ta = parDP.Ta;
if obere_untere_Ruhelage==1 %obere
    a1 = 1000;
    a2 = 500;
    a3 = 1;
    a4 = 1;
    a5 = 4;
    Q = diag([a1 a2 a1 a2 a3 a4 a5]);
    R = 10;
    N=zeros(7,1);
    
    %LQR-Gewichtung disk
    parLQR.QEd=Q;
    parLQR.REd=R;
    parLQR.NEd=N;

else %untere
    a1 = 100;
    a2 = 100;
    a3 = 1;
    a4 = 1;
    a5 = 0.1;
    Q = diag([a1 a2 a1 a2 a3 a4 a5]);
    R = 10;
    N=zeros(7,1);
    
    %LQR-Gewichtung disk
    parLQR.QEd=Q;
    parLQR.REd=R;
    parLQR.NEd=N;
               
end

%% Gewichtung Beobachter

    a1 = 1;
    a2 = 1000;
    a3 = 1;
    a4 = 100;
    Q = diag([a1 a2 a1 a2 a3 a4]);
    
    gamma1 = 1;
    gamma2 = 1;
    R = diag([gamma1 gamma2]);
    
    
if obere_untere_Ruhelage==1 %obere
        
    %Kovarianzmatrizen
    parKAL.Qn=Q;
    parKAL.Rn=R;

else %untere
         
    %Kovarianzmatrizen
    parKAL.Qn=Q;
    parKAL.Rn=R;
           
end


