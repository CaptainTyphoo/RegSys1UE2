function [parFF] = Vorsteuerung_Entwurf(sysk,parFF)
    
    R = ctrb(sysk);
    en = [zeros(size(R,1)-1,1);1];
    v1 = (en'/R)';
    
    V = [v1';v1'*sysk.a;v1'*sysk.a^2;v1'*sysk.a^3;v1'*sysk.a^4;v1'*sysk.a^5];
    parFF.VVinv =  V^-1;
    Aw = V*sysk.a*parFF.VVinv;
    parFF.aa = [-Aw(end,:),1];
end