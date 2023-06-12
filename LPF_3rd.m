function[y,dy,ddy] = LPF_3rd(u, F, Fs)

%□□□□□□□□□□□□□□□□□□□□□□□□□□□□
%   2次のLPF
%
%   [y,dy,ddy] = LPF_3rd(ref_in, F, Fs)
%                          u:処理対象信号
%                          F:カットオフ周波数[Hz]
%                         Fs:サンプリング周波数[Hz]
%□□□□□□□□□□□□□□□□□□□□□□□□□□□□

df = 0;

% %%
% clear all
% 
% u = rand(1,1000) - 0.5*ones(1,1000);
% F = 50;
% Fs = 1000;
% df = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ts = 1/Fs;  % Sampling Time
w = 2*pi*F; % Cut off angular frequency
N = size(u,2);

A = nan(3);

A(1,1) = ( w^2/2*Ts^2 + w*Ts + 1 )*exp(-w*Ts);
A(2,1) = -w^3/2*Ts^2*exp(-w*Ts);
A(3,1) = ( w^4/2*Ts^2 - w^3*Ts )*exp(-w*Ts);

A(1,2) = ( w*Ts^2 + Ts )*exp(-w*Ts);
A(2,2) = ( -w^2*Ts^2 + w*Ts + 1 )*exp(-w*Ts);
A(3,2) = ( w^3*Ts^2 - 3*w^2*Ts )*exp(-w*Ts);

A(1,3) = 1/2*Ts^2*exp(-w*Ts);
A(2,3) = ( Ts - w/2*Ts^2 )*exp(-w*Ts);
A(3,3) = ( w^2/2*Ts^2 - 2*w*Ts + 1 )*exp(-w*Ts);

B = nan(3,1);

B(1,1) = -( w^2/2*Ts^2 + w*Ts + 1 )*exp(-w*Ts) + 1;
B(2,1) = w^3/2*Ts^2*exp(-w*Ts);
B(3,1) = ( w^3*Ts - w^4/2*Ts^2 )*exp(-w*Ts);


Y = nan(3,N);
Y(:,1) = u(:,1);
for k = 1:N-1
    Y(:,k+1) = A*Y(:,k) + B*u(:,k);
end

y = Y(1,:);
dy = Y(2,:);
ddy = Y(3,:);

if df == 1
    FH = 100;
    figure(FH)
    clf(FH)
    subplot(2,1,1)
        plot(1:N,u,'r', 1:N,y,'b')
    
    % フーリエ変換
    fftk = fft(y);
    ffts = (0:length(fftk)-1)*Fs/length(fftk);
    subplot(2,1,2)
        plot(ffts,abs(fftk))
        xlim([0,500])
        xlabel('Frequency (Hz)')
        ylabel('Magnitude')
end

end
