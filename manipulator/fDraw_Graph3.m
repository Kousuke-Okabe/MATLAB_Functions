function[] = fDraw_Graph3(FH,G,V,Polytope,CrossSection,Projection)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   グラフから多面体を描画
%
%   [] = fDraw_Graph3(FH,G,V,Polytope,CrossSection，Projection)
%       FH: Figure Handle
%       G : グラフ
%       V : 頂点データ
%       c : Color
%       Polytope : 多面体
%       CrossSection : 断面
%       Projection : 射影
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %%
% clear all
% 
% disp('test data')
% FH = 100;
% figure(FH)
% clf(FH)
% rotate3d
% 
% G = [
%      0     1     1     0     1     0     0     0;
%      1     0     0     1     0     1     0     0;
%      1     0     0     1     0     0     1     0;
%      0     1     1     0     0     0     0     1;
%      1     0     0     0     0     1     1     0;
%      0     1     0     0     1     0     0     1;
%      0     0     1     0     1     0     0     1;
%      0     0     0     1     0     1     1     0];
% 
% V = [
%    -0.2169   -0.1138    0.0661    0.1692   -0.1692   -0.0661    0.1138    0.2169
%    -0.1029   -0.1867    0.0073   -0.0765    0.0765   -0.0073    0.1867    0.1029
%     0.0020   -0.0041    0.0045   -0.0016    0.0016   -0.0045    0.0041   -0.0020
%     ];
% 
% c = 'b';
% Polytope = 1;
% CrossSection = 1;
% Projection = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n = [0;0;1];
a = 0;
na = a*n;

figure(FH)
hold on
% rotate3d

cnt = 0;
Vc = nan(3,sum(sum(G))/2);
for i = 1:size(G,2)
    for j = i+1:size(G,2)
        if G(i,j) == 1
            if CrossSection==1
                t = dot(n,na-V(:,i)) / dot(n,V(:,j)-V(:,i));
                if t >=0 && t <=1
                    cnt = cnt+1;
                    Vc(:,cnt) = V(:,i)+(V(:,j)-V(:,i))*t;
                end
            end
            if Polytope == 1
                plot3([V(1,i),V(1,j)],[V(2,i),V(2,j)],[V(3,i),V(3,j)],'b');
            end
        end
    end
end

if CrossSection==1 && cnt > 0
    disp('とりあえず平面凸包を使用')
    k = convhull(Vc(1,1:cnt)',Vc(2,1:cnt)');
    plot(Vc(1,k),Vc(2,k),'g');
end

if Projection == 1
    k = convhull(V(1,:)',V(2,:)');
    plot(V(1,k),V(2,k),'c');
end

% axis equal
