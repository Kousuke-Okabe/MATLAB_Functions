function[ref_return] = HPF_2nd(ref_in, F, zeta, Fs)

%□□□□□□□□□□□□□□□□□□□□□□□□□□□□
%    2次のHPF
%               s^2
%    -------------------------
%    s^2 + 2*zeta*Wn*s + Wn^2
%    
%    HPF_2nd(signal, F, zeta, Fs);
%                     signal:処理対象信号
%                          F:カットオフ周波数
%                       zeta:減衰係数
%                         Fs:サンプリング周波数
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
end

%---2nd_LPF--------------------------
N = size(ref_in,2);
LPF_out = zeros(2,N);

for i = 2:N
    LPF_out(:,i) = A*LPF_out(:,i-1) + B*ref_in(:,i);
end

%---2nd_HPF--------------------------
HPF_out = zeros(1,N);

for i = 1:N
    HPF_out(1,i) = ref_in(1,i) - 2*zeta*LPF_out(2,i)/Wn - LPF_out(1,i);
end

ref_return = HPF_out(1,:);

end