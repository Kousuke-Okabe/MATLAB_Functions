function[robo] = fRoboAnimation_Frame(type,q)
%**************************************************************************
%
%   [robo] = fRoboAnimation_Frame(type,q)
%
%       type    : Robot Type
%       q       : 関節角度      q = [q1, q2, q3].'
%
%                                                       14.10.03 by OKB
%**************************************************************************

% %%
% clear
% type = "2d_RRR"
% q = [0;pi/3;pi/6];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
param = get_parameter(type);

robo = zeros(2,param.Link+1,1);
% robo_r = zeros(2,param.Link+1,1);
% robo_l = zeros(2,sum(param.Joint)*2);
% 
% nrobo_l = 1;
for i = 1:param.Link
    % 描画用のロボ姿勢
    robo(:,i+1) = robo(:,i) + [ (param.l(i)+q(i).*param.Joint(i))*cos(imcomplement(param.Joint(1:i))'*q(1:i)) ;
                                (param.l(i)+q(i).*param.Joint(i))*sin(imcomplement(param.Joint(1:i))'*q(1:i)) ];

%     % スケルトンモデルでのロボ姿勢
%     robo_r(:,i+1) = robo_r(:,i) + [ (param.l(i)+q(i).*param.Joint(i))*cos(imcomplement(param.Joint(1:i))'*q(1:i)) ;
%                                     (param.l(i)+q(i).*param.Joint(i))*sin(imcomplement(param.Joint(1:i))'*q(1:i)) ];

%     if param.Joint(i) == 1
%         robo_l(:,nrobo_l) = robo(:,i);
%         robo_l(:,nrobo_l+1) = robo(:,i) + [ q(i).*param.Joint(i)*cos(imcomplement(param.Joint(1:i))'*q(1:i)) ;
%                                             q(i).*param.Joint(i)*sin(imcomplement(param.Joint(1:i))'*q(1:i)) ];
% 
%         nrobo_l = nrobo_l + 2;
%     end
end

end
