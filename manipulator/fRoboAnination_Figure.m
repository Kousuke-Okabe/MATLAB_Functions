function[] = fRoboAmination_Figure(FH)

%**************************************************************************
%
%   [] = fRoboAmination_Figure(FH)
%
%                                                       19.09.12 by OKB
%**************************************************************************

% %%
% clear
% r = [ 0.1; 0.2 ];
% Rx = pi;
% [q, error] = f3L_iKinematics(r,Rx);
% Ts = 0.001;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(FH)
%     clf(FH)
    hold on
    axis equal
    box on
    xlim([-0.1, 0.3])
    ylim([-0.1, 0.3])
    
    xlabel('$$x$$ [m]', 'FontSize',21, 'interpreter','latex')
    ylabel('$$y$$ [m]', 'FontSize',21, 'interpreter','latex')
    zlabel('$$x$$ [m]', 'FontSize',21, 'interpreter','latex')
%     grid on
    Color = [1,1,1]*0.5;


end
