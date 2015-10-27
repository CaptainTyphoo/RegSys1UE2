function [parKAL] = Kalman_Entwurf(sysk,sysd,parKAL)
%Kalman Filter

% The state-space model SYS specifies the plant data (A,[B G],C,[D 0])

% neues System
G=eye(6);
G(1,1)=0;
G(5,5)=0;
sysk = ss(sysk.a,[sysk.b G],sysk.c,[sysk.d zeros(2,size(G,2))]);



[kest,L,P,M,Z] = kalmd(sysk,parKAL.Qn,parKAL.Rn,parKAL.Ta);
parKAL.KK=kest;
parKAL.Asysd=sysd.a;
parKAL.bsysd=sysd.b;
end

