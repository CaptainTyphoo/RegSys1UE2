function [parKAL] = Kalman_Entwurf(sysk,sysd,parKAL)
%Kalman Filter

% The state-space model SYS specifies the plant data (A,[B G],C,[D 0])

% neues System mit G und H Matrix
G=eye(6);
G(1,1)=0;
G(5,5)=0;

H=zeros(2,6);

sysk = ss(sysk.a,[sysk.b G],sysk.c,[sysk.d H]);



[kest,L,P,M,Z] = kalmd(sysk,parKAL.Qn,parKAL.Rn,parKAL.Ta);

parKAL.KK=L;

parKAL.Asysd=sysd.a;
parKAL.bsysd=sysd.b;
end

