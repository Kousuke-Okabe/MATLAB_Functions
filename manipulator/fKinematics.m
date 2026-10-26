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
% type = 'xArm_with_pusher'
% 
% q = [-0.0003719903470482677;
%      -0.16780024766921997;
%      -1.5654312372207642;
%      -0.0002243446942884475;
%      1.7662522792816162;
%      -0.0008935438236221671];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

switch type
    case {'xArm','xArm_with_pusher'}
        param = get_parameter_DH(type);
            d = param.d;
            a = param.a;
            offset = param.offset;
            Sigma_r = param.Sigma_r;
        
    otherwise
        param = get_parameter(type);
        % type = param.type;
        Link = param.Link;
        l = param.l;
end

switch type
    case {'xArm', 'xArm_with_pusher'}
        r = [ (((cos(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3))-cos(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3)))*cos(q(4))-sin(q(1))*sin(q(4)))*sin(q(5))+(-cos(q(1))*cos(q(2)+offset(2))*sin(q(3)+offset(3))-cos(q(1))*sin(q(2)+offset(2))*cos(q(3)+offset(3)))*cos(q(5)))*Sigma_r(3)+(((cos(q(1))*cos(q(2)+offset(2))*sin(q(3)+offset(3))+cos(q(1))*sin(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(5))+((cos(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3))-cos(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3)))*cos(q(4))-sin(q(1))*sin(q(4)))*cos(q(5)))*sin(q(6))+((cos(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3))-cos(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(4))+sin(q(1))*cos(q(4)))*cos(q(6)))*Sigma_r(2)+(((cos(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3))-cos(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(4))+sin(q(1))*cos(q(4)))*sin(q(6))+((-cos(q(1))*cos(q(2)+offset(2))*sin(q(3)+offset(3))-cos(q(1))*sin(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(5))+(sin(q(1))*sin(q(4))+(cos(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3))-cos(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3)))*cos(q(4)))*cos(q(5)))*cos(q(6)))*Sigma_r(1)+(-d(6)*sin(q(1))*sin(q(4))+(d(6)*cos(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3))-d(6)*cos(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3)))*cos(q(4))-a(6)*cos(q(1))*cos(q(2)+offset(2))*sin(q(3)+offset(3))-a(6)*cos(q(1))*sin(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(5))+(a(6)*sin(q(1))*sin(q(4))+(a(6)*cos(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3))-a(6)*cos(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3)))*cos(q(4))-d(6)*cos(q(1))*cos(q(2)+offset(2))*sin(q(3)+offset(3))-d(6)*cos(q(1))*sin(q(2)+offset(2))*cos(q(3)+offset(3)))*cos(q(5))+(-a(4)*cos(q(1))*sin(q(2)+offset(2))-d(4)*cos(q(1))*cos(q(2)+offset(2)))*sin(q(3)+offset(3))+(a(4)*cos(q(1))*cos(q(2)+offset(2))-d(4)*cos(q(1))*sin(q(2)+offset(2)))*cos(q(3)+offset(3))+a(3)*cos(q(1))*cos(q(2)+offset(2));
              ((cos(q(1))*sin(q(4))+(sin(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3))-sin(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3)))*cos(q(4)))*sin(q(5))+(-sin(q(1))*cos(q(2)+offset(2))*sin(q(3)+offset(3))-sin(q(1))*sin(q(2)+offset(2))*cos(q(3)+offset(3)))*cos(q(5)))*Sigma_r(3)+(((sin(q(1))*cos(q(2)+offset(2))*sin(q(3)+offset(3))+sin(q(1))*sin(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(5))+(cos(q(1))*sin(q(4))+(sin(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3))-sin(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3)))*cos(q(4)))*cos(q(5)))*sin(q(6))+((sin(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3))-sin(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(4))-cos(q(1))*cos(q(4)))*cos(q(6)))*Sigma_r(2)+(((sin(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3))-sin(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(4))-cos(q(1))*cos(q(4)))*sin(q(6))+((-sin(q(1))*cos(q(2)+offset(2))*sin(q(3)+offset(3))-sin(q(1))*sin(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(5))+((sin(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3))-sin(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3)))*cos(q(4))-cos(q(1))*sin(q(4)))*cos(q(5)))*cos(q(6)))*Sigma_r(1)+(d(6)*cos(q(1))*sin(q(4))+(d(6)*sin(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3))-d(6)*sin(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3)))*cos(q(4))-a(6)*sin(q(1))*cos(q(2)+offset(2))*sin(q(3)+offset(3))-a(6)*sin(q(1))*sin(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(5))+(-a(6)*cos(q(1))*sin(q(4))+(a(6)*sin(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3))-a(6)*sin(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3)))*cos(q(4))-d(6)*sin(q(1))*cos(q(2)+offset(2))*sin(q(3)+offset(3))-d(6)*sin(q(1))*sin(q(2)+offset(2))*cos(q(3)+offset(3)))*cos(q(5))+(-a(4)*sin(q(1))*sin(q(2)+offset(2))-d(4)*sin(q(1))*cos(q(2)+offset(2)))*sin(q(3)+offset(3))+(a(4)*sin(q(1))*cos(q(2)+offset(2))-d(4)*sin(q(1))*sin(q(2)+offset(2)))*cos(q(3)+offset(3))+a(3)*sin(q(1))*cos(q(2)+offset(2));
              ((cos(q(2)+offset(2))*sin(q(3)+offset(3))+sin(q(2)+offset(2))*cos(q(3)+offset(3)))*cos(q(4))*sin(q(5))+(sin(q(2)+offset(2))*sin(q(3)+offset(3))-cos(q(2)+offset(2))*cos(q(3)+offset(3)))*cos(q(5)))*Sigma_r(3)+(((cos(q(2)+offset(2))*cos(q(3)+offset(3))-sin(q(2)+offset(2))*sin(q(3)+offset(3)))*sin(q(5))+(cos(q(2)+offset(2))*sin(q(3)+offset(3))+sin(q(2)+offset(2))*cos(q(3)+offset(3)))*cos(q(4))*cos(q(5)))*sin(q(6))+(cos(q(2)+offset(2))*sin(q(3)+offset(3))+sin(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(4))*cos(q(6)))*Sigma_r(2)+((cos(q(2)+offset(2))*sin(q(3)+offset(3))+sin(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(4))*sin(q(6))+((sin(q(2)+offset(2))*sin(q(3)+offset(3))-cos(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(5))+(-cos(q(2)+offset(2))*sin(q(3)+offset(3))-sin(q(2)+offset(2))*cos(q(3)+offset(3)))*cos(q(4))*cos(q(5)))*cos(q(6)))*Sigma_r(1)+((d(6)*cos(q(2)+offset(2))*sin(q(3)+offset(3))+d(6)*sin(q(2)+offset(2))*cos(q(3)+offset(3)))*cos(q(4))+a(6)*sin(q(2)+offset(2))*sin(q(3)+offset(3))-a(6)*cos(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(5))+((-a(6)*cos(q(2)+offset(2))*sin(q(3)+offset(3))-a(6)*sin(q(2)+offset(2))*cos(q(3)+offset(3)))*cos(q(4))+d(6)*sin(q(2)+offset(2))*sin(q(3)+offset(3))-d(6)*cos(q(2)+offset(2))*cos(q(3)+offset(3)))*cos(q(5))+(d(4)*sin(q(2)+offset(2))-a(4)*cos(q(2)+offset(2)))*sin(q(3)+offset(3))+(-a(4)*sin(q(2)+offset(2))-d(4)*cos(q(2)+offset(2)))*cos(q(3)+offset(3))-a(3)*sin(q(2)+offset(2))+d(1);
              atan2(((((cos(q(2)+offset(2))*cos(q(3)+offset(3))-sin(q(2)+offset(2))*sin(q(3)+offset(3)))*sin(q(5))+(cos(q(2)+offset(2))*sin(q(3)+offset(3))+sin(q(2)+offset(2))*cos(q(3)+offset(3)))*cos(q(4))*cos(q(5)))*sin(q(6))+(cos(q(2)+offset(2))*sin(q(3)+offset(3))+sin(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(4))*cos(q(6)))*sqrt((((sin(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3))-sin(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(4))-cos(q(1))*cos(q(4)))*sin(q(6))+((-sin(q(1))*cos(q(2)+offset(2))*sin(q(3)+offset(3))-sin(q(1))*sin(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(5))+((sin(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3))-sin(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3)))*cos(q(4))-cos(q(1))*sin(q(4)))*cos(q(5)))*cos(q(6)))^2+(((cos(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3))-cos(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(4))+sin(q(1))*cos(q(4)))*sin(q(6))+((-cos(q(1))*cos(q(2)+offset(2))*sin(q(3)+offset(3))-cos(q(1))*sin(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(5))+(sin(q(1))*sin(q(4))+(cos(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3))-cos(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3)))*cos(q(4)))*cos(q(5)))*cos(q(6)))^2+((cos(q(2)+offset(2))*sin(q(3)+offset(3))+sin(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(4))*sin(q(6))+((sin(q(2)+offset(2))*sin(q(3)+offset(3))-cos(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(5))+(-cos(q(2)+offset(2))*sin(q(3)+offset(3))-sin(q(2)+offset(2))*cos(q(3)+offset(3)))*cos(q(4))*cos(q(5)))*cos(q(6)))^2))/sqrt((((sin(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3))-sin(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(4))-cos(q(1))*cos(q(4)))*sin(q(6))+((-sin(q(1))*cos(q(2)+offset(2))*sin(q(3)+offset(3))-sin(q(1))*sin(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(5))+((sin(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3))-sin(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3)))*cos(q(4))-cos(q(1))*sin(q(4)))*cos(q(5)))*cos(q(6)))^2+(((cos(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3))-cos(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(4))+sin(q(1))*cos(q(4)))*sin(q(6))+((-cos(q(1))*cos(q(2)+offset(2))*sin(q(3)+offset(3))-cos(q(1))*sin(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(5))+(sin(q(1))*sin(q(4))+(cos(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3))-cos(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3)))*cos(q(4)))*cos(q(5)))*cos(q(6)))^2),(((cos(q(2)+offset(2))*sin(q(3)+offset(3))+sin(q(2)+offset(2))*cos(q(3)+offset(3)))*cos(q(4))*sin(q(5))+(sin(q(2)+offset(2))*sin(q(3)+offset(3))-cos(q(2)+offset(2))*cos(q(3)+offset(3)))*cos(q(5)))*sqrt((((sin(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3))-sin(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(4))-cos(q(1))*cos(q(4)))*sin(q(6))+((-sin(q(1))*cos(q(2)+offset(2))*sin(q(3)+offset(3))-sin(q(1))*sin(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(5))+((sin(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3))-sin(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3)))*cos(q(4))-cos(q(1))*sin(q(4)))*cos(q(5)))*cos(q(6)))^2+(((cos(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3))-cos(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(4))+sin(q(1))*cos(q(4)))*sin(q(6))+((-cos(q(1))*cos(q(2)+offset(2))*sin(q(3)+offset(3))-cos(q(1))*sin(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(5))+(sin(q(1))*sin(q(4))+(cos(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3))-cos(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3)))*cos(q(4)))*cos(q(5)))*cos(q(6)))^2+((cos(q(2)+offset(2))*sin(q(3)+offset(3))+sin(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(4))*sin(q(6))+((sin(q(2)+offset(2))*sin(q(3)+offset(3))-cos(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(5))+(-cos(q(2)+offset(2))*sin(q(3)+offset(3))-sin(q(2)+offset(2))*cos(q(3)+offset(3)))*cos(q(4))*cos(q(5)))*cos(q(6)))^2))/sqrt((((sin(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3))-sin(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(4))-cos(q(1))*cos(q(4)))*sin(q(6))+((-sin(q(1))*cos(q(2)+offset(2))*sin(q(3)+offset(3))-sin(q(1))*sin(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(5))+((sin(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3))-sin(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3)))*cos(q(4))-cos(q(1))*sin(q(4)))*cos(q(5)))*cos(q(6)))^2+(((cos(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3))-cos(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(4))+sin(q(1))*cos(q(4)))*sin(q(6))+((-cos(q(1))*cos(q(2)+offset(2))*sin(q(3)+offset(3))-cos(q(1))*sin(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(5))+(sin(q(1))*sin(q(4))+(cos(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3))-cos(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3)))*cos(q(4)))*cos(q(5)))*cos(q(6)))^2));
              -atan2((cos(q(2)+offset(2))*sin(q(3)+offset(3))+sin(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(4))*sin(q(6))+((sin(q(2)+offset(2))*sin(q(3)+offset(3))-cos(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(5))+(-cos(q(2)+offset(2))*sin(q(3)+offset(3))-sin(q(2)+offset(2))*cos(q(3)+offset(3)))*cos(q(4))*cos(q(5)))*cos(q(6)),sqrt((((sin(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3))-sin(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(4))-cos(q(1))*cos(q(4)))*sin(q(6))+((-sin(q(1))*cos(q(2)+offset(2))*sin(q(3)+offset(3))-sin(q(1))*sin(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(5))+((sin(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3))-sin(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3)))*cos(q(4))-cos(q(1))*sin(q(4)))*cos(q(5)))*cos(q(6)))^2+(((cos(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3))-cos(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(4))+sin(q(1))*cos(q(4)))*sin(q(6))+((-cos(q(1))*cos(q(2)+offset(2))*sin(q(3)+offset(3))-cos(q(1))*sin(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(5))+(sin(q(1))*sin(q(4))+(cos(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3))-cos(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3)))*cos(q(4)))*cos(q(5)))*cos(q(6)))^2));
              atan2(((((sin(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3))-sin(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(4))-cos(q(1))*cos(q(4)))*sin(q(6))+((-sin(q(1))*cos(q(2)+offset(2))*sin(q(3)+offset(3))-sin(q(1))*sin(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(5))+((sin(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3))-sin(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3)))*cos(q(4))-cos(q(1))*sin(q(4)))*cos(q(5)))*cos(q(6)))*sqrt((((sin(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3))-sin(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(4))-cos(q(1))*cos(q(4)))*sin(q(6))+((-sin(q(1))*cos(q(2)+offset(2))*sin(q(3)+offset(3))-sin(q(1))*sin(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(5))+((sin(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3))-sin(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3)))*cos(q(4))-cos(q(1))*sin(q(4)))*cos(q(5)))*cos(q(6)))^2+(((cos(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3))-cos(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(4))+sin(q(1))*cos(q(4)))*sin(q(6))+((-cos(q(1))*cos(q(2)+offset(2))*sin(q(3)+offset(3))-cos(q(1))*sin(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(5))+(sin(q(1))*sin(q(4))+(cos(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3))-cos(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3)))*cos(q(4)))*cos(q(5)))*cos(q(6)))^2+((cos(q(2)+offset(2))*sin(q(3)+offset(3))+sin(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(4))*sin(q(6))+((sin(q(2)+offset(2))*sin(q(3)+offset(3))-cos(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(5))+(-cos(q(2)+offset(2))*sin(q(3)+offset(3))-sin(q(2)+offset(2))*cos(q(3)+offset(3)))*cos(q(4))*cos(q(5)))*cos(q(6)))^2))/sqrt((((sin(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3))-sin(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(4))-cos(q(1))*cos(q(4)))*sin(q(6))+((-sin(q(1))*cos(q(2)+offset(2))*sin(q(3)+offset(3))-sin(q(1))*sin(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(5))+((sin(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3))-sin(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3)))*cos(q(4))-cos(q(1))*sin(q(4)))*cos(q(5)))*cos(q(6)))^2+(((cos(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3))-cos(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(4))+sin(q(1))*cos(q(4)))*sin(q(6))+((-cos(q(1))*cos(q(2)+offset(2))*sin(q(3)+offset(3))-cos(q(1))*sin(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(5))+(sin(q(1))*sin(q(4))+(cos(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3))-cos(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3)))*cos(q(4)))*cos(q(5)))*cos(q(6)))^2),((((cos(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3))-cos(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(4))+sin(q(1))*cos(q(4)))*sin(q(6))+((-cos(q(1))*cos(q(2)+offset(2))*sin(q(3)+offset(3))-cos(q(1))*sin(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(5))+(sin(q(1))*sin(q(4))+(cos(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3))-cos(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3)))*cos(q(4)))*cos(q(5)))*cos(q(6)))*sqrt((((sin(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3))-sin(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(4))-cos(q(1))*cos(q(4)))*sin(q(6))+((-sin(q(1))*cos(q(2)+offset(2))*sin(q(3)+offset(3))-sin(q(1))*sin(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(5))+((sin(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3))-sin(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3)))*cos(q(4))-cos(q(1))*sin(q(4)))*cos(q(5)))*cos(q(6)))^2+(((cos(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3))-cos(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(4))+sin(q(1))*cos(q(4)))*sin(q(6))+((-cos(q(1))*cos(q(2)+offset(2))*sin(q(3)+offset(3))-cos(q(1))*sin(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(5))+(sin(q(1))*sin(q(4))+(cos(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3))-cos(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3)))*cos(q(4)))*cos(q(5)))*cos(q(6)))^2+((cos(q(2)+offset(2))*sin(q(3)+offset(3))+sin(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(4))*sin(q(6))+((sin(q(2)+offset(2))*sin(q(3)+offset(3))-cos(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(5))+(-cos(q(2)+offset(2))*sin(q(3)+offset(3))-sin(q(2)+offset(2))*cos(q(3)+offset(3)))*cos(q(4))*cos(q(5)))*cos(q(6)))^2))/sqrt((((sin(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3))-sin(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(4))-cos(q(1))*cos(q(4)))*sin(q(6))+((-sin(q(1))*cos(q(2)+offset(2))*sin(q(3)+offset(3))-sin(q(1))*sin(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(5))+((sin(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3))-sin(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3)))*cos(q(4))-cos(q(1))*sin(q(4)))*cos(q(5)))*cos(q(6)))^2+(((cos(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3))-cos(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(4))+sin(q(1))*cos(q(4)))*sin(q(6))+((-cos(q(1))*cos(q(2)+offset(2))*sin(q(3)+offset(3))-cos(q(1))*sin(q(2)+offset(2))*cos(q(3)+offset(3)))*sin(q(5))+(sin(q(1))*sin(q(4))+(cos(q(1))*cos(q(2)+offset(2))*cos(q(3)+offset(3))-cos(q(1))*sin(q(2)+offset(2))*sin(q(3)+offset(3)))*cos(q(4)))*cos(q(5)))*cos(q(6)))^2))];

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


    case {'2d_RR', '2d_RR_c'}
        r = [ (-l(2)*sin(q(1))*sin(q(2)))+l(2)*cos(q(1))*cos(q(2))+l(1)*cos(q(1))       ;
              l(2)*cos(q(1))*sin(q(2))+l(2)*sin(q(1))*cos(q(2))+l(1)*sin(q(1))          ];
    
    case {'2d_RRR', 'C03160', '2d_RRR_c'}
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

        % r = [l(2) * cos(q(1) + q(2)) + l(3) * cos(q(3) + q(1) + q(2)) + l(4) * cos(q(1) + q(2) + q(3) + q(4)) + cos(q(1)) * l(1) ;
        %      l(2) * sin(q(1) + q(2)) + l(3) * sin(q(3) + q(1) + q(2)) + l(4) * sin(q(1) + q(2) + q(3) + q(4)) + sin(q(1)) * l(1) ;
        %      q(1) + q(2) + q(3) + q(4) ];

    case '2d_R'
        % 平面1リンク
        % r = [ l(1)*cos(q(1)) ;
        %       l(1)*sin(q(1)) ];

        r = [ l(1)*cos(q(1)) ;
              l(1)*sin(q(1)) ;
              q(1) ];

%     case '2d_RRRP'
%         % 平面4関節　直動（0-0-0-=<）
%         r = [ l(2)*cos(q(1) + q(2)) + l(1)*cos(q(1)) + cos(q(1) + q(2) + q(3))*(l(4) + q(4)) + cos(q(1) + q(2) + q(3))*l(3) ;
%               l(2)*sin(q(1) + q(2)) + l(1)*sin(q(1)) + sin(q(1) + q(2) + q(3))*(l(4) + q(4)) + sin(q(1) + q(2) + q(3))*l(3) ;
%               q(1) + q(2) + q(3) ];

%     case '2d_RRP'
%         % 平面3関節　直動（ 0-0-=< ）
%         r = [ l(1)*cos(q(1))+(l(2)+l(3)+q(3))*cos(q(1)+q(2))  ;
%               l(1)*sin(q(1))+(l(2)+l(3)+q(3))*sin(q(1)+q(2))  ];

    otherwise
        error('error kinematics');
        
end
end
