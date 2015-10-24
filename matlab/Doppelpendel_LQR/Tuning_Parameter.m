%% Gewichtung Regler
parLQR.Ta = parDP.Ta;
parKAL.Ta = parDP.Ta;

if obere_untere_Ruhelage==1 %obere
    
    %LQR-Gewichtung disk
    parLQR.QEd=parLQR.Q;
    parLQR.REd=parLQR.R;
    parLQR.NEd=parLQR.N;

else %untere
     
    %LQR-Gewichtung disk
    %parLQR.QEd=parLQR.Q;
    %parLQR.REd=
    %parLQR.NEd=
               
end


