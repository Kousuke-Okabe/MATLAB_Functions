function[y, dy] = LPF_2nd(ref_in, F, zeta,Fs)

%□□□□□□□□□□□□□□□□□□□□□□□□□□□□
%   2次のLPF
%             Wn^2
%   -------------------------
%   s^2 + 2*zeta*Wn*s + Wn^2
%
%   [y, dy] = LPF_2nd(signal, F, zeta,Fs)
%                     signal:処理対象信号
%                          F:カットオフ周波数[Hz]
%                       zeta:減衰係数
%                         Fs:サンプリング周波数[Hz]
%□□□□□□□□□□□□□□□□□□□□□□□□□□□□

%----値設定------------------
Ts = 1/Fs;
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
N = size(ref_in,2);
ref_out = zeros(2,N);
ref_out(:,1) = [ref_in(:,1); (ref_in(:,2)-ref_in(:,1))./Ts];

for i = 2:N
    ref_out(:,i) = A*ref_out(:,i-1) + B*ref_in(:,i);
end

y = ref_out(1,:);
dy = ref_out(2,:);

end
