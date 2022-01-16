function[r] = fKinematics(type,q)

%□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□
%   [r] = fKinematics(type,q)
%
%   2次元マニピュレータ　姿勢計算関数
%
%           Th   : 関節角θの行列
%
%□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□□

% %%
% clear all
% 
% q = [0.01; pi/4; pi/4; pi/4];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

param = get_parameter(type);
% type = param.type;
Link = param.Link;
l = param.l;

switch type

    case '3d_RRRR'
        % 空間4リンク　Z-Y-Z-Y
        r = [ l(4)*sin(q(1))*sin(q(3))*sin(q(4)) - cos(q(1))*(sin(q(2))*(l(3) + l(4)*cos(q(4))) + l(2)*sin(q(2)) + l(4)*cos(q(2))*cos(q(3))*sin(q(4))) ;
              - sin(q(1))*(sin(q(2))*(l(3) + l(4)*cos(q(4))) + l(2)*sin(q(2)) + l(4)*cos(q(2))*cos(q(3))*sin(q(4))) - l(4)*cos(q(1))*sin(q(3))*sin(q(4)) ;
              l(1) + cos(q(2))*(l(3) + l(4)*cos(q(4))) + l(2)*cos(q(2)) - l(4)*cos(q(3))*sin(q(2))*sin(q(4)) ];


    case '3d_PRRR'
        % 直動スライダ空間4リンク
        r = [ q(1) - ( l(3)*sin(q(3))+l(4)*sin(q(3)+q(4)) )*cos(q(2))     ;
              -( l(3)*sin(q(3))+l(4)*sin(q(3)+q(4)) )*sin(q(2))           ;
              l(1) + l(2) + l(3)*cos(q(3)) + l(4)*cos(q(3)+q(4))          ];


    case '2d_RR'
        r = [ (-l(2)*sin(q(1))*sin(q(2)))+l(2)*cos(q(1))*cos(q(2))+l(1)*cos(q(1))       ;
              l(2)*cos(q(1))*sin(q(2))+l(2)*sin(q(1))*cos(q(2))+l(1)*sin(q(1))          ];
    
    case '2d_RRR'
        % 平面3リンク
        R = zeros(2,Link+1);
        for i = 1:Link
            R(:,i+1) = R(:,i) + [ l(i)*cos( sum(q(1:i)) )    ;
                                  l(i)*sin( sum(q(1:i)) )    ];
        end
        
        r = R(:,Link+1);

    case '2d_RRRR'
        % 平面4リンク
        r = [l(2) * cos(q(1) + q(2)) + l(3) * cos(q(3) + q(1) + q(2)) + l(4) * cos(q(1) + q(2) + q(3) + q(4)) + cos(q(1)) * l(1) ;
             l(2) * sin(q(1) + q(2)) + l(3) * sin(q(3) + q(1) + q(2)) + l(4) * sin(q(1) + q(2) + q(3) + q(4)) + sin(q(1)) * l(1)];


    case '2d_RRRP'
        % 平面4関節　直動（0-0-0-=<）
        r = [ l(2)*cos(q(1) + q(2)) + l(1)*cos(q(1)) + cos(q(1) + q(2) + q(3))*(l(4) + q(4)) + cos(q(1) + q(2) + q(3))*l(3) ;
              l(2)*sin(q(1) + q(2)) + l(1)*sin(q(1)) + sin(q(1) + q(2) + q(3))*(l(4) + q(4)) + sin(q(1) + q(2) + q(3))*l(3) ;
              q(1) + q(2) + q(3) ];

    case '2d_RRP'
        % 平面3関節　直動（ 0-0-=< ）
        r = [ l(1)*cos(q(1))+(l(2)+l(3)+q(3))*cos(q(1)+q(2))  ;
              l(1)*sin(q(1))+(l(2)+l(3)+q(3))*sin(q(1)+q(2))  ];

    otherwise
        error('error kinematics');
        
end
end
