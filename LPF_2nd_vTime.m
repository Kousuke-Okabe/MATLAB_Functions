function[y, dy] = LPF_2nd_vTime(in,out_1,Ts, F, zeta)

%□□□□□□□□□□□□□□□□□□□□□□□□□□□□
%   2次のLPF
%
%   [LPF_out(k), d/dt LPF_out(k)] = LPF_2nd_vTime(signal(k),LPF_out(k-1),Ts, F, zeta)
%
%□□□□□□□□□□□□□□□□□□□□□□□□□□□□

%----値設定------------------
Wn = 2*pi*F;

if zeta ==1
    A = [ (1+Wn*Ts)*exp(-Wn*Ts),    Ts*exp(-Wn*Ts);
           -Wn^2*Ts*exp(-Wn*Ts),     (1-Wn*Ts)*exp(-Wn*Ts) ];
    
    B = [ 1-(1+Wn*Ts)*exp(-Wn*Ts);
           Wn^2*Ts*exp(-Wn*Ts)       ];

elseif zeta > 1
    T1 = 1/(zeta*Wn+Wn*sqrt(zeta^2-1));
    T2 = 1/(zeta*Wn-Wn*sqrt(zeta^2-1));

    A = [ (T1*exp(-Ts/T2)-T2*exp(-Ts/T1))/(T1-T2) + T1*T2*(1/T1+1/T2)*(exp(-Ts/T1)-exp(-Ts/T2))/(T1-T2),   T1*T2*(exp(-Ts/T1)-exp(-Ts/T2))/(T1-T2);
           -T1*T2*Wn^2*(exp(-Ts/T1)-exp(-Ts/T2))/(T1-T2),                                                    (T1*exp(-Ts/T2)-T2*exp(-Ts/T1))/(T1-T2) ];
    B = [ T1*T2*Wn^2*(1+(T1*exp(-Ts/T1)-T2*exp(-Ts/T2))/(T2-T1));
           Wn^2*T1*T2*(exp(-Ts/T1)-exp(-Ts/T2))/(T1-T2)           ];
    
elseif zeta > 0 && zeta < 1
    EX = exp(-zeta*Wn*Ts);
    Z = sqrt(1-zeta^2);
    Fai = atan(Z/-zeta);
    
    A = [ -EX/Z*sin(Wn*Z*Ts+Fai)+2*zeta/Z*EX*sin(Wn*Z*Ts),   1/(Wn*Z)*EX*sin(Wn*Z*Ts);
          -Wn/Z*EX*sin(Wn*Z*Ts),                             -EX/Z*sin(Wn*Z*Ts+Fai)     ];
    
    B = [ 1-1/Z*EX*sin(Wn*Z*Ts-Fai);
          Wn/Z*EX*sin(Wn*Z*Ts)       ];
    
    %{
    Z = sqrt(1-zeta^2);
    Fai = atan(Z/-zeta);
    
    A = [ exp(-zeta*Wn*Ts)*sin(Wn*Z*Ts+Fai)/Z+2*zeta*exp(-zeta*Wn*Ts)*sin(Wn*Z*Ts)/Z,   exp(-zeta*Wn*Ts)*sin(Wn*Z*Ts)/(Wn*Z);
          -Wn*exp(-zeta*Wn*Ts)*sin(Wn*Z*Ts)/Z,                                          exp(-zeta*Wn*Ts)*sin(Wn*Z*Ts+Fai)/Z     ];
    
    B = [ 1+exp(-zeta*Wn*Ts)*sin(Wn*Z*Ts-Fai)/Z;
          Wn*exp(-zeta*Wn*Ts)*sin(Wn*Z*Ts)/Z    ];
    %}
end

%---2nd_LPF--------------------------
ref_out = A*out_1 + B*in;

y = ref_out(1,:);
dy = ref_out(2,:);

end
