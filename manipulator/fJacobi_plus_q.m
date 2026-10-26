function[J,Jp,dJ,U,err] = fJacobi_plus_q(type, q,dq)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   [J,Jp,dJ,U,err] = fJacobi_plus_q(type, q,dq)
%
%       r   : 手先位置　r=[x,y]'
%       eta : 冗長姿勢
%       z   : 内部運動速度
%
%       J   : ヤコビ行列
%       Jp  : ヤコビ行列の疑似逆行列
%       dJ  : ヤコビ行列の時間微分
%       U   : ヤコビ行列の正規化直交基底
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

param = get_parameter(type);
    Link = param.Link;
    l = param.l;

[J,Jp,U,error] = fJacobi_q(type,q);

% [J,Jp,U,error] = fJacobi(r,eta);
% [q, err] = fIKinematics(r(:,1),eta(:,1));
% dq = Jp*dr + U*z;


switch type

    case '3d_RRRR'
        % 空間4リンク　Z-Y-Z-Y
        dJ = [ dq(3)*(l(4)*cos(q(1))*cos(q(3))*sin(q(4)) - l(4)*cos(q(2))*sin(q(1))*sin(q(3))*sin(q(4))) + dq(1)*(cos(q(1))*(sin(q(2))*(l(3) + l(4)*cos(q(4))) + l(2)*sin(q(2)) + l(4)*cos(q(2))*cos(q(3))*sin(q(4))) - l(4)*sin(q(1))*sin(q(3))*sin(q(4))) - dq(4)*(sin(q(1))*(l(4)*sin(q(2))*sin(q(4)) - l(4)*cos(q(2))*cos(q(3))*cos(q(4))) - l(4)*cos(q(1))*cos(q(4))*sin(q(3))) + dq(2)*sin(q(1))*(cos(q(2))*(l(3) + l(4)*cos(q(4))) + l(2)*cos(q(2)) - l(4)*cos(q(3))*sin(q(2))*sin(q(4))), dq(1)*sin(q(1))*(cos(q(2))*(l(3) + l(4)*cos(q(4))) + l(2)*cos(q(2)) - l(4)*cos(q(3))*sin(q(2))*sin(q(4))) + dq(2)*cos(q(1))*(sin(q(2))*(l(3) + l(4)*cos(q(4))) + l(2)*sin(q(2)) + l(4)*cos(q(2))*cos(q(3))*sin(q(4))) + dq(4)*cos(q(1))*(l(4)*cos(q(2))*sin(q(4)) + l(4)*cos(q(3))*cos(q(4))*sin(q(2))) - dq(3)*l(4)*cos(q(1))*sin(q(2))*sin(q(3))*sin(q(4)), dq(4)*l(4)*cos(q(4))*(cos(q(3))*sin(q(1)) + cos(q(1))*cos(q(2))*sin(q(3))) + dq(1)*l(4)*sin(q(4))*(cos(q(1))*cos(q(3)) - cos(q(2))*sin(q(1))*sin(q(3))) - dq(3)*l(4)*sin(q(4))*(sin(q(1))*sin(q(3)) - cos(q(1))*cos(q(2))*cos(q(3))) - dq(2)*l(4)*cos(q(1))*sin(q(2))*sin(q(3))*sin(q(4)), dq(4)*(cos(q(1))*(l(4)*cos(q(4))*sin(q(2)) + l(4)*cos(q(2))*cos(q(3))*sin(q(4))) - l(4)*sin(q(1))*sin(q(3))*sin(q(4))) + dq(3)*(l(4)*cos(q(3))*cos(q(4))*sin(q(1)) + l(4)*cos(q(1))*cos(q(2))*cos(q(4))*sin(q(3))) - dq(1)*(sin(q(1))*(l(4)*sin(q(2))*sin(q(4)) - l(4)*cos(q(2))*cos(q(3))*cos(q(4))) - l(4)*cos(q(1))*cos(q(4))*sin(q(3))) + dq(2)*cos(q(1))*(l(4)*cos(q(2))*sin(q(4)) + l(4)*cos(q(3))*cos(q(4))*sin(q(2))) ;
               dq(3)*(l(4)*cos(q(3))*sin(q(1))*sin(q(4)) + l(4)*cos(q(1))*cos(q(2))*sin(q(3))*sin(q(4))) + dq(1)*(sin(q(1))*(sin(q(2))*(l(3) + l(4)*cos(q(4))) + l(2)*sin(q(2)) + l(4)*cos(q(2))*cos(q(3))*sin(q(4))) + l(4)*cos(q(1))*sin(q(3))*sin(q(4))) + dq(4)*(cos(q(1))*(l(4)*sin(q(2))*sin(q(4)) - l(4)*cos(q(2))*cos(q(3))*cos(q(4))) + l(4)*cos(q(4))*sin(q(1))*sin(q(3))) - dq(2)*cos(q(1))*(cos(q(2))*(l(3) + l(4)*cos(q(4))) + l(2)*cos(q(2)) - l(4)*cos(q(3))*sin(q(2))*sin(q(4))), dq(2)*sin(q(1))*(sin(q(2))*(l(3) + l(4)*cos(q(4))) + l(2)*sin(q(2)) + l(4)*cos(q(2))*cos(q(3))*sin(q(4))) - dq(1)*cos(q(1))*(cos(q(2))*(l(3) + l(4)*cos(q(4))) + l(2)*cos(q(2)) - l(4)*cos(q(3))*sin(q(2))*sin(q(4))) + dq(4)*sin(q(1))*(l(4)*cos(q(2))*sin(q(4)) + l(4)*cos(q(3))*cos(q(4))*sin(q(2))) - dq(3)*l(4)*sin(q(1))*sin(q(2))*sin(q(3))*sin(q(4)), dq(1)*l(4)*sin(q(4))*(cos(q(3))*sin(q(1)) + cos(q(1))*cos(q(2))*sin(q(3))) - dq(4)*l(4)*cos(q(4))*(cos(q(1))*cos(q(3)) - cos(q(2))*sin(q(1))*sin(q(3))) + dq(3)*l(4)*sin(q(4))*(cos(q(1))*sin(q(3)) + cos(q(2))*cos(q(3))*sin(q(1))) - dq(2)*l(4)*sin(q(1))*sin(q(2))*sin(q(3))*sin(q(4)), dq(4)*(sin(q(1))*(l(4)*cos(q(4))*sin(q(2)) + l(4)*cos(q(2))*cos(q(3))*sin(q(4))) + l(4)*cos(q(1))*sin(q(3))*sin(q(4))) - dq(3)*(l(4)*cos(q(1))*cos(q(3))*cos(q(4)) - l(4)*cos(q(2))*cos(q(4))*sin(q(1))*sin(q(3))) + dq(1)*(cos(q(1))*(l(4)*sin(q(2))*sin(q(4)) - l(4)*cos(q(2))*cos(q(3))*cos(q(4))) + l(4)*cos(q(4))*sin(q(1))*sin(q(3))) + dq(2)*sin(q(1))*(l(4)*cos(q(2))*sin(q(4)) + l(4)*cos(q(3))*cos(q(4))*sin(q(2))) ;
               0,                                                                                                                                           dq(4)*(l(4)*sin(q(2))*sin(q(4)) - l(4)*cos(q(2))*cos(q(3))*cos(q(4))) - dq(2)*(cos(q(2))*(l(3) + l(4)*cos(q(4))) + l(2)*cos(q(2)) - l(4)*cos(q(3))*sin(q(2))*sin(q(4))) + dq(3)*l(4)*cos(q(2))*sin(q(3))*sin(q(4)),                                                                                                                                                            dq(2)*l(4)*cos(q(2))*sin(q(3))*sin(q(4)) + dq(3)*l(4)*cos(q(3))*sin(q(2))*sin(q(4)) + dq(4)*l(4)*cos(q(4))*sin(q(2))*sin(q(3)),                                                                                                                                                                                                                                      dq(2)*(l(4)*sin(q(2))*sin(q(4)) - l(4)*cos(q(2))*cos(q(3))*cos(q(4))) - dq(4)*(l(4)*cos(q(2))*cos(q(4)) - l(4)*cos(q(3))*sin(q(2))*sin(q(4))) + dq(3)*l(4)*cos(q(4))*sin(q(2))*sin(q(3)) ];



    case '3d_PRRR'
        % 直動スライダ空間4リンク
        dJ = [ 0, dq(3)*sin(q(2))*(l(4)*cos(q(3) + q(4)) + l(3)*cos(q(3))) + dq(2)*cos(q(2))*(l(4)*sin(q(3) + q(4)) + l(3)*sin(q(3))) + dq(4)*l(4)*cos(q(3) + q(4))*sin(q(2)), dq(2)*sin(q(2))*(l(4)*cos(q(3) + q(4)) + l(3)*cos(q(3))) + dq(3)*cos(q(2))*(l(4)*sin(q(3) + q(4)) + l(3)*sin(q(3))) + dq(4)*l(4)*sin(q(3) + q(4))*cos(q(2)), dq(2)*l(4)*cos(q(3) + q(4))*sin(q(2)) + dq(3)*l(4)*sin(q(3) + q(4))*cos(q(2)) + dq(4)*l(4)*sin(q(3) + q(4))*cos(q(2)) ;
               0, dq(2)*sin(q(2))*(l(4)*sin(q(3) + q(4)) + l(3)*sin(q(3))) - dq(3)*cos(q(2))*(l(4)*cos(q(3) + q(4)) + l(3)*cos(q(3))) - dq(4)*l(4)*cos(q(3) + q(4))*cos(q(2)), dq(3)*sin(q(2))*(l(4)*sin(q(3) + q(4)) + l(3)*sin(q(3))) - dq(2)*cos(q(2))*(l(4)*cos(q(3) + q(4)) + l(3)*cos(q(3))) + dq(4)*l(4)*sin(q(3) + q(4))*sin(q(2)), dq(3)*l(4)*sin(q(3) + q(4))*sin(q(2)) - dq(2)*l(4)*cos(q(3) + q(4))*cos(q(2)) + dq(4)*l(4)*sin(q(3) + q(4))*sin(q(2)) ;
               0,                                                                                                                                                           0,                                                                              - dq(3)*(l(4)*cos(q(3) + q(4)) + l(3)*cos(q(3))) - dq(4)*l(4)*cos(q(3) + q(4)),                                                                                -l(4)*cos(q(3) + q(4))*(dq(3) + dq(4)) ];




    case {'2d_RRR', 'C03160'}
        % 平面3リンク
        dJ = [ - dq(1)*(l(2)*cos(q(1) + q(2)) + l(1)*cos(q(1)) + cos(q(1) + q(2) + q(3))*l(3)) - dq(2)*(l(2)*cos(q(1) + q(2)) + cos(q(1) + q(2) + q(3))*l(3)) - cos(q(1) + q(2) + q(3))*dq(3)*l(3), - dq(1)*(l(2)*cos(q(1) + q(2)) + cos(q(1) + q(2) + q(3))*l(3)) - dq(2)*(l(2)*cos(q(1) + q(2)) + cos(q(1) + q(2) + q(3))*l(3)) - cos(q(1) + q(2) + q(3))*dq(3)*l(3), -cos(q(1) + q(2) + q(3))*l(3)*(dq(1) + dq(2) + dq(3)) ;
               - dq(1)*(l(2)*sin(q(1) + q(2)) + l(1)*sin(q(1)) + sin(q(1) + q(2) + q(3))*l(3)) - dq(2)*(l(2)*sin(q(1) + q(2)) + sin(q(1) + q(2) + q(3))*l(3)) - sin(q(1) + q(2) + q(3))*dq(3)*l(3), - dq(1)*(l(2)*sin(q(1) + q(2)) + sin(q(1) + q(2) + q(3))*l(3)) - dq(2)*(l(2)*sin(q(1) + q(2)) + sin(q(1) + q(2) + q(3))*l(3)) - sin(q(1) + q(2) + q(3))*dq(3)*l(3), -sin(q(1) + q(2) + q(3))*l(3)*(dq(1) + dq(2) + dq(3)) ];
        
        


    case '2d_RRRR'
        % 平面4リンク
        dJ = [ - dq(3)*(l(4)*cos(q(1) + q(2) + q(3) + q(4)) + cos(q(1) + q(2) + q(3))*l(3)) - dq(1)*(l(4)*cos(q(1) + q(2) + q(3) + q(4)) + l(2)*cos(q(1) + q(2)) + l(1)*cos(q(1)) + cos(q(1) + q(2) + q(3))*l(3)) - dq(2)*(l(4)*cos(q(1) + q(2) + q(3) + q(4)) + l(2)*cos(q(1) + q(2)) + cos(q(1) + q(2) + q(3))*l(3)) - dq(4)*l(4)*cos(q(1) + q(2) + q(3) + q(4)), - dq(3)*(l(4)*cos(q(1) + q(2) + q(3) + q(4)) + cos(q(1) + q(2) + q(3))*l(3)) - dq(1)*(l(4)*cos(q(1) + q(2) + q(3) + q(4)) + l(2)*cos(q(1) + q(2)) + cos(q(1) + q(2) + q(3))*l(3)) - dq(2)*(l(4)*cos(q(1) + q(2) + q(3) + q(4)) + l(2)*cos(q(1) + q(2)) + cos(q(1) + q(2) + q(3))*l(3)) - dq(4)*l(4)*cos(q(1) + q(2) + q(3) + q(4)), - dq(1)*(l(4)*cos(q(1) + q(2) + q(3) + q(4)) + cos(q(1) + q(2) + q(3))*l(3)) - dq(2)*(l(4)*cos(q(1) + q(2) + q(3) + q(4)) + cos(q(1) + q(2) + q(3))*l(3)) - dq(3)*(l(4)*cos(q(1) + q(2) + q(3) + q(4)) + cos(q(1) + q(2) + q(3))*l(3)) - dq(4)*l(4)*cos(q(1) + q(2) + q(3) + q(4)), -l(4)*cos(q(1) + q(2) + q(3) + q(4))*(dq(1) + dq(2) + dq(3) + dq(4)) ;
               - dq(3)*(l(4)*sin(q(1) + q(2) + q(3) + q(4)) + sin(q(1) + q(2) + q(3))*l(3)) - dq(1)*(l(4)*sin(q(1) + q(2) + q(3) + q(4)) + l(2)*sin(q(1) + q(2)) + l(1)*sin(q(1)) + sin(q(1) + q(2) + q(3))*l(3)) - dq(2)*(l(4)*sin(q(1) + q(2) + q(3) + q(4)) + l(2)*sin(q(1) + q(2)) + sin(q(1) + q(2) + q(3))*l(3)) - dq(4)*l(4)*sin(q(1) + q(2) + q(3) + q(4)), - dq(3)*(l(4)*sin(q(1) + q(2) + q(3) + q(4)) + sin(q(1) + q(2) + q(3))*l(3)) - dq(1)*(l(4)*sin(q(1) + q(2) + q(3) + q(4)) + l(2)*sin(q(1) + q(2)) + sin(q(1) + q(2) + q(3))*l(3)) - dq(2)*(l(4)*sin(q(1) + q(2) + q(3) + q(4)) + l(2)*sin(q(1) + q(2)) + sin(q(1) + q(2) + q(3))*l(3)) - dq(4)*l(4)*sin(q(1) + q(2) + q(3) + q(4)), - dq(1)*(l(4)*sin(q(1) + q(2) + q(3) + q(4)) + sin(q(1) + q(2) + q(3))*l(3)) - dq(2)*(l(4)*sin(q(1) + q(2) + q(3) + q(4)) + sin(q(1) + q(2) + q(3))*l(3)) - dq(3)*(l(4)*sin(q(1) + q(2) + q(3) + q(4)) + sin(q(1) + q(2) + q(3))*l(3)) - dq(4)*l(4)*sin(q(1) + q(2) + q(3) + q(4)), -l(4)*sin(q(1) + q(2) + q(3) + q(4))*(dq(1) + dq(2) + dq(3) + dq(4)) ;
               0,  0,  0,  0 ];





    case '2d_RRRP'
        % 平面4関節　直動（0-0-0-=<）
        dJ = [ - dq(2)*(l(2)*cos(q(1) + q(2)) + cos(q(1) + q(2) + q(3))*(l(4) + q(4)) + cos(q(1) + q(2) + q(3))*l(3)) - dq(1)*(l(2)*cos(q(1) + q(2)) + l(1)*cos(q(1)) + cos(q(1) + q(2) + q(3))*(l(4) + q(4)) + cos(q(1) + q(2) + q(3))*l(3)) - sin(q(1) + q(2) + q(3))*dq(4) - cos(q(1) + q(2) + q(3))*dq(3)*(l(3) + l(4) + q(4)), - dq(1)*(l(2)*cos(q(1) + q(2)) + cos(q(1) + q(2) + q(3))*(l(4) + q(4)) + cos(q(1) + q(2) + q(3))*l(3)) - dq(2)*(l(2)*cos(q(1) + q(2)) + cos(q(1) + q(2) + q(3))*(l(4) + q(4)) + cos(q(1) + q(2) + q(3))*l(3)) - sin(q(1) + q(2) + q(3))*dq(4) - cos(q(1) + q(2) + q(3))*dq(3)*(l(3) + l(4) + q(4)), - sin(q(1) + q(2) + q(3))*dq(4) - cos(q(1) + q(2) + q(3))*dq(1)*(l(3) + l(4) + q(4)) - cos(q(1) + q(2) + q(3))*dq(2)*(l(3) + l(4) + q(4)) - cos(q(1) + q(2) + q(3))*dq(3)*(l(3) + l(4) + q(4)), -sin(q(1) + q(2) + q(3))*(dq(1) + dq(2) + dq(3));
                 cos(q(1) + q(2) + q(3))*dq(4) - dq(2)*(l(2)*sin(q(1) + q(2)) + sin(q(1) + q(2) + q(3))*(l(4) + q(4)) + sin(q(1) + q(2) + q(3))*l(3)) - dq(1)*(l(2)*sin(q(1) + q(2)) + l(1)*sin(q(1)) + sin(q(1) + q(2) + q(3))*(l(4) + q(4)) + sin(q(1) + q(2) + q(3))*l(3)) - sin(q(1) + q(2) + q(3))*dq(3)*(l(3) + l(4) + q(4)),   cos(q(1) + q(2) + q(3))*dq(4) - dq(2)*(l(2)*sin(q(1) + q(2)) + sin(q(1) + q(2) + q(3))*(l(4) + q(4)) + sin(q(1) + q(2) + q(3))*l(3)) - dq(1)*(l(2)*sin(q(1) + q(2)) + sin(q(1) + q(2) + q(3))*(l(4) + q(4)) + sin(q(1) + q(2) + q(3))*l(3)) - sin(q(1) + q(2) + q(3))*dq(3)*(l(3) + l(4) + q(4)),   cos(q(1) + q(2) + q(3))*dq(4) - sin(q(1) + q(2) + q(3))*dq(1)*(l(3) + l(4) + q(4)) - sin(q(1) + q(2) + q(3))*dq(2)*(l(3) + l(4) + q(4)) - sin(q(1) + q(2) + q(3))*dq(3)*(l(3) + l(4) + q(4)),  cos(q(1) + q(2) + q(3))*(dq(1) + dq(2) + dq(3));
                 0,                                                                                                                                                                                                                                                                                                  0,                                                                                                                                                                                              0,                                                0];





    case '2d_RRP'
        % 平面3関節　直動（0-0-=<）
        dJ = [ - dq(1)*(l(1)*cos(q(1)) + cos(q(1) + q(2))*(l(2) + l(3) + q(3))) - dq(3)*sin(q(1) + q(2)) - dq(2)*cos(q(1) + q(2))*(l(2) + l(3) + q(3)), - dq(3)*sin(q(1) + q(2)) - dq(1)*cos(q(1) + q(2))*(l(2) + l(3) + q(3)) - dq(2)*cos(q(1) + q(2))*(l(2) + l(3) + q(3)), -sin(q(1) + q(2))*(dq(1) + dq(2)) ;
                 dq(3)*cos(q(1) + q(2)) - dq(1)*(l(1)*sin(q(1)) + sin(q(1) + q(2))*(l(2) + l(3) + q(3))) - dq(2)*sin(q(1) + q(2))*(l(2) + l(3) + q(3)),   dq(3)*cos(q(1) + q(2)) - dq(1)*sin(q(1) + q(2))*(l(2) + l(3) + q(3)) - dq(2)*sin(q(1) + q(2))*(l(2) + l(3) + q(3)),  cos(q(1) + q(2))*(dq(1) + dq(2)) ];


    otherwise
        err('error f3L_Jacobi_plus');
        
end

end
