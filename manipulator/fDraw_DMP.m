function[AH] = fDraw_DMP(FH,drawDMP3d, Gr,Gz, x,dx)

%**************************************************************************
%
%   [AH] = fDraw_DMP(FH,drawDMP3d, Gr,Gz,  x,dx)
%
%       FH  : フィギュアーハンドル
%       drawDMP3d : Flag of drawingDMP on 3Dspace. yes:1 no:0
%       Gr  : r空間描画サイズ
%       Gz  : z空間描画サイズ
%       x   : Position on ExOS
%       dx  : Velocity on ExOS
%
%       v2 : デティールアップバージョン
%       v3 : 直動系対応
%       v4 : 動的可操作性多面体描画
%
%**************************************************************************

% %%
% clear
% 
% FH = 1;
% Gr = 1/150;
% Gz = Gr/20;
% 
% x = [0.2; 0.2; pi/6];
% dx = [0; 0; 30];
% 
% q = zeros(3,1);
% dq = zeros(3,1);
% q(:,1) = fIKinematics(x(1:2),x(3));
% 
% figure(FH)
% clf(FH)
% fRoboAnimation(FH,q, x(1:2),0)
% 
% drawDMP3d = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(FH)
hold on

% x = [r;z];
% dx = [dr; dz];

param = get_parameter();
    Tlim = param.Tlim;
    N = param.Link;

[J,Jp,Jd,U,Ud,err] = fJacobi_tensor(x(1:N-1),dx(1:N-1), x(N),dx(N));
Je = [J;U'];
Jei = [Jp,U];

q = fIKinematics(x(1:N-1),x(N));
% dq = Jp*dr(:,1)+U*dz;
dq = Jei*dx;

[M,h,g,hd] = get_matrix_plus(q,dq);


% Vertex of DMP
Jt = Je/M;
DMP_v = nan(size(Jt,1),factorial(size(Jt,1)));

a = 0;
for i = -1:2:1
    for j = -1:2:1
        for k = -1:2:1
            a = a+1;
            % Previous : h & g vector in the T'.
%             DMP_v(:,a) = Ut(:,1)*(i*Tlim(1)-h(1)-g(1)) + Ut(:,2)*(j*Tlim(2)-h(2)-g(2)) + Ut(:,3)*(k*Tlim(3)-h(3)-g(3));
            DMP_v(:,a) = Jt(:,1)*(i*Tlim(1)-g(1)) + Jt(:,2)*(j*Tlim(2)-g(2)) + Jt(:,3)*(k*Tlim(3)-g(3));
        end
    end
end

% Drawing Basis Vector of DMP
DMP_t = get_TranslateVector(x,dx);

% Adding transpose vector to DMP
for i = 1:size(DMP_v,2)
    DMP_v(:,i) = DMP_v(:,i)+DMP_t;
end

% Drawing transpose vector
figure(FH)
quiver3(x(1),x(2),0, DMP_t(1)*Gr,DMP_t(2)*Gr,DMP_t(3)*Gz,'m', 'LineWidth',2,'AutoScaleFactor',1)
title(strcat( 'Gr=1/',num2str(1/Gr),', Gz=1/',num2str(1/Gz) ));

% DMP drawing 3dim space   
if drawDMP3d
    V = convhull(DMP_v(1,:),DMP_v(2,:),DMP_v(3,:));
    for i = 1:size(V,1)
        patch(x(1)+DMP_v(1,V(i,:))*Gr,x(2)+DMP_v(2,V(i,:))*Gr,DMP_v(3,V(i,:))*Gz,'k', 'FaceAlpha',0 ,'EdgeColor','m','EdgeAlpha',1)
    end
    
    % Drawing Basis vector of Transpose Vector
%     G = 1;
%     for i = 1:N
%         for j = 1:N
%             quiver3(r(1),r(2),0, Jc(1,i,j)*Gr*G,Jc(2,i,j)*Gr*G,Jc(3,i,j)*Gz*G,'b', 'AutoScaleFactor',1);
% %             text(r(1),r(2),0, strcat('x_{',num2str(i),num2str(j),'}'));
%         end
%     end
    
    figure(FH)
    zlabel('$$\dot{z}$$', 'FontSize',21, 'interpreter','latex')
    view([-20,40])
    rotate3d on
end




% DMP drawing 2dim space
if drawDMP3d == 0
    % for i = 1:size(DMP_v,2)
    %     text(r(1)+DMP_v(1,i)*Gr,r(2)+DMP_v(2,i)*Gr,DMP_v(3,i)*Gz,num2str(i), 'FontSize',12)
    % end

    DMP0_v = nan(3,12);
    EdgeNumber = [1,2; 1,3; 1,5; 2,4; 2,6; 3,4; 3,7; 4,8; 5,6; 5,7; 6,8; 7,8];

    l = 0;
    for k = 1:size(EdgeNumber,1)
        i = EdgeNumber(k,1);
        j = EdgeNumber(k,2);

        if DMP_v(3,i)*DMP_v(3,j) < 0
            l = l+1;
            DMP0_v(:,l) = ( abs(DMP_v(3,j))*DMP_v(:,i)+abs(DMP_v(3,i))*DMP_v(:,j) )/( abs(DMP_v(3,i))+abs(DMP_v(3,j)) );
        end
    end

    DMP0 = convhull(DMP0_v(1,1:l),DMP0_v(2,1:l));
    AH = plot(x(1)+DMP0_v(1,DMP0)*Gr,x(2)+DMP0_v(2,DMP0)*Gr,'g', 'LineWidth',2);

end
end
