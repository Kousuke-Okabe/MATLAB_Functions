function[J,Jd] = fJacobi_tensor_minus_q(type, q)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   [J,Jd] = fJacobi_tensor_minus_q(type, q)
%       q   : 関節角度
%
%       J   : ヤコビ行列
%       Jd  : ヤコビ行列のqベクトル微分
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

draw = 0;

% %%
% clear
% 
% type = 'C03160'
% 
% q = [
%     pi/3;
%     -pi/6;
%     pi/4
%     ];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

err = 0;

check = size(q,2);
if check ~= 1
    disp('error : f3L_Jacobi_plus input')
    
    err = 1;
    return;
end

param = get_parameter(type);
    Link = param.Link;
    l = param.l;

[J,~] = fJacobi_minus_q(type,q);

switch type

%     case '3d_RRRR'
%         % 空間4リンク　Z-Y-Z-Y
%         dJ = [ dq(3)*(l(4)*cos(q(1))*cos(q(3))*sin(q(4)) - l(4)*cos(q(2))*sin(q(1))*sin(q(3))*sin(q(4))) + dq(1)*(cos(q(1))*(sin(q(2))*(l(3) + l(4)*cos(q(4))) + l(2)*sin(q(2)) + l(4)*cos(q(2))*cos(q(3))*sin(q(4))) - l(4)*sin(q(1))*sin(q(3))*sin(q(4))) - dq(4)*(sin(q(1))*(l(4)*sin(q(2))*sin(q(4)) - l(4)*cos(q(2))*cos(q(3))*cos(q(4))) - l(4)*cos(q(1))*cos(q(4))*sin(q(3))) + dq(2)*sin(q(1))*(cos(q(2))*(l(3) + l(4)*cos(q(4))) + l(2)*cos(q(2)) - l(4)*cos(q(3))*sin(q(2))*sin(q(4))), dq(1)*sin(q(1))*(cos(q(2))*(l(3) + l(4)*cos(q(4))) + l(2)*cos(q(2)) - l(4)*cos(q(3))*sin(q(2))*sin(q(4))) + dq(2)*cos(q(1))*(sin(q(2))*(l(3) + l(4)*cos(q(4))) + l(2)*sin(q(2)) + l(4)*cos(q(2))*cos(q(3))*sin(q(4))) + dq(4)*cos(q(1))*(l(4)*cos(q(2))*sin(q(4)) + l(4)*cos(q(3))*cos(q(4))*sin(q(2))) - dq(3)*l(4)*cos(q(1))*sin(q(2))*sin(q(3))*sin(q(4)), dq(4)*l(4)*cos(q(4))*(cos(q(3))*sin(q(1)) + cos(q(1))*cos(q(2))*sin(q(3))) + dq(1)*l(4)*sin(q(4))*(cos(q(1))*cos(q(3)) - cos(q(2))*sin(q(1))*sin(q(3))) - dq(3)*l(4)*sin(q(4))*(sin(q(1))*sin(q(3)) - cos(q(1))*cos(q(2))*cos(q(3))) - dq(2)*l(4)*cos(q(1))*sin(q(2))*sin(q(3))*sin(q(4)), dq(4)*(cos(q(1))*(l(4)*cos(q(4))*sin(q(2)) + l(4)*cos(q(2))*cos(q(3))*sin(q(4))) - l(4)*sin(q(1))*sin(q(3))*sin(q(4))) + dq(3)*(l(4)*cos(q(3))*cos(q(4))*sin(q(1)) + l(4)*cos(q(1))*cos(q(2))*cos(q(4))*sin(q(3))) - dq(1)*(sin(q(1))*(l(4)*sin(q(2))*sin(q(4)) - l(4)*cos(q(2))*cos(q(3))*cos(q(4))) - l(4)*cos(q(1))*cos(q(4))*sin(q(3))) + dq(2)*cos(q(1))*(l(4)*cos(q(2))*sin(q(4)) + l(4)*cos(q(3))*cos(q(4))*sin(q(2))) ;
%                dq(3)*(l(4)*cos(q(3))*sin(q(1))*sin(q(4)) + l(4)*cos(q(1))*cos(q(2))*sin(q(3))*sin(q(4))) + dq(1)*(sin(q(1))*(sin(q(2))*(l(3) + l(4)*cos(q(4))) + l(2)*sin(q(2)) + l(4)*cos(q(2))*cos(q(3))*sin(q(4))) + l(4)*cos(q(1))*sin(q(3))*sin(q(4))) + dq(4)*(cos(q(1))*(l(4)*sin(q(2))*sin(q(4)) - l(4)*cos(q(2))*cos(q(3))*cos(q(4))) + l(4)*cos(q(4))*sin(q(1))*sin(q(3))) - dq(2)*cos(q(1))*(cos(q(2))*(l(3) + l(4)*cos(q(4))) + l(2)*cos(q(2)) - l(4)*cos(q(3))*sin(q(2))*sin(q(4))), dq(2)*sin(q(1))*(sin(q(2))*(l(3) + l(4)*cos(q(4))) + l(2)*sin(q(2)) + l(4)*cos(q(2))*cos(q(3))*sin(q(4))) - dq(1)*cos(q(1))*(cos(q(2))*(l(3) + l(4)*cos(q(4))) + l(2)*cos(q(2)) - l(4)*cos(q(3))*sin(q(2))*sin(q(4))) + dq(4)*sin(q(1))*(l(4)*cos(q(2))*sin(q(4)) + l(4)*cos(q(3))*cos(q(4))*sin(q(2))) - dq(3)*l(4)*sin(q(1))*sin(q(2))*sin(q(3))*sin(q(4)), dq(1)*l(4)*sin(q(4))*(cos(q(3))*sin(q(1)) + cos(q(1))*cos(q(2))*sin(q(3))) - dq(4)*l(4)*cos(q(4))*(cos(q(1))*cos(q(3)) - cos(q(2))*sin(q(1))*sin(q(3))) + dq(3)*l(4)*sin(q(4))*(cos(q(1))*sin(q(3)) + cos(q(2))*cos(q(3))*sin(q(1))) - dq(2)*l(4)*sin(q(1))*sin(q(2))*sin(q(3))*sin(q(4)), dq(4)*(sin(q(1))*(l(4)*cos(q(4))*sin(q(2)) + l(4)*cos(q(2))*cos(q(3))*sin(q(4))) + l(4)*cos(q(1))*sin(q(3))*sin(q(4))) - dq(3)*(l(4)*cos(q(1))*cos(q(3))*cos(q(4)) - l(4)*cos(q(2))*cos(q(4))*sin(q(1))*sin(q(3))) + dq(1)*(cos(q(1))*(l(4)*sin(q(2))*sin(q(4)) - l(4)*cos(q(2))*cos(q(3))*cos(q(4))) + l(4)*cos(q(4))*sin(q(1))*sin(q(3))) + dq(2)*sin(q(1))*(l(4)*cos(q(2))*sin(q(4)) + l(4)*cos(q(3))*cos(q(4))*sin(q(2))) ;
%                0,                                                                                                                                           dq(4)*(l(4)*sin(q(2))*sin(q(4)) - l(4)*cos(q(2))*cos(q(3))*cos(q(4))) - dq(2)*(cos(q(2))*(l(3) + l(4)*cos(q(4))) + l(2)*cos(q(2)) - l(4)*cos(q(3))*sin(q(2))*sin(q(4))) + dq(3)*l(4)*cos(q(2))*sin(q(3))*sin(q(4)),                                                                                                                                                            dq(2)*l(4)*cos(q(2))*sin(q(3))*sin(q(4)) + dq(3)*l(4)*cos(q(3))*sin(q(2))*sin(q(4)) + dq(4)*l(4)*cos(q(4))*sin(q(2))*sin(q(3)),                                                                                                                                                                                                                                      dq(2)*(l(4)*sin(q(2))*sin(q(4)) - l(4)*cos(q(2))*cos(q(3))*cos(q(4))) - dq(4)*(l(4)*cos(q(2))*cos(q(4)) - l(4)*cos(q(3))*sin(q(2))*sin(q(4))) + dq(3)*l(4)*cos(q(4))*sin(q(2))*sin(q(3)) ];



%     case '3d_PRRR'
%         % 直動スライダ空間4リンク
%         dJ = [ 0, dq(3)*sin(q(2))*(l(4)*cos(q(3) + q(4)) + l(3)*cos(q(3))) + dq(2)*cos(q(2))*(l(4)*sin(q(3) + q(4)) + l(3)*sin(q(3))) + dq(4)*l(4)*cos(q(3) + q(4))*sin(q(2)), dq(2)*sin(q(2))*(l(4)*cos(q(3) + q(4)) + l(3)*cos(q(3))) + dq(3)*cos(q(2))*(l(4)*sin(q(3) + q(4)) + l(3)*sin(q(3))) + dq(4)*l(4)*sin(q(3) + q(4))*cos(q(2)), dq(2)*l(4)*cos(q(3) + q(4))*sin(q(2)) + dq(3)*l(4)*sin(q(3) + q(4))*cos(q(2)) + dq(4)*l(4)*sin(q(3) + q(4))*cos(q(2)) ;
%                0, dq(2)*sin(q(2))*(l(4)*sin(q(3) + q(4)) + l(3)*sin(q(3))) - dq(3)*cos(q(2))*(l(4)*cos(q(3) + q(4)) + l(3)*cos(q(3))) - dq(4)*l(4)*cos(q(3) + q(4))*cos(q(2)), dq(3)*sin(q(2))*(l(4)*sin(q(3) + q(4)) + l(3)*sin(q(3))) - dq(2)*cos(q(2))*(l(4)*cos(q(3) + q(4)) + l(3)*cos(q(3))) + dq(4)*l(4)*sin(q(3) + q(4))*sin(q(2)), dq(3)*l(4)*sin(q(3) + q(4))*sin(q(2)) - dq(2)*l(4)*cos(q(3) + q(4))*cos(q(2)) + dq(4)*l(4)*sin(q(3) + q(4))*sin(q(2)) ;
%                0,                                                                                                                                                           0,                                                                              - dq(3)*(l(4)*cos(q(3) + q(4)) + l(3)*cos(q(3))) - dq(4)*l(4)*cos(q(3) + q(4)),                                                                                -l(4)*cos(q(3) + q(4))*(dq(3) + dq(4)) ];




    case {'2d_RRR', 'C03160'}
        % 平面3リンク
        Jd = nan(size(J,1),size(J,2),Link);
        Jd(:,:,1) = [
                        (-l(3)*cos(q(3)+q(2)+q(1)))-l(2)*cos(q(2)+q(1))-l(1)*cos(q(1)), (-l(3)*cos(q(3)+q(2)+q(1)))-l(2)*cos(q(2)+q(1)), -l(3)*cos(q(3)+q(2)+q(1));
                        (-l(3)*sin(q(3)+q(2)+q(1)))-l(2)*sin(q(2)+q(1))-l(1)*sin(q(1)), (-l(3)*sin(q(3)+q(2)+q(1)))-l(2)*sin(q(2)+q(1)), -l(3)*sin(q(3)+q(2)+q(1));
                    ];
        Jd(:,:,2) = [
                        (-l(3)*cos(q(3)+q(2)+q(1)))-l(2)*cos(q(2)+q(1)), (-l(3)*cos(q(3)+q(2)+q(1)))-l(2)*cos(q(2)+q(1)), -l(3)*cos(q(3)+q(2)+q(1));
                        (-l(3)*sin(q(3)+q(2)+q(1)))-l(2)*sin(q(2)+q(1)), (-l(3)*sin(q(3)+q(2)+q(1)))-l(2)*sin(q(2)+q(1)), -l(3)*sin(q(3)+q(2)+q(1))
                    ];
        Jd(:,:,3) = [
                        -l(3)*cos(q(3)+q(2)+q(1)), -l(3)*cos(q(3)+q(2)+q(1)), -l(3)*cos(q(3)+q(2)+q(1));
                        -l(3)*sin(q(3)+q(2)+q(1)), -l(3)*sin(q(3)+q(2)+q(1)), -l(3)*sin(q(3)+q(2)+q(1))
                    ];
 

    case '2d_RRRR'
        % 平面4リンク
        Jd = nan(size(J,1), size(J,2), Link);
        
        Jd(:,:,1) = ...
            [- l(4)*cos(q(1) + q(2) + q(3) + q(4)) - l(2)*cos(q(1) + q(2)) - l(1)*cos(q(1)) - l(3)*cos(q(1) + q(2) + q(3)), - l(4)*cos(q(1) + q(2) + q(3) + q(4)) - l(2)*cos(q(1) + q(2)) - l(3)*cos(q(1) + q(2) + q(3)), - l(4)*cos(q(1) + q(2) + q(3) + q(4)) - l(3)*cos(q(1) + q(2) + q(3)), -l(4)*cos(q(1) + q(2) + q(3) + q(4));
             - l(4)*sin(q(1) + q(2) + q(3) + q(4)) - l(2)*sin(q(1) + q(2)) - l(1)*sin(q(1)) - l(3)*sin(q(1) + q(2) + q(3)), - l(4)*sin(q(1) + q(2) + q(3) + q(4)) - l(2)*sin(q(1) + q(2)) - l(3)*sin(q(1) + q(2) + q(3)), - l(4)*sin(q(1) + q(2) + q(3) + q(4)) - l(3)*sin(q(1) + q(2) + q(3)), -l(4)*sin(q(1) + q(2) + q(3) + q(4))];
         
         
        Jd(:,:,2) = ...
            [- l(4)*cos(q(1) + q(2) + q(3) + q(4)) - l(2)*cos(q(1) + q(2)) - l(3)*cos(q(1) + q(2) + q(3)), - l(4)*cos(q(1) + q(2) + q(3) + q(4)) - l(2)*cos(q(1) + q(2)) - l(3)*cos(q(1) + q(2) + q(3)), - l(4)*cos(q(1) + q(2) + q(3) + q(4)) - l(3)*cos(q(1) + q(2) + q(3)), -l(4)*cos(q(1) + q(2) + q(3) + q(4));
             - l(4)*sin(q(1) + q(2) + q(3) + q(4)) - l(2)*sin(q(1) + q(2)) - l(3)*sin(q(1) + q(2) + q(3)), - l(4)*sin(q(1) + q(2) + q(3) + q(4)) - l(2)*sin(q(1) + q(2)) - l(3)*sin(q(1) + q(2) + q(3)), - l(4)*sin(q(1) + q(2) + q(3) + q(4)) - l(3)*sin(q(1) + q(2) + q(3)), -l(4)*sin(q(1) + q(2) + q(3) + q(4))];
         
         
        Jd(:,:,3) = ...
            [- l(4)*cos(q(1) + q(2) + q(3) + q(4)) - l(3)*cos(q(1) + q(2) + q(3)), - l(4)*cos(q(1) + q(2) + q(3) + q(4)) - l(3)*cos(q(1) + q(2) + q(3)), - l(4)*cos(q(1) + q(2) + q(3) + q(4)) - l(3)*cos(q(1) + q(2) + q(3)), -l(4)*cos(q(1) + q(2) + q(3) + q(4));
             - l(4)*sin(q(1) + q(2) + q(3) + q(4)) - l(3)*sin(q(1) + q(2) + q(3)), - l(4)*sin(q(1) + q(2) + q(3) + q(4)) - l(3)*sin(q(1) + q(2) + q(3)), - l(4)*sin(q(1) + q(2) + q(3) + q(4)) - l(3)*sin(q(1) + q(2) + q(3)), -l(4)*sin(q(1) + q(2) + q(3) + q(4))];
         
         
        Jd(:,:,4) = ...
            [-l(4)*cos(q(1) + q(2) + q(3) + q(4)), -l(4)*cos(q(1) + q(2) + q(3) + q(4)), -l(4)*cos(q(1) + q(2) + q(3) + q(4)), -l(4)*cos(q(1) + q(2) + q(3) + q(4));
             -l(4)*sin(q(1) + q(2) + q(3) + q(4)), -l(4)*sin(q(1) + q(2) + q(3) + q(4)), -l(4)*sin(q(1) + q(2) + q(3) + q(4)), -l(4)*sin(q(1) + q(2) + q(3) + q(4))];





%     case '2d_RRRP'
%         % 平面4関節　直動（0-0-0-=<）
%         dJ = [ - dq(2)*(l(2)*cos(q(1) + q(2)) + cos(q(1) + q(2) + q(3))*(l(4) + q(4)) + cos(q(1) + q(2) + q(3))*l(3)) - dq(1)*(l(2)*cos(q(1) + q(2)) + l(1)*cos(q(1)) + cos(q(1) + q(2) + q(3))*(l(4) + q(4)) + cos(q(1) + q(2) + q(3))*l(3)) - sin(q(1) + q(2) + q(3))*dq(4) - cos(q(1) + q(2) + q(3))*dq(3)*(l(3) + l(4) + q(4)), - dq(1)*(l(2)*cos(q(1) + q(2)) + cos(q(1) + q(2) + q(3))*(l(4) + q(4)) + cos(q(1) + q(2) + q(3))*l(3)) - dq(2)*(l(2)*cos(q(1) + q(2)) + cos(q(1) + q(2) + q(3))*(l(4) + q(4)) + cos(q(1) + q(2) + q(3))*l(3)) - sin(q(1) + q(2) + q(3))*dq(4) - cos(q(1) + q(2) + q(3))*dq(3)*(l(3) + l(4) + q(4)), - sin(q(1) + q(2) + q(3))*dq(4) - cos(q(1) + q(2) + q(3))*dq(1)*(l(3) + l(4) + q(4)) - cos(q(1) + q(2) + q(3))*dq(2)*(l(3) + l(4) + q(4)) - cos(q(1) + q(2) + q(3))*dq(3)*(l(3) + l(4) + q(4)), -sin(q(1) + q(2) + q(3))*(dq(1) + dq(2) + dq(3));
%                  cos(q(1) + q(2) + q(3))*dq(4) - dq(2)*(l(2)*sin(q(1) + q(2)) + sin(q(1) + q(2) + q(3))*(l(4) + q(4)) + sin(q(1) + q(2) + q(3))*l(3)) - dq(1)*(l(2)*sin(q(1) + q(2)) + l(1)*sin(q(1)) + sin(q(1) + q(2) + q(3))*(l(4) + q(4)) + sin(q(1) + q(2) + q(3))*l(3)) - sin(q(1) + q(2) + q(3))*dq(3)*(l(3) + l(4) + q(4)),   cos(q(1) + q(2) + q(3))*dq(4) - dq(2)*(l(2)*sin(q(1) + q(2)) + sin(q(1) + q(2) + q(3))*(l(4) + q(4)) + sin(q(1) + q(2) + q(3))*l(3)) - dq(1)*(l(2)*sin(q(1) + q(2)) + sin(q(1) + q(2) + q(3))*(l(4) + q(4)) + sin(q(1) + q(2) + q(3))*l(3)) - sin(q(1) + q(2) + q(3))*dq(3)*(l(3) + l(4) + q(4)),   cos(q(1) + q(2) + q(3))*dq(4) - sin(q(1) + q(2) + q(3))*dq(1)*(l(3) + l(4) + q(4)) - sin(q(1) + q(2) + q(3))*dq(2)*(l(3) + l(4) + q(4)) - sin(q(1) + q(2) + q(3))*dq(3)*(l(3) + l(4) + q(4)),  cos(q(1) + q(2) + q(3))*(dq(1) + dq(2) + dq(3));
%                  0,                                                                                                                                                                                                                                                                                                  0,                                                                                                                                                                                              0,                                                0];





%     case '2d_RRP'
%         % 平面3関節　直動（0-0-=<）
%         dJ = [ - dq(1)*(l(1)*cos(q(1)) + cos(q(1) + q(2))*(l(2) + l(3) + q(3))) - dq(3)*sin(q(1) + q(2)) - dq(2)*cos(q(1) + q(2))*(l(2) + l(3) + q(3)), - dq(3)*sin(q(1) + q(2)) - dq(1)*cos(q(1) + q(2))*(l(2) + l(3) + q(3)) - dq(2)*cos(q(1) + q(2))*(l(2) + l(3) + q(3)), -sin(q(1) + q(2))*(dq(1) + dq(2)) ;
%                  dq(3)*cos(q(1) + q(2)) - dq(1)*(l(1)*sin(q(1)) + sin(q(1) + q(2))*(l(2) + l(3) + q(3))) - dq(2)*sin(q(1) + q(2))*(l(2) + l(3) + q(3)),   dq(3)*cos(q(1) + q(2)) - dq(1)*sin(q(1) + q(2))*(l(2) + l(3) + q(3)) - dq(2)*sin(q(1) + q(2))*(l(2) + l(3) + q(3)),  cos(q(1) + q(2))*(dq(1) + dq(2)) ];


    otherwise
        err('error f3L_Jacobi_plus');
        
end

end
