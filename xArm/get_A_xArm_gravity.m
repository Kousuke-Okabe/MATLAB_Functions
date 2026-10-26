function[A] = get_A_xArm_gravity(q)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   [A] = get_A_xArm_gravity(q)
%
%       % x = [ m6;           %  1
%               m6*lg6x;      %  2
%               m6*lg6y;      %  3
%               m6*lg6z;      %  4
%               m5;           %  5
%               m5*lg5x;      %  6
%               m5*lg5y;      %  7
%               m5*lg5z;      %  8
%               m4;           %  9
%               m4*lg4x;      % 10
%               m4*lg4y;      % 11
%               m4*lg4z;      % 12
%               m3;           % 13
%               m3*lg3x;      % 14
%               m3*lg3y;      % 15
%               m2*lg2x;      % 16
%               m2*lg2y ];    % 17
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

q1 = q(1);
q2 = q(2);
q3 = q(3);
q4 = q(4);
q5 = q(5);
q6 = q(6);

% m1 = 6;
% m2 = 5;
% m3 = 4;
% m4 = 3;
% m5 = 2;
% m6 = 7;
% 
% lg1x = 3;
% lg1y = 4;
% lg1z = 5;
% lg2x = 3;
% lg2y = 4;
% lg2z = 5;
% lg3x = 3;
% lg3y = 4;
% lg3z = 5;
% lg4x = 3;
% lg4y = 4;
% lg4z = 5;
% lg5x = 3;
% lg5y = 4;
% lg5z = 5;
% lg6x = 3;
% lg6y = 4;
% lg6z = 5;

% Parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
d1 = 276/1000;
d2 = 0;
d3 = 0;
d4 = 342.5/1000;
d5 = 0;
d6 = 97/1000;

al1 = 0;
al2 = -pi/2;
al3 = 0;
al4 = -pi/2;
al5 = pi/2;
al6 = -pi/2;

a1 = 0;
a2 = 0;
a3 = 289.48866/1000;
a4 = 77.5/1000;
a5 = 0;
a6 = 76/1000;

of1 = 0;
of2 = -1.3849179;
of3 = 1.3849179;
of4 = 0;
of5 = 0;
of6 = 0;

g = 9.8;


% Matrix tau = Ax %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% x = [ m6;           %  1
%       m6*lg6x;      %  2
%       m6*lg6y;      %  3
%       m6*lg6z;      %  4
%       m5;           %  5
%       m5*lg5x;      %  6
%       m5*lg5y;      %  7
%       m5*lg5z;      %  8
%       m4;           %  9
%       m4*lg4x;      % 10
%       m4*lg4y;      % 11
%       m4*lg4z;      % 12
%       m3;           % 13
%       m3*lg3x;      % 14
%       m3*lg3y;      % 15
%       m2*lg2x;      % 16
%       m2*lg2y ];    % 17

A = nan(6,17);

A(1, 1) = 0;
A(1, 2) = 0;
A(1, 3) = 0;
A(1, 4) = 0;
A(1, 5) = 0;
A(1, 6) = 0;
A(1, 7) = 0;
A(1, 8) = 0;
A(1, 9) = 0;
A(1,10) = 0;
A(1,11) = 0;
A(1,12) = 0;
A(1,13) = 0;
A(1,14) = 0;
A(1,15) = 0;
A(1,16) = 0;
A(1,17) = 0;

A(2, 1) = ((d6*g*cos(q2+of2)*cos(q3+of3)-d6*g*sin(q2+of2)*sin(q3+of3))*cos(q4)+a6*g*cos(q2+of2)*sin(q3+of3)+a6*g*sin(q2+of2)*cos(q3+of3))*sin(q5)+((a6*g*sin(q2+of2)*sin(q3+of3)-a6*g*cos(q2+of2)*cos(q3+of3))*cos(q4)+d6*g*cos(q2+of2)*sin(q3+of3)+d6*g*sin(q2+of2)*cos(q3+of3))*cos(q5)+(a4*g*sin(q2+of2)+d4*g*cos(q2+of2))*sin(q3+of3)+(d4*g*sin(q2+of2)-a4*g*cos(q2+of2))*cos(q3+of3)-a3*g*cos(q2+of2);
A(2, 2) = g*(sin(q2+of2)*(sin(q3+of3)*(cos(q4)*cos(q5)*cos(q6)-sin(q4)*sin(q6))+cos(q3+of3)*sin(q5)*cos(q6))-cos(q2+of2)*(cos(q3+of3)*(cos(q4)*cos(q5)*cos(q6)-sin(q4)*sin(q6))-sin(q3+of3)*sin(q5)*cos(q6)));
A(2, 3) = g*(sin(q2+of2)*(sin(q3+of3)*(-cos(q4)*cos(q5)*sin(q6)-sin(q4)*cos(q6))-cos(q3+of3)*sin(q5)*sin(q6))-cos(q2+of2)*(cos(q3+of3)*(-cos(q4)*cos(q5)*sin(q6)-sin(q4)*cos(q6))+sin(q3+of3)*sin(q5)*sin(q6)));
A(2, 4) = g*(sin(q2+of2)*(cos(q3+of3)*cos(q5)-sin(q3+of3)*cos(q4)*sin(q5))-cos(q2+of2)*(-cos(q3+of3)*cos(q4)*sin(q5)-sin(q3+of3)*cos(q5)));
A(2, 5) = (a4*g*sin(q2+of2)+d4*g*cos(q2+of2))*sin(q3+of3)+(d4*g*sin(q2+of2)-a4*g*cos(q2+of2))*cos(q3+of3)-a3*g*cos(q2+of2);
A(2, 6) = g*(sin(q2+of2)*(cos(q3+of3)*sin(q5)+sin(q3+of3)*cos(q4)*cos(q5))-cos(q2+of2)*(cos(q3+of3)*cos(q4)*cos(q5)-sin(q3+of3)*sin(q5)));
A(2, 7) = g*(sin(q2+of2)*(cos(q3+of3)*cos(q5)-sin(q3+of3)*cos(q4)*sin(q5))-cos(q2+of2)*(-cos(q3+of3)*cos(q4)*sin(q5)-sin(q3+of3)*cos(q5)));
A(2, 8) = g*(sin(q2+of2)*sin(q3+of3)*sin(q4)-cos(q2+of2)*cos(q3+of3)*sin(q4));
A(2, 9) = (a4*g*sin(q2+of2)+d4*g*cos(q2+of2))*sin(q3+of3)+(d4*g*sin(q2+of2)-a4*g*cos(q2+of2))*cos(q3+of3)-a3*g*cos(q2+of2);
A(2,10) = g*(sin(q2+of2)*sin(q3+of3)*cos(q4)-cos(q2+of2)*cos(q3+of3)*cos(q4));
A(2,11) = g*(cos(q2+of2)*cos(q3+of3)*sin(q4)-sin(q2+of2)*sin(q3+of3)*sin(q4));
A(2,12) = g*(cos(q2+of2)*sin(q3+of3)+sin(q2+of2)*cos(q3+of3));
A(2,13) = -a3*g*cos(q2+of2);
A(2,14) = g*(sin(q2+of2)*sin(q3+of3)-cos(q2+of2)*cos(q3+of3));
A(2,15) = g*(cos(q2+of2)*sin(q3+of3)+sin(q2+of2)*cos(q3+of3));
A(2,16) = -g*cos(q2+of2);
A(2,17) = g*sin(q2+of2);

A(3, 1) = ((d6*g*cos(q2+of2)*cos(q3+of3)-d6*g*sin(q2+of2)*sin(q3+of3))*cos(q4)+a6*g*cos(q2+of2)*sin(q3+of3)+a6*g*sin(q2+of2)*cos(q3+of3))*sin(q5)+((a6*g*sin(q2+of2)*sin(q3+of3)-a6*g*cos(q2+of2)*cos(q3+of3))*cos(q4)+d6*g*cos(q2+of2)*sin(q3+of3)+d6*g*sin(q2+of2)*cos(q3+of3))*cos(q5)+(a4*g*sin(q2+of2)+d4*g*cos(q2+of2))*sin(q3+of3)+(d4*g*sin(q2+of2)-a4*g*cos(q2+of2))*cos(q3+of3);
A(3, 2) = g*(-sin(q2+of2)*(-sin(q3+of3)*(cos(q4)*cos(q5)*cos(q6)-sin(q4)*sin(q6))-cos(q3+of3)*sin(q5)*cos(q6))-cos(q2+of2)*(cos(q3+of3)*(cos(q4)*cos(q5)*cos(q6)-sin(q4)*sin(q6))-sin(q3+of3)*sin(q5)*cos(q6)));
A(3, 3) = g*(-sin(q2+of2)*(cos(q3+of3)*sin(q5)*sin(q6)-sin(q3+of3)*(-cos(q4)*cos(q5)*sin(q6)-sin(q4)*cos(q6)))-cos(q2+of2)*(cos(q3+of3)*(-cos(q4)*cos(q5)*sin(q6)-sin(q4)*cos(q6))+sin(q3+of3)*sin(q5)*sin(q6)));
A(3, 4) = g*(-sin(q2+of2)*(sin(q3+of3)*cos(q4)*sin(q5)-cos(q3+of3)*cos(q5))-cos(q2+of2)*(-cos(q3+of3)*cos(q4)*sin(q5)-sin(q3+of3)*cos(q5)));
A(3, 5) = (a4*g*sin(q2+of2)+d4*g*cos(q2+of2))*sin(q3+of3)+(d4*g*sin(q2+of2)-a4*g*cos(q2+of2))*cos(q3+of3);
A(3, 6) = g*(-cos(q2+of2)*(cos(q3+of3)*cos(q4)*cos(q5)-sin(q3+of3)*sin(q5))-sin(q2+of2)*(-cos(q3+of3)*sin(q5)-sin(q3+of3)*cos(q4)*cos(q5)));
A(3, 7) = g*(-sin(q2+of2)*(sin(q3+of3)*cos(q4)*sin(q5)-cos(q3+of3)*cos(q5))-cos(q2+of2)*(-cos(q3+of3)*cos(q4)*sin(q5)-sin(q3+of3)*cos(q5)));
A(3, 8) = g*(sin(q2+of2)*sin(q3+of3)*sin(q4)-cos(q2+of2)*cos(q3+of3)*sin(q4));
A(3, 9) = (a4*g*sin(q2+of2)+d4*g*cos(q2+of2))*sin(q3+of3)+(d4*g*sin(q2+of2)-a4*g*cos(q2+of2))*cos(q3+of3);
A(3,10) = g*(sin(q2+of2)*sin(q3+of3)*cos(q4)-cos(q2+of2)*cos(q3+of3)*cos(q4));
A(3,11) = g*(cos(q2+of2)*cos(q3+of3)*sin(q4)-sin(q2+of2)*sin(q3+of3)*sin(q4));
A(3,12) = g*(cos(q2+of2)*sin(q3+of3)+sin(q2+of2)*cos(q3+of3));
A(3,13) = 0;
A(3,14) = g*(sin(q2+of2)*sin(q3+of3)-cos(q2+of2)*cos(q3+of3));
A(3,15) = g*(cos(q2+of2)*sin(q3+of3)+sin(q2+of2)*cos(q3+of3));
A(3,16) = 0;
A(3,17) = 0;

A(4, 1) = (-d6*g*cos(q2+of2)*sin(q3+of3)-d6*g*sin(q2+of2)*cos(q3+of3))*sin(q4)*sin(q5)+(a6*g*cos(q2+of2)*sin(q3+of3)+a6*g*sin(q2+of2)*cos(q3+of3))*sin(q4)*cos(q5);
A(4, 2) = g*(-cos(q2+of2)*sin(q3+of3)*(-cos(q4)*sin(q6)-sin(q4)*cos(q5)*cos(q6))-sin(q2+of2)*cos(q3+of3)*(-cos(q4)*sin(q6)-sin(q4)*cos(q5)*cos(q6)));
A(4, 3) = g*(-cos(q2+of2)*sin(q3+of3)*(sin(q4)*cos(q5)*sin(q6)-cos(q4)*cos(q6))-sin(q2+of2)*cos(q3+of3)*(sin(q4)*cos(q5)*sin(q6)-cos(q4)*cos(q6)));
A(4, 4) = g*(-cos(q2+of2)*sin(q3+of3)*sin(q4)*sin(q5)-sin(q2+of2)*cos(q3+of3)*sin(q4)*sin(q5));
A(4, 5) = 0;
A(4, 6) = g*(cos(q2+of2)*sin(q3+of3)*sin(q4)*cos(q5)+sin(q2+of2)*cos(q3+of3)*sin(q4)*cos(q5));
A(4, 7) = g*(-cos(q2+of2)*sin(q3+of3)*sin(q4)*sin(q5)-sin(q2+of2)*cos(q3+of3)*sin(q4)*sin(q5));
A(4, 8) = g*(-cos(q2+of2)*sin(q3+of3)*cos(q4)-sin(q2+of2)*cos(q3+of3)*cos(q4));
A(4, 9) = 0;
A(4,10) = g*(cos(q2+of2)*sin(q3+of3)*sin(q4)+sin(q2+of2)*cos(q3+of3)*sin(q4));
A(4,11) = g*(cos(q2+of2)*sin(q3+of3)*cos(q4)+sin(q2+of2)*cos(q3+of3)*cos(q4));
A(4,12) = 0;
A(4,13) = 0;
A(4,14) = 0;
A(4,15) = 0;
A(4,16) = 0;
A(4,17) = 0;

A(5, 1) = ((a6*g*cos(q2+of2)*sin(q3+of3)+a6*g*sin(q2+of2)*cos(q3+of3))*cos(q4)-d6*g*sin(q2+of2)*sin(q3+of3)+d6*g*cos(q2+of2)*cos(q3+of3))*sin(q5)+((d6*g*cos(q2+of2)*sin(q3+of3)+d6*g*sin(q2+of2)*cos(q3+of3))*cos(q4)+a6*g*sin(q2+of2)*sin(q3+of3)-a6*g*cos(q2+of2)*cos(q3+of3))*cos(q5);
A(5, 2) = g*(-cos(q2+of2)*(cos(q3+of3)*cos(q5)*cos(q6)-sin(q3+of3)*cos(q4)*sin(q5)*cos(q6))-sin(q2+of2)*(-cos(q3+of3)*cos(q4)*sin(q5)*cos(q6)-sin(q3+of3)*cos(q5)*cos(q6)));
A(5, 3) = g*(-cos(q2+of2)*(sin(q3+of3)*cos(q4)*sin(q5)*sin(q6)-cos(q3+of3)*cos(q5)*sin(q6))-sin(q2+of2)*(cos(q3+of3)*cos(q4)*sin(q5)*sin(q6)+sin(q3+of3)*cos(q5)*sin(q6)));
A(5, 4) = g*(-sin(q2+of2)*(sin(q3+of3)*sin(q5)-cos(q3+of3)*cos(q4)*cos(q5))-cos(q2+of2)*(-cos(q3+of3)*sin(q5)-sin(q3+of3)*cos(q4)*cos(q5)));
A(5, 5) = 0;
A(5, 6) = g*(-cos(q2+of2)*(cos(q3+of3)*cos(q5)-sin(q3+of3)*cos(q4)*sin(q5))-sin(q2+of2)*(-cos(q3+of3)*cos(q4)*sin(q5)-sin(q3+of3)*cos(q5)));
A(5, 7) = g*(-sin(q2+of2)*(sin(q3+of3)*sin(q5)-cos(q3+of3)*cos(q4)*cos(q5))-cos(q2+of2)*(-cos(q3+of3)*sin(q5)-sin(q3+of3)*cos(q4)*cos(q5)));
A(5, 8) = 0;
A(5, 9) = 0;
A(5,10) = 0;
A(5,11) = 0;
A(5,12) = 0;
A(5,13) = 0;
A(5,14) = 0;
A(5,15) = 0;
A(5,16) = 0;
A(5,17) = 0;

A(6, 1) = 0;
A(6, 2) = g*(-cos(q2+of2)*(sin(q3+of3)*(-cos(q4)*cos(q5)*sin(q6)-sin(q4)*cos(q6))-cos(q3+of3)*sin(q5)*sin(q6))-sin(q2+of2)*(cos(q3+of3)*(-cos(q4)*cos(q5)*sin(q6)-sin(q4)*cos(q6))+sin(q3+of3)*sin(q5)*sin(q6)));
A(6, 3) = g*(-cos(q2+of2)*(sin(q3+of3)*(sin(q4)*sin(q6)-cos(q4)*cos(q5)*cos(q6))-cos(q3+of3)*sin(q5)*cos(q6))-sin(q2+of2)*(cos(q3+of3)*(sin(q4)*sin(q6)-cos(q4)*cos(q5)*cos(q6))+sin(q3+of3)*sin(q5)*cos(q6)));
A(6, 4) = 0;
A(6, 5) = 0;
A(6, 6) = 0;
A(6, 7) = 0;
A(6, 8) = 0;
A(6, 9) = 0;
A(6,10) = 0;
A(6,11) = 0;
A(6,12) = 0;
A(6,13) = 0;
A(6,14) = 0;
A(6,15) = 0;
A(6,16) = 0;
A(6,17) = 0;

% % Gravity torque vector %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tau_g = nan(6,1);
% 
% tau_g(1) = 0;
% tau_g(2) = g*m6*(sin(q2+of2)*(sin(q3+of3)*(cos(q4)*(cos(q5)*(-lg6y*sin(q6)+lg6x*cos(q6)+a6)-(lg6z+d6)*sin(q5))-sin(q4)*(lg6x*sin(q6)+lg6y*cos(q6))+a4)+cos(q3+of3)*(sin(q5)*(-lg6y*sin(q6)+lg6x*cos(q6)+a6)+(lg6z+d6)*cos(q5)+d4))-cos(q2+of2)*(cos(q3+of3)*(cos(q4)*(cos(q5)*(-lg6y*sin(q6)+lg6x*cos(q6)+a6)-(lg6z+d6)*sin(q5))-sin(q4)*(lg6x*sin(q6)+lg6y*cos(q6))+a4)-sin(q3+of3)*(sin(q5)*(-lg6y*sin(q6)+lg6x*cos(q6)+a6)+(lg6z+d6)*cos(q5)+d4)+a3))+g*m5*(sin(q2+of2)*(sin(q3+of3)*(cos(q4)*(lg5x*cos(q5)-lg5y*sin(q5))+lg5z*sin(q4)+a4)+cos(q3+of3)*(lg5x*sin(q5)+lg5y*cos(q5)+d4))-cos(q2+of2)*(cos(q3+of3)*(cos(q4)*(lg5x*cos(q5)-lg5y*sin(q5))+lg5z*sin(q4)+a4)-sin(q3+of3)*(lg5x*sin(q5)+lg5y*cos(q5)+d4)+a3))+g*m4*(sin(q2+of2)*(sin(q3+of3)*(-lg4y*sin(q4)+lg4x*cos(q4)+a4)+(lg4z+d4)*cos(q3+of3))-cos(q2+of2)*(cos(q3+of3)*(-lg4y*sin(q4)+lg4x*cos(q4)+a4)-(lg4z+d4)*sin(q3+of3)+a3))+g*m3*(sin(q2+of2)*(lg3x*sin(q3+of3)+lg3y*cos(q3+of3))-cos(q2+of2)*(-lg3y*sin(q3+of3)+lg3x*cos(q3+of3)+a3))+g*m2*(lg2y*sin(q2+of2)-lg2x*cos(q2+of2));
% tau_g(3) = g*m6*(-sin(q2+of2)*(-sin(q3+of3)*(cos(q4)*(cos(q5)*(-lg6y*sin(q6)+lg6x*cos(q6)+a6)-(lg6z+d6)*sin(q5))-sin(q4)*(lg6x*sin(q6)+lg6y*cos(q6))+a4)-cos(q3+of3)*(sin(q5)*(-lg6y*sin(q6)+lg6x*cos(q6)+a6)+(lg6z+d6)*cos(q5)+d4))-cos(q2+of2)*(cos(q3+of3)*(cos(q4)*(cos(q5)*(-lg6y*sin(q6)+lg6x*cos(q6)+a6)-(lg6z+d6)*sin(q5))-sin(q4)*(lg6x*sin(q6)+lg6y*cos(q6))+a4)-sin(q3+of3)*(sin(q5)*(-lg6y*sin(q6)+lg6x*cos(q6)+a6)+(lg6z+d6)*cos(q5)+d4)))+g*m5*(-sin(q2+of2)*(-sin(q3+of3)*(cos(q4)*(lg5x*cos(q5)-lg5y*sin(q5))+lg5z*sin(q4)+a4)-cos(q3+of3)*(lg5x*sin(q5)+lg5y*cos(q5)+d4))-cos(q2+of2)*(cos(q3+of3)*(cos(q4)*(lg5x*cos(q5)-lg5y*sin(q5))+lg5z*sin(q4)+a4)-sin(q3+of3)*(lg5x*sin(q5)+lg5y*cos(q5)+d4)))+g*m4*(-sin(q2+of2)*(-sin(q3+of3)*(-lg4y*sin(q4)+lg4x*cos(q4)+a4)-(lg4z+d4)*cos(q3+of3))-cos(q2+of2)*(cos(q3+of3)*(-lg4y*sin(q4)+lg4x*cos(q4)+a4)-(lg4z+d4)*sin(q3+of3)))+g*m3*(-cos(q2+of2)*(lg3x*cos(q3+of3)-lg3y*sin(q3+of3))-sin(q2+of2)*(-lg3x*sin(q3+of3)-lg3y*cos(q3+of3)));
% tau_g(4) = g*m6*(-cos(q2+of2)*sin(q3+of3)*(-sin(q4)*(cos(q5)*(-lg6y*sin(q6)+lg6x*cos(q6)+a6)-(lg6z+d6)*sin(q5))-cos(q4)*(lg6x*sin(q6)+lg6y*cos(q6)))-sin(q2+of2)*cos(q3+of3)*(-sin(q4)*(cos(q5)*(-lg6y*sin(q6)+lg6x*cos(q6)+a6)-(lg6z+d6)*sin(q5))-cos(q4)*(lg6x*sin(q6)+lg6y*cos(q6))))+g*m5*(-cos(q2+of2)*sin(q3+of3)*(lg5z*cos(q4)-sin(q4)*(lg5x*cos(q5)-lg5y*sin(q5)))-sin(q2+of2)*cos(q3+of3)*(lg5z*cos(q4)-sin(q4)*(lg5x*cos(q5)-lg5y*sin(q5))))+g*m4*(-cos(q2+of2)*sin(q3+of3)*(-lg4x*sin(q4)-lg4y*cos(q4))-sin(q2+of2)*cos(q3+of3)*(-lg4x*sin(q4)-lg4y*cos(q4)));
% tau_g(5) = g*m6*(-cos(q2+of2)*(sin(q3+of3)*cos(q4)*(-sin(q5)*(-lg6y*sin(q6)+lg6x*cos(q6)+a6)-(lg6z+d6)*cos(q5))+cos(q3+of3)*(cos(q5)*(-lg6y*sin(q6)+lg6x*cos(q6)+a6)-(lg6z+d6)*sin(q5)))-sin(q2+of2)*(cos(q3+of3)*cos(q4)*(-sin(q5)*(-lg6y*sin(q6)+lg6x*cos(q6)+a6)-(lg6z+d6)*cos(q5))-sin(q3+of3)*(cos(q5)*(-lg6y*sin(q6)+lg6x*cos(q6)+a6)-(lg6z+d6)*sin(q5))))+g*m5*(-sin(q2+of2)*(cos(q3+of3)*cos(q4)*(-lg5x*sin(q5)-lg5y*cos(q5))-sin(q3+of3)*(lg5x*cos(q5)-lg5y*sin(q5)))-cos(q2+of2)*(cos(q3+of3)*(lg5x*cos(q5)-lg5y*sin(q5))+sin(q3+of3)*cos(q4)*(-lg5x*sin(q5)-lg5y*cos(q5))));
% tau_g(6) = g*m6*(-cos(q2+of2)*(sin(q3+of3)*(cos(q4)*cos(q5)*(-lg6x*sin(q6)-lg6y*cos(q6))-sin(q4)*(lg6x*cos(q6)-lg6y*sin(q6)))+cos(q3+of3)*sin(q5)*(-lg6x*sin(q6)-lg6y*cos(q6)))-sin(q2+of2)*(cos(q3+of3)*(cos(q4)*cos(q5)*(-lg6x*sin(q6)-lg6y*cos(q6))-sin(q4)*(lg6x*cos(q6)-lg6y*sin(q6)))-sin(q3+of3)*sin(q5)*(-lg6x*sin(q6)-lg6y*cos(q6))));