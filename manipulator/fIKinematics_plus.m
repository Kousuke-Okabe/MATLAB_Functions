function[q,dq,ddq] = fIKinematics_plus(type, r,dr,ddr, Rx,dz,ddz)

%**************************************************************************
%
%   [q,dq,ddq] = fIKinematics_plus(type, r,dr,ddr, z,dz,ddz)
%
%       r   : 手先位置      r   = [x,y].'
%       dr  : 手先速度      dr  = [dx,dy].'
%       ddr : 手先加速度    ddr = [ddx,ddy].'
%       z   : 手先向き
%       dz  : 冗長角速度
%       ddz : 冗長角加速度
%       L   : リンク長  L = [l1, l2, l3].'
%
%       q   : 関節角度      q   = [q1,q2,q3].'
%       dq  : 関節角速度    dq  = [dq1,dq2,dq3].'
%       ddq : 関節角加速度  ddq = [ddq1,ddq2,ddq3].'
%
%       ver0.1 : 逆運動学問題
%
%                                                       13.04.05 by OKB
%**************************************************************************

% %%
% clear
% 
% type = '2d_RRR'
% 
% r = [ 
%     0.2000;
%     0.2000
%     ];
% dr = [0; 0];
% ddr = [
%   	0
%    	0
%     ];
% 
% Rx = 1.0472;
% dz = 0;
% ddz = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% disp('fIKinematics_plus')
% type
param = get_parameter(type);
    Link = param.Link;

x = [r;Rx];
dx = [dr;dz];
ddx = [ddr;ddz];

q = nan(Link,1);
dq = nan(Link,1);
ddq = zeros(Link,1);

% 関節角度
q = fIKinematics(type, x);

% 関節角速度
[J,Jp,Jd,U,Ud,Jed] = fJacobi_tensor(type, x);
Jei = [Jp,U];
dq = Jei*dx;

% 関節角加速度
for i = 1:Link
for j = 1:Link
for k = 1:Link
for l = 1:Link
for m = 1:Link
for n = 1:Link
    ddq(i) = ddq(i) - Jei(i,j)*Jed(j,k,l)*Jei(l,m)*Jei(k,n)*dx(m)*dx(n);
end 
end 
end 
end 
end 
end
ddq = ddq + Jei*ddx;

end
