function[] = fRoboAnimation_Robo(FH,type,q)

%**************************************************************************
%
%   [] = fRoboAnimation_Robo(FH,q)
%
%       q       : 関節角度      q = [q1, q2, q3].'
%       r       : 手先位置      r = [x, y].'
%       L       : リンク長　    L = [l1, l2, l3].'
%       Ns      : サンプル数
%       Ts      : サンプリングタイム
%
%       v2 : デティールアップバージョン
%       v3 : 直動系対応
%
%                                                       14.10.03 by OKB
%**************************************************************************

% %%
% clear
% r = [ 0.1; 0.2 ];
% Rx = pi;
% [q, error] = f3L_iKinematics(r,Rx);
% Ts = 0.001;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(FH);
hold on
param = get_parameter(type);
    Link = param.Link;
    L = param.l;
    Joint = param.Joint;

HandSize = 15/1000;
L_t = L;
% if F_draw == 0
    L_t(Link) = L(Link) - HandSize/2;
% end

Ns = size(q,2);
robo = zeros(2,Link+1,1);
robo_r = zeros(2,Link+1,1);
robo_l = zeros(2,sum(Joint)*2);

nrobo_l = 1;
for i = 1:Link
    % 描画用のロボ姿勢
    robo(:,i+1) = robo(:,i) + [ (L_t(i)+q(i).*Joint(i))*cos(imcomplement(Joint(1:i))'*q(1:i)) ;
                                (L_t(i)+q(i).*Joint(i))*sin(imcomplement(Joint(1:i))'*q(1:i)) ];

    % スケルトンモデルでのロボ姿勢
    robo_r(:,i+1) = robo_r(:,i) + [ (L(i)+q(i).*Joint(i))*cos(imcomplement(Joint(1:i))'*q(1:i)) ;
                                    (L(i)+q(i).*Joint(i))*sin(imcomplement(Joint(1:i))'*q(1:i)) ];

    if Joint(i) == 1
        robo_l(:,nrobo_l) = robo(:,i);
        robo_l(:,nrobo_l+1) = robo(:,i) + [ q(i).*Joint(i)*cos(imcomplement(Joint(1:i))'*q(1:i)) ;
                                            q(i).*Joint(i)*sin(imcomplement(Joint(1:i))'*q(1:i)) ];

        nrobo_l = nrobo_l + 2;
    end
end

Hand_0 = [ HandSize/2, -HandSize/2, -HandSize/2,  HandSize/2 ;
           HandSize/2,  HandSize/2, -HandSize/2, -HandSize/2  ];

Hand = [ cos(sum(imcomplement(Joint).*q(:)))  -sin(sum(imcomplement(Joint).*q(:))) ;
         sin(sum(imcomplement(Joint).*q(:))),  cos(sum(imcomplement(Joint).*q(:))) ]*Hand_0;


%plot(r(1,:),r(2,:),'g-', 'lineWidth',2.0);%, 'Color',Color);

P = plot( robo(1,:),robo(2,:),'k' , 'lineWidth',2.0);
temp = 1:Link;
%     S = plot( robo_l(1,:,1),robo_l(2,:,1),'b.' , 'lineWidth',2.0, 'MarkerFaceColor','w', 'MarkerSize',15);

% if F_draw == 0
    O = plot( robo(1,temp(~Joint),1),robo(2,temp(~Joint),1),'ko' , 'lineWidth',2.0, 'MarkerFaceColor','w', 'MarkerSize',10);
    H = line(Hand(1,:)+diag(robo_r(1,Link+1,Ns))*ones(1,4), Hand(2,:)+diag(robo_r(2,Link+1,Ns))*ones(1,4));
    set(H, 'LineWidth',2.0, 'Color','k')
% end
set(gca, 'FontSize',15)
set(gcf, 'Color',[1,1,1])



% 平面３Ｌマニピュレータ
    
Hand = [ cos(sum(imcomplement(Joint).*q(:)))  -sin(sum(imcomplement(Joint).*q(:))) ;
         sin(sum(imcomplement(Joint).*q(:))),  cos(sum(imcomplement(Joint).*q(:))) ]*Hand_0;

% ロボ描画
% set(P, 'Xdata', robo(1,:,i), 'Ydata',robo(2,:,i) );

drawnow

end
