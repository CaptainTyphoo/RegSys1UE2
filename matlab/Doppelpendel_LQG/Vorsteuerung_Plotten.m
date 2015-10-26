function [] = Vorsteuerung_Plotten(parFF)

s0 = 0;
sT = 0.5;
T = 3;

x0 = [0;0;0;0;s0;0];
xT = [0;0;0;0;sT;0];

dx0 = x0-x0;
dxT = xT-x0;

dxi0 = parFF.VVinv\dx0;
dxiT = parFF.VVinv\dxT;

dz0 = dxi0(1);
dzT = dxiT(1);

t = 0:1e-3:T;


beta10 = -24024;
beta11 = 16380;
beta12 = -6006;
beta13 = 924;
beta7 = 1716;
beta8 = -9009;
beta9 = 20020;
dzd = dz0 + (dzT - dz0) * (beta7 * t .^ 7 / T .^ 7 + beta8 * t .^ 8 / T .^ 8 + beta9 * t .^ 9 / T .^ 9 + beta10 * t .^ 10 / T .^ 10 + beta11 * t .^ 11 / T .^ 11 + beta12 * t .^ 12 / T .^ 12 + beta13 * t .^ 13 / T .^ 13);
dzdp = (dzT - dz0) * (7 * beta7 * t .^ 6 / T .^ 7 + 8 * beta8 * t .^ 7 / T .^ 8 + 9 * beta9 * t .^ 8 / T .^ 9 + 10 * beta10 * t .^ 9 / T .^ 10 + 11 * beta11 * t .^ 10 / T .^ 11 + 12 * beta12 * t .^ 11 / T .^ 12 + 13 * beta13 * t .^ 12 / T .^ 13);
dzdpp = (dzT - dz0) * (42 * beta7 * t .^ 5 / T .^ 7 + 56 * beta8 * t .^ 6 / T .^ 8 + 72 * beta9 * t .^ 7 / T .^ 9 + 90 * beta10 * t .^ 8 / T .^ 10 + 110 * beta11 * t .^ 9 / T .^ 11 + 132 * beta12 * t .^ 10 / T .^ 12 + 156 * beta13 * t .^ 11 / T .^ 13);
dzdppp = (dzT - dz0) * (210 * beta7 * t .^ 4 / T .^ 7 + 336 * beta8 * t .^ 5 / T .^ 8 + 504 * beta9 * t .^ 6 / T .^ 9 + 720 * beta10 * t .^ 7 / T .^ 10 + 990 * beta11 * t .^ 8 / T .^ 11 + 1320 * beta12 * t .^ 9 / T .^ 12 + 1716 * beta13 * t .^ 10 / T .^ 13);
dzdpppp = (dzT - dz0) * (840 * beta7 * t .^ 3 / T .^ 7 + 1680 * beta8 * t .^ 4 / T .^ 8 + 3024 * beta9 * t .^ 5 / T .^ 9 + 5040 * beta10 * t .^ 6 / T .^ 10 + 7920 * beta11 * t .^ 7 / T .^ 11 + 11880 * beta12 * t .^ 8 / T .^ 12 + 17160 * beta13 * t .^ 9 / T .^ 13);
dzdppppp = (dzT - dz0) * (2520 * beta7 * t .^ 2 / T .^ 7 + 6720 * beta8 * t .^ 3 / T .^ 8 + 15120 * beta9 * t .^ 4 / T .^ 9 + 30240 * beta10 * t .^ 5 / T .^ 10 + 55440 * beta11 * t .^ 6 / T .^ 11 + 95040 * beta12 * t .^ 7 / T .^ 12 + 154440 * beta13 * t .^ 8 / T .^ 13);
dzdpppppp = (dzT - dz0) * (5040 * beta7 * t / T .^ 7 + 20160 * beta8 * t .^ 2 / T .^ 8 + 60480 * beta9 * t .^ 3 / T .^ 9 + 151200 * beta10 * t .^ 4 / T .^ 10 + 332640 * beta11 * t .^ 5 / T .^ 11 + 665280 * beta12 * t .^ 6 / T .^ 12 + 1235520 * beta13 * t .^ 7 / T .^ 13);


dxi = [dzd;dzdp;dzdpp;dzdppp;dzdpppp;dzdppppp];
dx = parFF.VVinv*dxi;

figure
subplot(4,2,1)
plot(t,dzd);
legend('\Delta z_d(t)','location','southeast')
subplot(4,2,2)
plot(t,dzdp);
legend('\Delta z^{(1)}_d(t)','location','southeast')
subplot(4,2,3)
plot(t,dzdpp);
legend('\Delta z^{(2)}_d(t)','location','southeast')
subplot(4,2,4)
plot(t,dzdppp);
legend('\Delta z^{(3)}_d(t)','location','southeast')
subplot(4,2,5)
plot(t,dzdpppp);
legend('\Delta z^{(4)}_d(t)','location','southeast')
subplot(4,2,6)
plot(t,dzdppppp);
legend('\Delta z^{(5)}_d(t)','location','southeast')
subplot(4,2,7)
plot(t,dzdpppppp);
legend('\Delta z^{(6)}_d(t)','location','southeast')


figure
subplot(3,2,1)
plot(t,dx(1,:));
legend('\phi_1','location','southeast')
subplot(3,2,2)
plot(t,dx(2,:));
legend('\omega_1','location','southeast')
subplot(3,2,3)
plot(t,dx(3,:));
legend('\phi_2','location','southeast')
subplot(3,2,4)
plot(t,dx(4,:));
legend('\omega_2','location','southeast')
subplot(3,2,5)
plot(t,dx(5,:));
legend('s','location','southeast')
subplot(3,2,6)
plot(t,dx(6,:));
legend('w','location','southeast')




end