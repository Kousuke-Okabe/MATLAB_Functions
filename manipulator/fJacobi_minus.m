function[J,Jp,err] = fJacobi_minus(r,Rx)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   [J,Jp] = fJacobi_minus(r,Rx)
%
%       r   : ���ʒu�@r=[x,y]'
%       Rx  : �璷�p��
%
%       J   : ���R�r�s��
%       Jp  : ���R�r�s��̋^���t�s��
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

draw = 0;

% %%
% clear
% 
% r = [
%    0.170000000000000
%    0.122727272727273
%    0.100000000000000
%     ];
% Rx = 0.421451010493559;
% 
% draw = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[m check] = size(r);
if check ~= 1
    disp('error : f3L_Jacobi input')
    return;
end

param = get_parameter;
l = param.l;
% [type,Link,Sigma, l, lg, M, I, Tlim, dqlim] = get_paramater();

[q, err] = fIKinematics(r,Rx);
if err == 1
    return;
end


switch type

    case '3d_RRRR'
        % ���4�����N�@Z-Y-Z-Y
        J = [ sin(q(1))*(sin(q(2))*(l(3) + l(4)*cos(q(4))) + l(2)*sin(q(2)) + l(4)*cos(q(2))*cos(q(3))*sin(q(4))) + l(4)*cos(q(1))*sin(q(3))*sin(q(4)), -cos(q(1))*(cos(q(2))*(l(3) + l(4)*cos(q(4))) + l(2)*cos(q(2)) - l(4)*cos(q(3))*sin(q(2))*sin(q(4))),  l(4)*sin(q(4))*(cos(q(3))*sin(q(1)) + cos(q(1))*cos(q(2))*sin(q(3))), cos(q(1))*(l(4)*sin(q(2))*sin(q(4)) - l(4)*cos(q(2))*cos(q(3))*cos(q(4))) + l(4)*cos(q(4))*sin(q(1))*sin(q(3)) ;
              l(4)*sin(q(1))*sin(q(3))*sin(q(4)) - cos(q(1))*(sin(q(2))*(l(3) + l(4)*cos(q(4))) + l(2)*sin(q(2)) + l(4)*cos(q(2))*cos(q(3))*sin(q(4))), -sin(q(1))*(cos(q(2))*(l(3) + l(4)*cos(q(4))) + l(2)*cos(q(2)) - l(4)*cos(q(3))*sin(q(2))*sin(q(4))), -l(4)*sin(q(4))*(cos(q(1))*cos(q(3)) - cos(q(2))*sin(q(1))*sin(q(3))), sin(q(1))*(l(4)*sin(q(2))*sin(q(4)) - l(4)*cos(q(2))*cos(q(3))*cos(q(4))) - l(4)*cos(q(1))*cos(q(4))*sin(q(3)) ;
              0,            - sin(q(2))*(l(3) + l(4)*cos(q(4))) - l(2)*sin(q(2)) - l(4)*cos(q(2))*cos(q(3))*sin(q(4)),                                    l(4)*sin(q(2))*sin(q(3))*sin(q(4)),                                                - l(4)*cos(q(2))*sin(q(4)) - l(4)*cos(q(3))*cos(q(4))*sin(q(2)) ];


    case '3d_PRRR'
        % �����X���C�_���4�����N
        J = [ 1,  sin(q(2))*(l(4)*sin(q(3) + q(4)) + l(3)*sin(q(3))), -cos(q(2))*(l(4)*cos(q(3) + q(4)) + l(3)*cos(q(3))), -l(4)*cos(q(3) + q(4))*cos(q(2)) ;
              0, -cos(q(2))*(l(4)*sin(q(3) + q(4)) + l(3)*sin(q(3))), -sin(q(2))*(l(4)*cos(q(3) + q(4)) + l(3)*cos(q(3))), -l(4)*cos(q(3) + q(4))*sin(q(2)) ;
              0,                                                   0,            - l(4)*sin(q(3) + q(4)) - l(3)*sin(q(3)),           -l(4)*sin(q(3) + q(4)) ];


    case '2d_RRR'
        % ����3�����N
        J = [ -l(2)*sin(q(1) + q(2)) - l(1)*sin(q(1)) - l(3)*sin(q(1) + q(2) + q(3)), - l(2)*sin(q(1) + q(2)) - l(3)*sin(q(1) + q(2) + q(3)), -l(3)*sin(q(1) + q(2) + q(3)) ;
               l(2)*cos(q(1) + q(2)) + l(1)*cos(q(1)) + l(3)*cos(q(1) + q(2) + q(3)),   l(2)*cos(q(1) + q(2)) + l(3)*cos(q(1) + q(2) + q(3)),  l(3)*cos(q(1) + q(2) + q(3)) ];


    case '2d_RRRR'
        % ����4�����N
        J = [ - l(4)*sin(q(1) + q(2) + q(3) + q(4)) - l(2)*sin(q(1) + q(2)) - l(1)*sin(q(1)) - sin(q(1) + q(2) + q(3))*l(3), - l(4)*sin(q(1) + q(2) + q(3) + q(4)) - l(2)*sin(q(1) + q(2)) - sin(q(1) + q(2) + q(3))*l(3), - l(4)*sin(q(1) + q(2) + q(3) + q(4)) - sin(q(1) + q(2) + q(3))*l(3), -l(4)*sin(q(1) + q(2) + q(3) + q(4)) ;
                l(4)*cos(q(1) + q(2) + q(3) + q(4)) + l(2)*cos(q(1) + q(2)) + l(1)*cos(q(1)) + cos(q(1) + q(2) + q(3))*l(3),   l(4)*cos(q(1) + q(2) + q(3) + q(4)) + l(2)*cos(q(1) + q(2)) + cos(q(1) + q(2) + q(3))*l(3),   l(4)*cos(q(1) + q(2) + q(3) + q(4)) + cos(q(1) + q(2) + q(3))*l(3),  l(4)*cos(q(1) + q(2) + q(3) + q(4)) ;
                1,  1,  1,  1 ];


    case '2d_RRRP'
        % ����4�֐߁@�����i0-0-0-=<�j
        J = [ - l(2)*sin(q(1) + q(2)) - l(1)*sin(q(1)) - sin(q(1) + q(2) + q(3))*(l(4) + q(4)) - sin(q(1) + q(2) + q(3))*l(3), - l(2)*sin(q(1) + q(2)) - sin(q(1) + q(2) + q(3))*(l(4) + q(4)) - sin(q(1) + q(2) + q(3))*l(3), - sin(q(1) + q(2) + q(3))*(l(4) + q(4)) - sin(q(1) + q(2) + q(3))*l(3), cos(q(1) + q(2) + q(3));
                l(2)*cos(q(1) + q(2)) + l(1)*cos(q(1)) + cos(q(1) + q(2) + q(3))*(l(4) + q(4)) + cos(q(1) + q(2) + q(3))*l(3),   l(2)*cos(q(1) + q(2)) + cos(q(1) + q(2) + q(3))*(l(4) + q(4)) + cos(q(1) + q(2) + q(3))*l(3),   cos(q(1) + q(2) + q(3))*(l(4) + q(4)) + cos(q(1) + q(2) + q(3))*l(3), sin(q(1) + q(2) + q(3));
                1,                                                                                              1,                                                                      1,                       0];


    case '2d_RRP'
        % ����3�֐߁@�����i0-0-=<�j
        J = [ - l(1)*sin(q(1)) - sin(q(1) + q(2))*(l(2) + l(3) + q(3)), -sin(q(1) + q(2))*(l(2) + l(3) + q(3)), cos(q(1) + q(2)) ;
                l(1)*cos(q(1)) + cos(q(1) + q(2))*(l(2) + l(3) + q(3)),  cos(q(1) + q(2))*(l(2) + l(3) + q(3)), sin(q(1) + q(2)) ];


    otherwise
        error('error f3L_Jacobi_minus');
        
end

Jp = J.'/(J*J.');

end
