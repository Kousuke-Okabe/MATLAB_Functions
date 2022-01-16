function[out] = LPF_1st(in, Kd,Ts)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   [out] = LPF_1st(in, Kd,Ts)
%
%       in : Input Signals  各行に対してLPFを適用
%       Kd : Time Constant
%       Ts : Sampling Time
%
%       out: Output Signall
%
%                                                       16.07.11 by.OKB
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

draw = 0;

% %%
% clear all
% 
% Ns = 100;
% in = [zeros(1,Ns/2),ones(1,Ns/2); ones(1,Ns/2),zeros(1,Ns/2)];
% 
% Kd = 2*pi*100;
% Ts = 1/1000;
% 
% clearvars -except in Kd Ts
% draw = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[Nd,Ns] = size(in);
out = nan(size(in));

out(:,1) = in(:,1);

for i = 1:Nd
    for k = 1:Ns-1
        out(i,k+1) = out(i,k)*exp(-Kd*Ts) + in(i,k)*(1-exp(-Kd*Ts));
    end
end

if draw == 1
figure(1)
clf(1)
for i = 1:Nd
    subplot(Nd,1,i)
    hold on
    plot(linspace(0,1,Ns),out(i,:),'g')
    stairs(linspace(0,1,Ns),in(i,:),'r')
    xlim([0,1])
    legend('out','in', 'location','best')
end
end
