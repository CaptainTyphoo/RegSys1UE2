function [parLQR] = LQR_Entwurf(sysd,parLQR)
phi = sysd.a;
gamma = sysd.b;
cc = sysd.c;
phi_I = [phi,zeros(6,1);-cc,1];
gamma_I = [gamma;0];
gamma_rI = [zeros(6,1);1];
[K,S,e] = dlqr(phi_I,gamma_I,parLQR.QEd,parLQR.REd,parLQR.NEd);
parLQR.kx = -K(1:6);
parLQR.kI = -K(7);

%Ausgabe von Dynamimatrix weil gewünsht
parLQR.phi_I=phi_I;
parLQR.phi_I
end