function[q,dq,ddq] = fIKinematics_plus(type, r,dr,ddr, Rx,dz,ddz)

%**************************************************************************
%
%   [q,dq,ddq] = fIKinematics_plus(type, r,dr,ddr, z,dz,ddz)
%
%       r   : ���ʒu      r   = [x,y].'
%       dr  : ��摬�x      dr  = [dx,dy].'
%       ddr : �������x    ddr = [ddx,ddy].'
%       z   : ������
%       dz  : �璷�p���x
%       ddz : �璷�p�����x
%       L   : �����N��  L = [l1, l2, l3].'
%
%       q   : �֐ߊp�x      q   = [q1,q2,q3].'
%       dq  : �֐ߊp���x    dq  = [dq1,dq2,dq3].'
%       ddq : �֐ߊp�����x  ddq = [ddq1,ddq2,ddq3].'
%
%       ver0.1 : �t�^���w���
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

% �֐ߊp�x
q = fIKinematics(type, x);

% �֐ߊp���x
[J,Jp,Jd,U,Ud,Jed] = fJacobi_tensor(type, x);
Jei = [Jp,U];
dq = Jei*dx;

% �֐ߊp�����x
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
