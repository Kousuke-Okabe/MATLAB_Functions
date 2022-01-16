function[J,Jp,dJ,U,err] = fJacobi_plus(r,dr, Rx,Rv)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   [J,Jp,dJ,U,error] = fJacobi_plus(r,dr, Rx,Rv)
%
%       r   : ���ʒu�@r=[x,y]'
%       Rx  : �璷�p��
%
%       J   : ���R�r�s��
%       Jp  : ���R�r�s��̋^���t�s��
%       dJ  : ���R�r�s��̎��Ԕ���
%       U   : ���R�r�s��̐��K���������
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

draw = 0;

% %%
% clear
% r = [ 0.1; 0.05 ];
% dr = [ -0.5; 0.02 ];
% 
% Rx = pi;
% Rv = -0.3;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

err = 0;

[m, check] = size(r);
if check ~= 1
    disp('error : f3L_Jacobi_plus input')
    
    err = 1;
    return;
end

param = get_parameter;
    Link = param.Link;
    l = param.l;

[J,Jp,U,error] = fJacobi(r,Rx);

[q, err] = fIKinematics(r(:,1),Rx(:,1));
dq = Jp*dr + U*Rv;


switch type

    case '3d_RRRR'
        % ���4�����N�@Z-Y-Z-Y
        dJ = [ dq(3)*(l(4)*cos(q(1))*cos(q(3))*sin(q(4)) - l(4)*cos(q(2))*sin(q(1))*sin(q(3))*sin(q(4))) + dq(1)*(cos(q(1))*(sin(q(2))*(l(3) + l(4)*cos(q(4))) + l(2)*sin(q(2)) + l(4)*cos(q(2))*cos(q(3))*sin(q(4))) - l(4)*sin(q(1))*sin(q(3))*sin(q(4))) - dq(4)*(sin(q(1))*(l(4)*sin(q(2))*sin(q(4)) - l(4)*cos(q(2))*cos(q(3))*cos(q(4))) - l(4)*cos(q(1))*cos(q(4))*sin(q(3))) + dq(2)*sin(q(1))*(cos(q(2))*(l(3) + l(4)*cos(q(4))) + l(2)*cos(q(2)) - l(4)*cos(q(3))*sin(q(2))*sin(q(4))), dq(1)*sin(q(1))*(cos(q(2))*(l(3) + l(4)*cos(q(4))) + l(2)*cos(q(2)) - l(4)*cos(q(3))*sin(q(2))*sin(q(4))) + dq(2)*cos(q(1))*(sin(q(2))*(l(3) + l(4)*cos(q(4))) + l(2)*sin(q(2)) + l(4)*cos(q(2))*cos(q(3))*sin(q(4))) + dq(4)*cos(q(1))*(l(4)*cos(q(2))*sin(q(4)) + l(4)*cos(q(3))*cos(q(4))*sin(q(2))) - dq(3)*l(4)*cos(q(1))*sin(q(2))*sin(q(3))*sin(q(4)), dq(4)*l(4)*cos(q(4))*(cos(q(3))*sin(q(1)) + cos(q(1))*cos(q(2))*sin(q(3))) + dq(1)*l(4)*sin(q(4))*(cos(q(1))*cos(q(3)) - cos(q(2))*sin(q(1))*sin(q(3))) - dq(3)*l(4)*sin(q(4))*(sin(q(1))*sin(q(3)) - cos(q(1))*cos(q(2))*cos(q(3))) - dq(2)*l(4)*cos(q(1))*sin(q(2))*sin(q(3))*sin(q(4)), dq(4)*(cos(q(1))*(l(4)*cos(q(4))*sin(q(2)) + l(4)*cos(q(2))*cos(q(3))*sin(q(4))) - l(4)*sin(q(1))*sin(q(3))*sin(q(4))) + dq(3)*(l(4)*cos(q(3))*cos(q(4))*sin(q(1)) + l(4)*cos(q(1))*cos(q(2))*cos(q(4))*sin(q(3))) - dq(1)*(sin(q(1))*(l(4)*sin(q(2))*sin(q(4)) - l(4)*cos(q(2))*cos(q(3))*cos(q(4))) - l(4)*cos(q(1))*cos(q(4))*sin(q(3))) + dq(2)*cos(q(1))*(l(4)*cos(q(2))*sin(q(4)) + l(4)*cos(q(3))*cos(q(4))*sin(q(2))) ;
               dq(3)*(l(4)*cos(q(3))*sin(q(1))*sin(q(4)) + l(4)*cos(q(1))*cos(q(2))*sin(q(3))*sin(q(4))) + dq(1)*(sin(q(1))*(sin(q(2))*(l(3) + l(4)*cos(q(4))) + l(2)*sin(q(2)) + l(4)*cos(q(2))*cos(q(3))*sin(q(4))) + l(4)*cos(q(1))*sin(q(3))*sin(q(4))) + dq(4)*(cos(q(1))*(l(4)*sin(q(2))*sin(q(4)) - l(4)*cos(q(2))*cos(q(3))*cos(q(4))) + l(4)*cos(q(4))*sin(q(1))*sin(q(3))) - dq(2)*cos(q(1))*(cos(q(2))*(l(3) + l(4)*cos(q(4))) + l(2)*cos(q(2)) - l(4)*cos(q(3))*sin(q(2))*sin(q(4))), dq(2)*sin(q(1))*(sin(q(2))*(l(3) + l(4)*cos(q(4))) + l(2)*sin(q(2)) + l(4)*cos(q(2))*cos(q(3))*sin(q(4))) - dq(1)*cos(q(1))*(cos(q(2))*(l(3) + l(4)*cos(q(4))) + l(2)*cos(q(2)) - l(4)*cos(q(3))*sin(q(2))*sin(q(4))) + dq(4)*sin(q(1))*(l(4)*cos(q(2))*sin(q(4)) + l(4)*cos(q(3))*cos(q(4))*sin(q(2))) - dq(3)*l(4)*sin(q(1))*sin(q(2))*sin(q(3))*sin(q(4)), dq(1)*l(4)*sin(q(4))*(cos(q(3))*sin(q(1)) + cos(q(1))*cos(q(2))*sin(q(3))) - dq(4)*l(4)*cos(q(4))*(cos(q(1))*cos(q(3)) - cos(q(2))*sin(q(1))*sin(q(3))) + dq(3)*l(4)*sin(q(4))*(cos(q(1))*sin(q(3)) + cos(q(2))*cos(q(3))*sin(q(1))) - dq(2)*l(4)*sin(q(1))*sin(q(2))*sin(q(3))*sin(q(4)), dq(4)*(sin(q(1))*(l(4)*cos(q(4))*sin(q(2)) + l(4)*cos(q(2))*cos(q(3))*sin(q(4))) + l(4)*cos(q(1))*sin(q(3))*sin(q(4))) - dq(3)*(l(4)*cos(q(1))*cos(q(3))*cos(q(4)) - l(4)*cos(q(2))*cos(q(4))*sin(q(1))*sin(q(3))) + dq(1)*(cos(q(1))*(l(4)*sin(q(2))*sin(q(4)) - l(4)*cos(q(2))*cos(q(3))*cos(q(4))) + l(4)*cos(q(4))*sin(q(1))*sin(q(3))) + dq(2)*sin(q(1))*(l(4)*cos(q(2))*sin(q(4)) + l(4)*cos(q(3))*cos(q(4))*sin(q(2))) ;
               0,                                                                                                                                           dq(4)*(l(4)*sin(q(2))*sin(q(4)) - l(4)*cos(q(2))*cos(q(3))*cos(q(4))) - dq(2)*(cos(q(2))*(l(3) + l(4)*cos(q(4))) + l(2)*cos(q(2)) - l(4)*cos(q(3))*sin(q(2))*sin(q(4))) + dq(3)*l(4)*cos(q(2))*sin(q(3))*sin(q(4)),                                                                                                                                                            dq(2)*l(4)*cos(q(2))*sin(q(3))*sin(q(4)) + dq(3)*l(4)*cos(q(3))*sin(q(2))*sin(q(4)) + dq(4)*l(4)*cos(q(4))*sin(q(2))*sin(q(3)),                                                                                                                                                                                                                                      dq(2)*(l(4)*sin(q(2))*sin(q(4)) - l(4)*cos(q(2))*cos(q(3))*cos(q(4))) - dq(4)*(l(4)*cos(q(2))*cos(q(4)) - l(4)*cos(q(3))*sin(q(2))*sin(q(4))) + dq(3)*l(4)*cos(q(4))*sin(q(2))*sin(q(3)) ];



    case '3d_PRRR'
        % �����X���C�_���4�����N
        dJ = [ 0, dq(3)*sin(q(2))*(l(4)*cos(q(3) + q(4)) + l(3)*cos(q(3))) + dq(2)*cos(q(2))*(l(4)*sin(q(3) + q(4)) + l(3)*sin(q(3))) + dq(4)*l(4)*cos(q(3) + q(4))*sin(q(2)), dq(2)*sin(q(2))*(l(4)*cos(q(3) + q(4)) + l(3)*cos(q(3))) + dq(3)*cos(q(2))*(l(4)*sin(q(3) + q(4)) + l(3)*sin(q(3))) + dq(4)*l(4)*sin(q(3) + q(4))*cos(q(2)), dq(2)*l(4)*cos(q(3) + q(4))*sin(q(2)) + dq(3)*l(4)*sin(q(3) + q(4))*cos(q(2)) + dq(4)*l(4)*sin(q(3) + q(4))*cos(q(2)) ;
               0, dq(2)*sin(q(2))*(l(4)*sin(q(3) + q(4)) + l(3)*sin(q(3))) - dq(3)*cos(q(2))*(l(4)*cos(q(3) + q(4)) + l(3)*cos(q(3))) - dq(4)*l(4)*cos(q(3) + q(4))*cos(q(2)), dq(3)*sin(q(2))*(l(4)*sin(q(3) + q(4)) + l(3)*sin(q(3))) - dq(2)*cos(q(2))*(l(4)*cos(q(3) + q(4)) + l(3)*cos(q(3))) + dq(4)*l(4)*sin(q(3) + q(4))*sin(q(2)), dq(3)*l(4)*sin(q(3) + q(4))*sin(q(2)) - dq(2)*l(4)*cos(q(3) + q(4))*cos(q(2)) + dq(4)*l(4)*sin(q(3) + q(4))*sin(q(2)) ;
               0,                                                                                                                                                           0,                                                                              - dq(3)*(l(4)*cos(q(3) + q(4)) + l(3)*cos(q(3))) - dq(4)*l(4)*cos(q(3) + q(4)),                                                                                -l(4)*cos(q(3) + q(4))*(dq(3) + dq(4)) ];




    case '2d_RRR'
        % ����3�����N
        dJ = [ - dq(1)*(l(2)*cos(q(1) + q(2)) + l(1)*cos(q(1)) + cos(q(1) + q(2) + q(3))*l(3)) - dq(2)*(l(2)*cos(q(1) + q(2)) + cos(q(1) + q(2) + q(3))*l(3)) - cos(q(1) + q(2) + q(3))*dq(3)*l(3), - dq(1)*(l(2)*cos(q(1) + q(2)) + cos(q(1) + q(2) + q(3))*l(3)) - dq(2)*(l(2)*cos(q(1) + q(2)) + cos(q(1) + q(2) + q(3))*l(3)) - cos(q(1) + q(2) + q(3))*dq(3)*l(3), -cos(q(1) + q(2) + q(3))*l(3)*(dq(1) + dq(2) + dq(3)) ;
               - dq(1)*(l(2)*sin(q(1) + q(2)) + l(1)*sin(q(1)) + sin(q(1) + q(2) + q(3))*l(3)) - dq(2)*(l(2)*sin(q(1) + q(2)) + sin(q(1) + q(2) + q(3))*l(3)) - sin(q(1) + q(2) + q(3))*dq(3)*l(3), - dq(1)*(l(2)*sin(q(1) + q(2)) + sin(q(1) + q(2) + q(3))*l(3)) - dq(2)*(l(2)*sin(q(1) + q(2)) + sin(q(1) + q(2) + q(3))*l(3)) - sin(q(1) + q(2) + q(3))*dq(3)*l(3), -sin(q(1) + q(2) + q(3))*l(3)*(dq(1) + dq(2) + dq(3)) ];
        
        


    case '2d_RRRR'
        % ����4�����N
        dJ = [ - dq(3)*(l(4)*cos(q(1) + q(2) + q(3) + q(4)) + cos(q(1) + q(2) + q(3))*l(3)) - dq(1)*(l(4)*cos(q(1) + q(2) + q(3) + q(4)) + l(2)*cos(q(1) + q(2)) + l(1)*cos(q(1)) + cos(q(1) + q(2) + q(3))*l(3)) - dq(2)*(l(4)*cos(q(1) + q(2) + q(3) + q(4)) + l(2)*cos(q(1) + q(2)) + cos(q(1) + q(2) + q(3))*l(3)) - dq(4)*l(4)*cos(q(1) + q(2) + q(3) + q(4)), - dq(3)*(l(4)*cos(q(1) + q(2) + q(3) + q(4)) + cos(q(1) + q(2) + q(3))*l(3)) - dq(1)*(l(4)*cos(q(1) + q(2) + q(3) + q(4)) + l(2)*cos(q(1) + q(2)) + cos(q(1) + q(2) + q(3))*l(3)) - dq(2)*(l(4)*cos(q(1) + q(2) + q(3) + q(4)) + l(2)*cos(q(1) + q(2)) + cos(q(1) + q(2) + q(3))*l(3)) - dq(4)*l(4)*cos(q(1) + q(2) + q(3) + q(4)), - dq(1)*(l(4)*cos(q(1) + q(2) + q(3) + q(4)) + cos(q(1) + q(2) + q(3))*l(3)) - dq(2)*(l(4)*cos(q(1) + q(2) + q(3) + q(4)) + cos(q(1) + q(2) + q(3))*l(3)) - dq(3)*(l(4)*cos(q(1) + q(2) + q(3) + q(4)) + cos(q(1) + q(2) + q(3))*l(3)) - dq(4)*l(4)*cos(q(1) + q(2) + q(3) + q(4)), -l(4)*cos(q(1) + q(2) + q(3) + q(4))*(dq(1) + dq(2) + dq(3) + dq(4)) ;
               - dq(3)*(l(4)*sin(q(1) + q(2) + q(3) + q(4)) + sin(q(1) + q(2) + q(3))*l(3)) - dq(1)*(l(4)*sin(q(1) + q(2) + q(3) + q(4)) + l(2)*sin(q(1) + q(2)) + l(1)*sin(q(1)) + sin(q(1) + q(2) + q(3))*l(3)) - dq(2)*(l(4)*sin(q(1) + q(2) + q(3) + q(4)) + l(2)*sin(q(1) + q(2)) + sin(q(1) + q(2) + q(3))*l(3)) - dq(4)*l(4)*sin(q(1) + q(2) + q(3) + q(4)), - dq(3)*(l(4)*sin(q(1) + q(2) + q(3) + q(4)) + sin(q(1) + q(2) + q(3))*l(3)) - dq(1)*(l(4)*sin(q(1) + q(2) + q(3) + q(4)) + l(2)*sin(q(1) + q(2)) + sin(q(1) + q(2) + q(3))*l(3)) - dq(2)*(l(4)*sin(q(1) + q(2) + q(3) + q(4)) + l(2)*sin(q(1) + q(2)) + sin(q(1) + q(2) + q(3))*l(3)) - dq(4)*l(4)*sin(q(1) + q(2) + q(3) + q(4)), - dq(1)*(l(4)*sin(q(1) + q(2) + q(3) + q(4)) + sin(q(1) + q(2) + q(3))*l(3)) - dq(2)*(l(4)*sin(q(1) + q(2) + q(3) + q(4)) + sin(q(1) + q(2) + q(3))*l(3)) - dq(3)*(l(4)*sin(q(1) + q(2) + q(3) + q(4)) + sin(q(1) + q(2) + q(3))*l(3)) - dq(4)*l(4)*sin(q(1) + q(2) + q(3) + q(4)), -l(4)*sin(q(1) + q(2) + q(3) + q(4))*(dq(1) + dq(2) + dq(3) + dq(4)) ;
               0,  0,  0,  0 ];





    case '2d_RRRP'
        % ����4�֐߁@�����i0-0-0-=<�j
        dJ = [ - dq(2)*(l(2)*cos(q(1) + q(2)) + cos(q(1) + q(2) + q(3))*(l(4) + q(4)) + cos(q(1) + q(2) + q(3))*l(3)) - dq(1)*(l(2)*cos(q(1) + q(2)) + l(1)*cos(q(1)) + cos(q(1) + q(2) + q(3))*(l(4) + q(4)) + cos(q(1) + q(2) + q(3))*l(3)) - sin(q(1) + q(2) + q(3))*dq(4) - cos(q(1) + q(2) + q(3))*dq(3)*(l(3) + l(4) + q(4)), - dq(1)*(l(2)*cos(q(1) + q(2)) + cos(q(1) + q(2) + q(3))*(l(4) + q(4)) + cos(q(1) + q(2) + q(3))*l(3)) - dq(2)*(l(2)*cos(q(1) + q(2)) + cos(q(1) + q(2) + q(3))*(l(4) + q(4)) + cos(q(1) + q(2) + q(3))*l(3)) - sin(q(1) + q(2) + q(3))*dq(4) - cos(q(1) + q(2) + q(3))*dq(3)*(l(3) + l(4) + q(4)), - sin(q(1) + q(2) + q(3))*dq(4) - cos(q(1) + q(2) + q(3))*dq(1)*(l(3) + l(4) + q(4)) - cos(q(1) + q(2) + q(3))*dq(2)*(l(3) + l(4) + q(4)) - cos(q(1) + q(2) + q(3))*dq(3)*(l(3) + l(4) + q(4)), -sin(q(1) + q(2) + q(3))*(dq(1) + dq(2) + dq(3));
                 cos(q(1) + q(2) + q(3))*dq(4) - dq(2)*(l(2)*sin(q(1) + q(2)) + sin(q(1) + q(2) + q(3))*(l(4) + q(4)) + sin(q(1) + q(2) + q(3))*l(3)) - dq(1)*(l(2)*sin(q(1) + q(2)) + l(1)*sin(q(1)) + sin(q(1) + q(2) + q(3))*(l(4) + q(4)) + sin(q(1) + q(2) + q(3))*l(3)) - sin(q(1) + q(2) + q(3))*dq(3)*(l(3) + l(4) + q(4)),   cos(q(1) + q(2) + q(3))*dq(4) - dq(2)*(l(2)*sin(q(1) + q(2)) + sin(q(1) + q(2) + q(3))*(l(4) + q(4)) + sin(q(1) + q(2) + q(3))*l(3)) - dq(1)*(l(2)*sin(q(1) + q(2)) + sin(q(1) + q(2) + q(3))*(l(4) + q(4)) + sin(q(1) + q(2) + q(3))*l(3)) - sin(q(1) + q(2) + q(3))*dq(3)*(l(3) + l(4) + q(4)),   cos(q(1) + q(2) + q(3))*dq(4) - sin(q(1) + q(2) + q(3))*dq(1)*(l(3) + l(4) + q(4)) - sin(q(1) + q(2) + q(3))*dq(2)*(l(3) + l(4) + q(4)) - sin(q(1) + q(2) + q(3))*dq(3)*(l(3) + l(4) + q(4)),  cos(q(1) + q(2) + q(3))*(dq(1) + dq(2) + dq(3));
                 0,                                                                                                                                                                                                                                                                                                  0,                                                                                                                                                                                              0,                                                0];





    case '2d_RRP'
        % ����3�֐߁@�����i0-0-=<�j
        dJ = [ - dq(1)*(l(1)*cos(q(1)) + cos(q(1) + q(2))*(l(2) + l(3) + q(3))) - dq(3)*sin(q(1) + q(2)) - dq(2)*cos(q(1) + q(2))*(l(2) + l(3) + q(3)), - dq(3)*sin(q(1) + q(2)) - dq(1)*cos(q(1) + q(2))*(l(2) + l(3) + q(3)) - dq(2)*cos(q(1) + q(2))*(l(2) + l(3) + q(3)), -sin(q(1) + q(2))*(dq(1) + dq(2)) ;
                 dq(3)*cos(q(1) + q(2)) - dq(1)*(l(1)*sin(q(1)) + sin(q(1) + q(2))*(l(2) + l(3) + q(3))) - dq(2)*sin(q(1) + q(2))*(l(2) + l(3) + q(3)),   dq(3)*cos(q(1) + q(2)) - dq(1)*sin(q(1) + q(2))*(l(2) + l(3) + q(3)) - dq(2)*sin(q(1) + q(2))*(l(2) + l(3) + q(3)),  cos(q(1) + q(2))*(dq(1) + dq(2)) ];


    otherwise
        err('error f3L_Jacobi_plus');
        
end

end
