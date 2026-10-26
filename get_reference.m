function[q, time,N] = get_reference()

%**************************************************************************
%
%   
%                                                       14.01. by OKB
%**************************************************************************

draw = 0;

% %%
% disp('TEST MODE : get_reference')
% 
% clear all
% draw = 1;

%**************************************************************************

type = 'C03160';

param = get_parameter(type);
    Link = param.Link;

Fs = 1000;
Ts = 1/Fs;

time = 0.5;
t_ready = 0.45;
t_move = time-t_ready;

N = time*Fs;
N_ready = t_ready*Fs;
N_move = N-N_ready;

t = (1:N)*Ts;

r_mes = [0.4; 0];
z_mes = 0;

% 手先速度によるDMP並進
dr_mes = -0.2*[1/sqrt(2); -1/sqrt(2)];
dz_mes = 0;

% % 内部運動速度によるDMP並進
% dr_mes = [0;0];
% dz_mes = 1;

step = 0.1;
theta = 90/180*pi;
r_step = [cos(theta),-sin(theta);sin(theta),cos(theta)]*[1;0]*step;
z_step = 0;
% ddr_mes = [cos(theta),-sin(theta);sin(theta),cos(theta)]*[1;0]*100;
% ddz_mes = 0;

% 変数宣言
q = nan(Link,N);
dq = zeros(size(q));
r = nan(2,N);
dz = nan(1,N);

r_ref = nan(2,N);
dr_ref = nan(2,N);
dz_ref = nan(1,N);

% 指令生成
r_ref(1,1:N_ready) = linspace(r_mes(1)-dr_mes(1)*t_ready, r_mes(1), N_ready);
r_ref(2,1:N_ready) = linspace(r_mes(2)-dr_mes(2)*t_ready, r_mes(2), N_ready);
dr_ref(:,1:N_ready) = diag(dr_mes)*ones(2,N_ready);
dz_ref(1,1:N_ready) = dz_mes*ones(1,N_ready);

% before measurement
q(:,N_ready+1) = fIKinematics(type,[r_mes;z_mes]);
for k = N_ready:-1:1
    [J,Jp,U,error] = fJacobi_q(type,q(:,k+1));
    q(:,k) = q(:,k+1) - ( Jp*dr_ref(:,k) + U*dz_ref(:,k) )*Ts;
end

% after measurement
q(:,N_ready+1:N) = diag(fIKinematics(type,[r_mes+r_step; z_mes+z_step]))*ones(Link,N_move);

% calculate dz
for k = 1:N
    r(:,k) = fKinematics(type,q(:,k));
    
    if k>2
        [J,Jp,U,error] = fJacobi_q(type,q(:,k));
        
        dq(:,k) = (q(:,k)-q(:,k-1))/Ts;
        dz(:,k) = U'*dq(:,k);
    end
end

if draw == 1
    % draw
    figure(2)
    subplot(2,1,1)
        plot(t,r_ref(1,:),'r', t,r(1,:),'b', t,r_ref(2,:),'r', t,r(2,:),'b')
        xlabel('time [sec]')
        ylabel('r [m]')

    subplot(2,1,2)
        plot(t,dz_ref(1,:),'r', t,dz(1,:),'b')
        xlabel('time [sec]')
        ylabel('dz')

    FH = 1;
    figure(FH)
    clf(FH)
    fRoboAnimation(type,FH,q(:,1:N), r(:,1:N),Ts);
end

end
