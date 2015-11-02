function [parLQR] = LQR_Entwurf(sysd,parLQR)
phi = sysd.a;
gamma = sysd.b;
cc = sysd.c;
phi_I = [phi,zeros(6,1);-cc,1];
gamma_I = [gamma;0];
gamma_rI = [zeros(6,1);1];
[K,S,e] = dlqr(phi_I,gamma_I,parLQR.QEd,parLQR.REd,parLQR.NEd);
parLQR.kx = -K(1:6); % Achtung Vorzeichenkonvention
parLQR.kI = -K(7);
end