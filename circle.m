function[] = circle(FH, p,r,ec,fc,lw)

%**************************************************************************
%
%   [] = circle(FH, p,r,ec,fc,lw)
%
%       FH      : フィギャーハンドル
%       q       : position = [x;y;z]
%       r       : 半径
%       ec      : Edge Color
%       fc      : Face Color
%       lw      : Line Width
%
%                                                       17.10.25 by OKB
%**************************************************************************

% %%
% clear
% 
% FH = 1;
% p = [1;1;0];
% r = 1;
% fc = 'w';
% ec = 'b';
% lw = 1.0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n = 25;
x = r*sin(linspace(0,2*pi,n))+p(1);
y = r*cos(linspace(0,2*pi,n))+p(2);
z = p(3)*ones(1,25);

figure(FH)
patch(x,y,z,fc, 'EdgeColor',ec, 'LineWidth',lw)
