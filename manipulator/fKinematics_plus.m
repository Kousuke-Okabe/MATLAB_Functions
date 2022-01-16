function[r,dr,ddr,Rx,Rv,Ra] = fKinematics_plus(type, q,dq,ddq)

%**************************************************************************
%
%   [r,dr,ddr,Rx,Rv,Ra] = fKinematics_plus(q,dq,ddq)
%
%       r   : èæˆÊ’u      r   = [x,y].'
%       dr  : èæ‘¬“x      dr  = [dx,dy].'
%       ddr : èæ‰Á‘¬“x    ddr = [ddx,ddy].'
%       Rx  : ç’·p¨
%       Rv  : ç’·‘¬“x
%       Ra  : ç’·‰Á‘¬“x
%
%       q   : ŠÖßŠp“x      q   = [q1,q2,q3].'
%       dq  : ŠÖßŠp‘¬“x    dq  = [dq1,dq2,dq3].'
%       ddq : ŠÖßŠp‰Á‘¬“x  ddq = [ddq1,ddq2,ddq3].'
%
%       ver0.1 : ‹t‰^“®Šw–â‘è
%
%                                                       15.12.09 by OKB
%**************************************************************************

% param = get_parameter(type);
% [type,Link,Sigma, l,lg,M,I, Tlim,dqlim, C,mu, Joint,L_pat] = get_paramater();

temp = kinematics(q);
r = temp(:,Link+1);
Rx = Sigma*q;

[J,Jp,U,error] = f3L_Jacobi(r,Rx);

dr = J*dq;
Rv = U'*dq;

[J,Jp,dJ,U,error] = f3L_Jacobi_plus(r,dr, Rx,Rv);

ddr = J*ddq + dJ*dq;
Ra = U'*ddq;

end
