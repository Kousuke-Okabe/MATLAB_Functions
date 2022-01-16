function[J,Jp,U,err] = fJacobi_q(type, q)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   [J,Jp,U,error] = fJacobi_q(type,q)
%
%       type: arm type
%       q   : �֐ߊp�x
%
%       J   : ���R�r�s��
%       Jp  : ���R�r�s��̋^���t�s��
%       U   : ���R�r�s��̐��K���������(��͉�)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

draw = 0;

% %%
% clear
% 
% q = [
%     0;
%     pi/3;
%     pi/4
%     ];
% 
% draw = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

err = 0;

check = size(q,2);
if check ~= 1
    disp('error : f3L_Jacobi input')
    
    err = 1;
    return;
end

param = get_parameter(type);
%     type = param.type;
    Link = param.Link;
    l = param.l;

[J,Jp] = fJacobi_minus_q(type,q);

% [U,S,V] = svds(eye(Link)-Jp*J,1);
% if Sigma*U < 0
%     U = -U;
% end
% Un = cross(Jp(:,1),Jp(:,2));
% U = cross(Jp(:,1),Jp(:,2))/norm(Un);

switch type

    case '2d_RRR'
        % Jp�ɂ��U�̓��o
        U = [
                -(sqrt(2)*l(2)*l(3)*sin(q(3)))/(sqrt(-2*l(1)^2*l(3)^2*cos(2*q(3)+2*q(2))-2*l(1)*l(2)*l(3)^2*cos(2*q(3)+q(2))-2*l(1)^2*l(2)*l(3)*cos(q(3)+2*q(2))-2*l(2)^2*l(3)^2*cos(2*q(3))+2*l(1)^2*l(2)*l(3)*cos(q(3))-l(1)^2*l(2)^2*cos(2*q(2))+2*l(1)*l(2)*l(3)^2*cos(q(2))+(2*l(2)^2+2*l(1)^2) *l(3)^2+l(1)^2*l(2)^2));
                -((sqrt(2)*l(1)*l(3)*sin(q(3)+q(2))+sqrt(2)*l(2)*l(3)*sin( q(3)))*sqrt(-2*l(1)^2*l(3)^2*cos(2*q(3)+2*q(2))-2*l(1)*l(2)*l(3)^2*cos(2*q(3)+q(2))-2*l(1)^2*l(2)*l(3)*cos(q(3)+2*q(2))-2*l(2)^2*l(3)^2*cos(2*q(3))+2*l(1)^2*l(2)*l(3)*cos(q(3))-l(1)^2*l(2)^2*cos(2*q(2))+2*l(1)*l(2)*l(3)^2*cos(q(2))+(2*l(2)^2+2*l(1)^2)*l(3)^2+l(1)^2*l(2)^2))/(2*l(1)^2*l(3)^2*cos(2*q(3)+2*q(2))+2*l(1)*l(2)*l(3)^2*cos(2*q(3)+q(2))+2*l(1)^2*l(2)*l(3)*cos(q(3)+2*q(2))+2*l(2)^2*l(3)^2*cos(2*q(3))-2*l(1)^2*l(2)*l(3)*cos(q(3))+l(1)^2*l(2)^2*cos(2*q(2))-2*l(1)*l(2)*l(3)^2*cos(q(2))+(-2*l(2)^2-2*l(1)^2)*l(3)^2-l(1)^2*l(2)^2);
                ((sqrt(2)*l(1)*l(3)*sin(q(3)+q(2))+sqrt(2)*l(1)*l(2)*sin(q(2)))*sqrt(-2*l(1)^2*l(3)^2*cos(2*q(3)+2*q(2))-2*l(1)*l(2)*l(3)^2*cos(2*q(3)+q(2))-2*l(1)^2*l(2)*l(3)*cos(q(3)+2*q(2))-2*l(2)^2*l(3)^2*cos(2*q(3))+2*l(1)^2*l(2)*l(3)*cos(q(3))-l(1)^2*l(2)^2*cos(2*q(2))+2*l(1)*l(2)*l(3)^2*cos(q(2))+(2*l(2)^2+2*l(1)^2)*l(3)^2+l(1)^2*l(2)^2))/(2*l(1)^2*l(3)^2*cos(2*q(3)+2*q(2))+2*l(1)*l(2)*l(3)^2*cos(2*q(3)+q(2))+2*l(1)^2*l(2)*l(3)*cos(q(3)+2*q(2))+2*l(2)^2*l(3)^2*cos(2*q(3))-2*l(1)^2*l(2)*l(3)*cos(q(3))+l(1)^2*l(2)^2*cos(2*q(2))-2*l(1)*l(2)*l(3)^2*cos(q(2))+(-2*l(2)^2-2*l(1)^2)*l(3)^2-l(1)^2*l(2)^2)
            ];
        
%         % J�ɂ��U�̓��o
%         v = [ J(1,3)*J(2,2)-J(1,2)*J(2,3)   ;
%               J(1,1)*J(2,3)-J(1,3)*J(2,1)   ;
%               J(1,2)*J(2,1)-J(1,1)*J(2,2)   ];
%         U = v/norm(v);
        
    otherwise
        error('error f3L_Jacobi_minus');
end
        
end