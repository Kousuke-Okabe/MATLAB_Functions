function[J,Jp,U,err] = fJacobi(type, x)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   [J,Jp,U,error] = fJacobi(type, x)
%
%       x   : ���ʒu�@x=[x,y]'
%
%       J   : ���R�r�s��
%       Jp  : ���R�r�s��̋^���t�s��
%       U   : ���R�r�s��̐��K���������
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

draw = 0;

% %%
% clear
% 
% type = '2d_RRR'
% 
% x = [
%     0.2000;
%     0.2000;
%     1.0472
%     ];
% 
% draw = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

err = 0;

check = size(x,2);
if check ~= 1
    disp('error : f3L_Jacobi input')
    
    err = 1;
    return;
end


switch type

    case '2d_RRR'
        [q, err] = fIKinematics(type, x);
        [J,Jp,U,err] = fJacobi_q(type, q);
        
    otherwise
        error('error f3L_Jacobi_minus');
end
        
end
