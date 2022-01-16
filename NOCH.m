function[ref_return] = NOCH(ref_in, F, zeta, Fs)

%□□□□□□□□□□□□□□□□□□□□□□□□□□□□
%   2次のNoch
%         s^2+Wn^2
%   -------------------------
%   s^2 + 2*zeta*Wn*s + Wn^2
%
%   NOCH(signal, Fn, zeta, Fs);
%                     signal:処理対象信号
%                         Fn:カットオフ周波数
%                       zeta:減衰係数
%                         Fs:サンプリング周波数
%
%   2次LPFを用いたNochフィルタ
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

%---LPF--------------------------
N = size(ref_in,2);
LPF_2 = zeros(2,N);

for i = 2:N
    LPF_2(:,i) = A*LPF_2(:,i-1) + B*ref_in(:,i);
end

%---NCHF------------------------
ref_out = zeros(1,N);

for i = 2:N
    ref_out(1,i) = ref_in(1,i) - 2*zeta*LPF_2(2,i)/Wn;
end

ref_return = ref_out;

end