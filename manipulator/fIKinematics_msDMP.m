function[q] = fIKinematics_msDMP(type,r)

%**************************************************************************
%
%   [q] = fIKinematics_msDMP(type,r)
%
%       r   : éËêÊà íu r = [ main_r; sub_r ]
%
%       ver0.1 : ãtâ^ìÆäwñ‚ëË
%
%                                                       21.10.27 by OKB
%**************************************************************************
%   %%
%  clear all
%      r = [0.2; 0.2 ;0.1 ;0.15];
%    
%      draw=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
type1 = '2d_RRRR'
type2 = '2d_RR'
param = get_parameter(type1);
    Link = param.Link;
    Ts = param.Ts;

N = 1000;
q = nan(Link,N);
q(:,1) = ones(Link,1)*pi/2;
I = eye(Link);

for k = 1:N
    r1 = fKinematics(type1,q(:,k));
    r2 = fKinematics(type2,q(1:2,k));
    [J1,Jp1] = fJacobi_minus_q(type1,q(:,k));
    [J2,Jp2] = fJacobi_minus_q(type2,q(1:2,k));
    J2 = [J2,zeros(2,2)];
    Jp2 = J2'/(J2*J2');
    
    q(:,k+1) = q(:,k) + ( Jp1*(r(1:2)-r1) + (I-Jp1*J1)*Jp2*(r(3:4)-r2) )/1;
    
    for i = 2:2:Link
        if q(i,k+1) < 0
            q(i,k+1) = - q(i,k+1);
        elseif q(i,k+1) > pi
            q(i,k+1) =  2*pi - q(i,k+1);
        end
    end
end

% if draw == 1
%     FH = 1;
%     figure(FH)
%     clf(FH)
%     grid on
%     fRoboAnimation(type1,FH,q(:,1:N), diag(r(1:2,1))*ones(2,N),0)
%     q(:,k+1)
% end

q = q(:,k+1);
end