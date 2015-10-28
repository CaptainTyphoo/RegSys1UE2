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
    %parLQR.QEd= diag([1000,0.1,1000,0.1,1,0.001,0.001]);
    %parLQR.REd= 0.12;%1.35;
    %parLQR.NEd=zeros(7,1);
    
else %untere
    a1 = 100;
    a2 = 100;
    a3 = 1;
    a4 = 1;
    a5 = 1;
    Q = diag([a1 a2 a1 a2 a3 a4 a5]);
    R = 10;
    N=zeros(7,1);
    
    %LQR-Gewichtung disk
    parLQR.QEd=Q;
    parLQR.REd=R;
    parLQR.NEd=N;
               
end


