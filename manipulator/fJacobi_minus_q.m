function[J,Jp,err] = fJacobi_minus_q(type,q)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   [J,Jp] = fJacobi_minus_q(type,q)
%
%       type: Arm type
%       q   : �֐ߊp�x
%
%       J   : ���R�r�s��
%       Jp  : ���R�r�s��̋^���t�s��
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% draw = 0;

% %%
% clear
% 
% tyep = '2d_RRRR';
% q = [pi/3; pi/3; pi/3; pi/3];
% 
% draw = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

check = size(q,2);
if check ~= 1
    disp('error : f3L_Jacobi input')
    return;
end

param = get_parameter(type);
l = param.l;
% [type,Link,Sigma, l, lg, M, I, Tlim, dqlim] = get_paramater();



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


    case '2d_RR'
        % ����2�֐�
        J11 = (-l(2)*cos(q(1))*sin(q(2)))-l(2)*sin(q(1))*cos(q(2))-l(1)*sin(q(1));
        J12 = (-l(2)*cos(q(1))*sin(q(2)))-l(2)*sin(q(1))*cos(q(2));
        J21 = (-l(2)*sin(q(1))*sin(q(2)))+l(2)*cos(q(1))*cos(q(2))+l(1)*cos(q(1));
        J22 = l(2)*cos(q(1))*cos(q(2))-l(2)*sin(q(1))*sin(q(2));
        
        J = [ J11, J12 ;
              J21, J22 ];
        
    case '2d_RRR'
        % ����3�����N
        J = [ -l(2)*sin(q(1) + q(2)) - l(1)*sin(q(1)) - l(3)*sin(q(1) + q(2) + q(3)), - l(2)*sin(q(1) + q(2)) - l(3)*sin(q(1) + q(2) + q(3)), -l(3)*sin(q(1) + q(2) + q(3)) ;
               l(2)*cos(q(1) + q(2)) + l(1)*cos(q(1)) + l(3)*cos(q(1) + q(2) + q(3)),   l(2)*cos(q(1) + q(2)) + l(3)*cos(q(1) + q(2) + q(3)),  l(3)*cos(q(1) + q(2) + q(3)) ];


    case '2d_RRRR'
        % ����4�����N
        J = [ - l(4)*sin(q(1) + q(2) + q(3) + q(4)) - l(2)*sin(q(1) + q(2)) - l(1)*sin(q(1)) - sin(q(1) + q(2) + q(3))*l(3), - l(4)*sin(q(1) + q(2) + q(3) + q(4)) - l(2)*sin(q(1) + q(2)) - sin(q(1) + q(2) + q(3))*l(3), - l(4)*sin(q(1) + q(2) + q(3) + q(4)) - sin(q(1) + q(2) + q(3))*l(3), -l(4)*sin(q(1) + q(2) + q(3) + q(4)) ;
                l(4)*cos(q(1) + q(2) + q(3) + q(4)) + l(2)*cos(q(1) + q(2)) + l(1)*cos(q(1)) + cos(q(1) + q(2) + q(3))*l(3),   l(4)*cos(q(1) + q(2) + q(3) + q(4)) + l(2)*cos(q(1) + q(2)) + cos(q(1) + q(2) + q(3))*l(3),   l(4)*cos(q(1) + q(2) + q(3) + q(4)) + cos(q(1) + q(2) + q(3))*l(3),  l(4)*cos(q(1) + q(2) + q(3) + q(4)) ];

	case '2d_R'
        % ����1�����N
        J = [ -l(1)*sin(q(1)) ;
               l(1)*cos(q(1)) ];
            
%     case '2d_RRRP'
%         % ����4�֐߁@�����i0-0-0-=<�j
%         J = [ - l(2)*sin(q(1) + q(2)) - l(1)*sin(q(1)) - sin(q(1) + q(2) + q(3))*(l(4) + q(4)) - sin(q(1) + q(2) + q(3))*l(3), - l(2)*sin(q(1) + q(2)) - sin(q(1) + q(2) + q(3))*(l(4) + q(4)) - sin(q(1) + q(2) + q(3))*l(3), - sin(q(1) + q(2) + q(3))*(l(4) + q(4)) - sin(q(1) + q(2) + q(3))*l(3), cos(q(1) + q(2) + q(3));
%                 l(2)*cos(q(1) + q(2)) + l(1)*cos(q(1)) + cos(q(1) + q(2) + q(3))*(l(4) + q(4)) + cos(q(1) + q(2) + q(3))*l(3),   l(2)*cos(q(1) + q(2)) + cos(q(1) + q(2) + q(3))*(l(4) + q(4)) + cos(q(1) + q(2) + q(3))*l(3),   cos(q(1) + q(2) + q(3))*(l(4) + q(4)) + cos(q(1) + q(2) + q(3))*l(3), sin(q(1) + q(2) + q(3));
%                 1,                                                                                              1,                                                                      1,                       0];


%     case '2d_RRP'
%         % ����3�֐߁@�����i0-0-=<�j
%         J = [ - l(1)*sin(q(1)) - sin(q(1) + q(2))*(l(2) + l(3) + q(3)), -sin(q(1) + q(2))*(l(2) + l(3) + q(3)), cos(q(1) + q(2)) ;
%                 l(1)*cos(q(1)) + cos(q(1) + q(2))*(l(2) + l(3) + q(3)),  cos(q(1) + q(2))*(l(2) + l(3) + q(3)), sin(q(1) + q(2)) ];


    otherwise
        error('error f3L_Jacobi_minus');
        
end

Jp = J.'/(J*J.');

end
