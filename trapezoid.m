function[ref_return] = trapezoid(Lref, N, Srate, Erate, Ts, Initial)

%□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□
%
%   台形指令作成プログラム
%
%   [ref] = trapezoid(Lref, N, Srate, Erate, Ts, Initial)
%           L       : 移動距離(nx1)
%           N       : サンプル数
%           Srate   : スタート台形割合(0-1)
%           Erate   : エンド台形割合(0-1)
%           Initial : 初期位置
%
%□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□

% Lref = [ 1; 0];
% N = 1000;
% Srate = 0.0;
% Erate = 0.0;
% Ts = 1/1000;
% Initial = [ 2; 1 ];

ref_return = zeros(length(Lref),N);
ref_vel = zeros(length(Lref),N);

Vm = Lref/(N*Ts) / (1-Srate/2-Erate/2);

for i = 1:N
    if i < N*Srate
        ref_vel(:,i) = i/(N*Srate) * Vm;
        
    elseif i >= N - N*Erate
        ref_vel(:,i) = Vm - (i-(1-Erate)*N)/(N*Erate) * Vm;
    
    else
        ref_vel(:,i) = Vm;
    end
    
    if i == 1
        ref_return(:,i) = Initial;
    elseif i == N
        ref_return(:,i) = Lref + Initial;
    else
        ref_return(:,i) = ref_return(:,i-1) + ref_vel(:,i)*Ts;
    end
end

% figure(3)
% subplot(2,1,1)
%     plot(1:N,ref_vel(1,:),'r', 1:N,ref_vel(2,:),'b')
%     xlim([1,N])
%     legend('X vel','Yvel')
%     grid on
%     
% subplot(2,1,2)
%     plot(ref_return(1,:),ref_return(2,:),'g')
%     grid on
%     axis equal

end