function[] = fRoboAnimation(type,FH,q, r,Ts)

%**************************************************************************
%
%   [] = fRoboAnimation(type,FH,q, r,Ts)
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
% clear all
% 
% type = '2d_RRRR';
% 
% FH = 1;
% q = [0; pi/6; pi/4; pi/3];
% r = [ 0.1; 0.2 ];
% Ts = 0.001;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 動画制作フラグ
F_movie = 0;
if F_movie ==1
    disp('Recording moevie.');
end

pSpeed = 1/10;
fps = 15;
alpha = fix(pSpeed/(fps*Ts));

% 複数描画フラグ
F_draw = 0;
nDraw = 6;

F_HandTrack = 0;


param = get_parameter(type);
    Link = param.Link;
    L = param.l;
    Joint = param.Joint;

HandSize = 15/1000;
L_t = L;
if F_draw == 0
    L_t(Link) = L(Link) - HandSize/2;
end

Ns = size(q,2);
robo = zeros(2,Link+1,Ns);
robo_r = zeros(2,Link+1,Ns);
robo_l = zeros(2,sum(Joint)*2,Ns);
HandPath = zeros(2,Ns);

for k = 1:Ns
    nrobo_l = 1;
    for i = 1:Link
        % 描画用のロボ姿勢
        robo(:,i+1,k) = robo(:,i,k) + [ (L_t(i)+q(i,k).*Joint(i))*cos(imcomplement(Joint(1:i))'*q(1:i,k)) ;
                                        (L_t(i)+q(i,k).*Joint(i))*sin(imcomplement(Joint(1:i))'*q(1:i,k)) ];
        
        % スケルトンモデルでのロボ姿勢
        robo_r(:,i+1,k) = robo_r(:,i,k) + [ (L(i)+q(i,k).*Joint(i))*cos(imcomplement(Joint(1:i))'*q(1:i,k)) ;
                                            (L(i)+q(i,k).*Joint(i))*sin(imcomplement(Joint(1:i))'*q(1:i,k)) ];
     	
       	if Joint(i) == 1
            robo_l(:,nrobo_l,k) = robo(:,i,k);
            robo_l(:,nrobo_l+1,k) = robo(:,i,k) + [ q(i,k).*Joint(i)*cos(imcomplement(Joint(1:i))'*q(1:i,k)) ;
                                                  q(i,k).*Joint(i)*sin(imcomplement(Joint(1:i))'*q(1:i,k)) ];
            
            nrobo_l = nrobo_l + 2;
        end
    end
end

Hand_0 = [ HandSize/2, -HandSize/2, -HandSize/2,  HandSize/2 ;
           HandSize/2,  HandSize/2, -HandSize/2, -HandSize/2  ];

Hand = [ cos(sum(imcomplement(Joint).*q(:,1)))  -sin(sum(imcomplement(Joint).*q(:,1))) ;
         sin(sum(imcomplement(Joint).*q(:,1))),  cos(sum(imcomplement(Joint).*q(:,1))) ]*Hand_0;

figure(FH)
%     clf(FH)
    hold on
    axis equal
    box on
    xlim([-0.0, 0.4])
    ylim([-0.1, 0.3])
    
    plot([-0.5, 0.5],[0,0],'k')
    plot([0,0],[-0.5, 0.5],'k')
    
    xlabel('$$x$$ [m]', 'FontSize',21, 'interpreter','latex')
    ylabel('$$y$$ [m]', 'FontSize',21, 'interpreter','latex')
    zlabel('$$x$$ [m]', 'FontSize',21, 'interpreter','latex')
%     grid on
    Color = [1,1,1]*0.5;
    
    plot(r(1,:),r(2,:),'r-', 'lineWidth',2.0);%, 'Color',Color);
    if F_HandTrack
        T = plot(HandPath(1,1),HandPath(2,1),'g', 'LineWidth',2.0);
    end

    P = plot( robo(1,:,1),robo(2,:,1),'k' , 'lineWidth',2.0);
    temp = 1:Link;
%     S = plot( robo_l(1,:,1),robo_l(2,:,1),'b.' , 'lineWidth',2.0, 'MarkerFaceColor','w', 'MarkerSize',15);
    
    if F_draw == 0
        R = plot(r(1,1),r(2,1),'ro');
        O = plot( robo(1,temp(~Joint),1),robo(2,temp(~Joint),1),'ko' , 'lineWidth',2.0, 'MarkerFaceColor','w', 'MarkerSize',10);
        H = line(Hand(1,:)+diag(robo_r(1,Link+1,Ns))*ones(1,4), Hand(2,:)+diag(robo_r(2,Link+1,Ns))*ones(1,4));
        set(H, 'LineWidth',2.0, 'Color','k')
    end
    set(gca, 'FontSize',15)
    set(gcf, 'Color',[1,1,1])

if F_movie == 1
    disp('Make a movie.')
    
    mov(1:fix(Ns/alpha)-1) = struct('cdata', [],'colormap', []);
    iMov = 0;
    
    set(gcf,'color','white')
end



% 平面３Ｌマニピュレータ
for i = 1:Ns
    
    Hand = [ cos(sum(imcomplement(Joint).*q(:,i)))  -sin(sum(imcomplement(Joint).*q(:,i))) ;
             sin(sum(imcomplement(Joint).*q(:,i))),  cos(sum(imcomplement(Joint).*q(:,i))) ]*Hand_0;
    
    % ロボ描画
    set(P, 'Xdata', robo(1,:,i), 'Ydata',robo(2,:,i) );
%     set(P, 'Xdata', robo(1,Link:Link+1,i), 'Ydata',robo(2,Link:Link+1,i) );
%     set(O, 'Xdata', robo(1,Link,i), 'Ydata',robo(2,Link,i) );
%     set(S, 'Xdata', robo_l(1,:,i), 'Ydata',robo_l(2,:,i) );
    
    if F_HandTrack
        HandPath(:,i) = robo_r(:,Link+1,i);
        set(T, 'Xdata',HandPath(1,1:i), 'Ydata',HandPath(2,1:i));
    end
    
    if  F_draw == 0
        set(R, 'Xdata',r(1,i), 'Ydata',r(2,i));
        set(O, 'Xdata',robo(1,temp(~Joint),i), 'Ydata',robo(2,temp(~Joint),i) );
        set(H, 'Xdata',Hand(1,:)+diag(robo_r(1,Link+1,i))*ones(1,4), 'Ydata',Hand(2,:)+diag(robo_r(2,Link+1,i))*ones(1,4));
    end
    
    if F_draw == 1 && any( round(linspace(1,Ns,nDraw)) == i )
        plot( robo(1,:,i),robo(2,:,i),'k' , 'lineWidth',1.0);
%         plot( robo_l(1,:,i),robo_l(2,:,i),'k.' , 'lineWidth',2.0, 'MarkerFaceColor','w', 'MarkerSize',15);
        plot( robo_l(1,:,i),robo_l(2,:,i),'k.' , 'Color',[cos(i/Ns*1.5*pi)/2+0.5,cos(i/Ns*1.5*pi+2*pi/3)/2+0.5,cos(i/Ns*1.5*pi-2*pi/3)/2+0.5], 'lineWidth',2.0, 'MarkerFaceColor','w', 'MarkerSize',15);
    end

    drawnow
    pause(Ts)
    
    if F_movie == 1 && rem(i,alpha) == 0
        iMov = iMov + 1;
        MOV(iMov) = getframe(FH);
    end
end

if F_movie == 1
    movie2avi(MOV(1:iMov),'motion.avi', 'compression','None', 'fps',fps);
end


end
