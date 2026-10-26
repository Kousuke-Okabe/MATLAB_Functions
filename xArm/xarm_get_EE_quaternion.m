function[quat] = xarm_get_EE_quaternion(q)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   [quat] = xarm_get_EE_quaternion(q)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

draw = 0;

% %%
% clear
% 
% q = [
%     -30
%     30
%     0
%     0
%     0
%     0
% ]/180*pi;
% 
% draw = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

alpha = [0; -pi/2; 0; -pi/2; pi/2; -pi/2];
T_off = [0; -1.3849179; 1.3849179; 0; 0; 0; ];

% alpha = [0; -pi/2; 0; -pi/2; pi/2; -pi/2];
% T_off = [0; 0; 0; 0; 0; 0; ];

lx = [1;0;0];
ly = [0;1;0];
lz = [0;0;1];

quat = quaternion(1,0,0,0);

for j = 1:6
    qa = quaternion(cos(alpha(j)/2), ...
                    lx(1)*sin(alpha(j)/2), ...
                    lx(2)*sin(alpha(j)/2), ...
                    lx(3)*sin(alpha(j)/2) ...
        );
    qo = quaternion(cos(T_off(j)/2), ...
                    lz(1)*sin(T_off(j)/2), ...
                    lz(2)*sin(T_off(j)/2), ...
                    lz(3)*sin(T_off(j)/2) ...
        );
    qt = quaternion(cos(q(j)/2), ...
                    lz(1)*sin(q(j)/2), ...
                    lz(2)*sin(q(j)/2), ...
                    lz(3)*sin(q(j)/2) ...
        );

    % quat = qt*qo*qa*quat;
    quat = quat*qa*qo*qt;
end

if draw == 1
    % Plot quaternion
    figure(1)
    clf(1)
    hold on
    quiver3(0,0,0, 1,0,0,'b')
    quiver3(0,0,0, 0,1,0,'b')
    quiver3(0,0,0, 0,0,1,'b')
    xlabel('x')
    xlabel('y')
    xlabel('z')
    axis equal
    grid on
    box on
    view([30,20])

    E = quaternion([zeros(3,1),eye(3)]);
    E = quat*E*conj(quat);

    for i = 1:3
        [w,x,y,z] = parts(E(i));
        quiver3(0,0,0, x,y,z,'r')
        text(x,y,z,num2str(i))
    end
end

end