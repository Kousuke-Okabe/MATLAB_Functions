function[q, error] = fIKinematics(type,r)

%**************************************************************************
%
%   [q, error] = fIKinematics(type,x)
%
%       x : 手先位置
%
%       ver0.1 : 逆運動学問題
%
%                                                       13.10.01 by OKB
%**************************************************************************

draw = 0;

% %%
% clear
% type = '2d_RRR'
% 
% r = [
%     0.2000;
%     0.2000;
%     1.0472
%     ];
% 
% draw = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% disp('fIKinematics')
% type
param = get_parameter(type);
Link = param.Link;
l = param.l;

error = 0;

q = zeros(Link,1);

[temp check] = size(r);
if check ~= 1
    disp('error : f3L_ikinematics input')
    return;
end


switch type

    case '3d_RRRR'
        % 空間4リンク
        x = r(1,1);
        y = r(2,1);
        z = r(3,1);
        
        q(3,1) = Rx(1,1);
        q(4,1) = -pi + acos( ((l(2)+l(3))^2+l(4)^2-x^2-y^2-(z-l(1))^2)/(2*l(4)*(l(2)+l(3))) );

        l5 = sqrt(x^2+y^2+(z-l(1))^2);
        q(2,1) = asin( (z-l(1))/(sqrt(l5^2-(l(4)*sin(q(3,1))*sin(q(4,1)))^2)) ) - atan2(cos(q(3,1))*sin(q(4,1)),1+cos(q(4,1))) - pi/2;

        th2 = atan2( (z-l(1)),(sqrt(x^2+y^2)) );
        q(1,1) = atan2(y,x) + asin( (l(4)*sin(q(3,1))*sin(q(4,1)))/(l5*cos(th2)) );

        if sum(abs(imag(q)))
            disp('error : out of range')
            error = 1;
        end






    case '3d_PRRR'
        % 直動スライダ空間4リンク
        x = r(1,1);
        y = r(2,1);
        z = r(3,1);

        q(2,1) = Rx;

        lxy = y/sin(q(2,1));
        l3d = sqrt( lxy^2+(z-l(1)-l(2))^2 );
        
        q(4,1) = acos( (l(3)^2+l(4)^2-l3d^2)/(2*l(3)*l(4)) ) - pi;
        q(3,1) = acos( (l(3)^2+l3d^2-l(4)^2)/(2*l(3)*l3d) ) + atan2(z-l(1)-l(2),lxy) - pi/2;

        q(1,1) = x -lxy*cos(q(2,1));

        if sum(isnan(q)) > 0 || sum(isinf(q)) >0 || sum(abs(imag(q))) > 0
            error = 1;
            return;
        end







    case '2d_RRR'
        % 平面3リンク
        k = 1;
        
        x = r(1,1);
        y = r(2,1);
        z = r(3,1);

        l1 = l(1);
        l2 = l(2);
        l3 = l(3);

        q(1,1) = atan2( y-l3*sin(z(1,1)),(x-l3*cos(z(1,1))) ) - k*real(acos( (l1^2-l2^2+l3^2+x^2+y^2-2*l3*(x*cos(z(1,1))+y*sin(z(1,1))))/(2*l1*sqrt(x^2+y^2+l3^2-2*l3*(x*cos(z(1,1))+y*sin(z(1,1))))) ));
        q(2,1) = k*(pi - real(acos( (l1^2+l2^2-l3^2-x^2-y^2+2*l3*(x*cos(z(1,1))+y*sin(z(1,1))))/(2*l1*l2) )));
        q(3,1) = z(1,1) -q(1,1) -q(2,1);

        if r(1:2)'*r(1:2) > sum(l)
            disp('error : out of range')
            error = 1;
        end





    case '2d_RRRR'
        % 作業空間[x,y,eta] + 内部運動
%         x = r(1);
%         y = r(2);
%         eta = r(3);
% 
%         l1 = l(1);
%         l2 = l(2);
%         l3 = l(3);
%         l4 = l(4);
% 
%         xdd = x - l3*cos(Rx) - l4*cos(eta);
%         ydd = y - l3*sin(Rx) - l4*sin(eta);
% 
%         q(1,1) = atan2(ydd,xdd) - real(acos( (l1^2-l2^2+xdd^2+ydd^2)/(2*l1*sqrt(xdd^2+ydd^2)) ));
%         q(2,1) = pi - real(acos( (l1^2+l2^2-xdd^2-ydd^2)/(2*l1*l2) ));
%         q(3,1) = Rx - q(1,1) - q(2,1);
%         q(4,1) = eta - Rx;
% 
%         if r(1:2,1).'*r(1:2,1) > sum(l)
%             disp('error f3L_iKinematics : out of range')
%             error = 1;
%         end

        % Main task 手先位置、 Sub task r2=第3関節位置
        type1 = '2d_RRRR';
        type2 = '2d_RR';
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

            q(:,k+1) = q(:,k) + ( Jp1*(r(1:2)-r1) + (I-Jp1*J1)*Jp2*(r(3:4)-r2) )/5;

            for i = 2:2:Link
                if q(i,k+1) < 0
                    q(i,k+1) = - q(i,k+1);
                elseif q(i,k+1) > pi
                    q(i,k+1) =  2*pi - q(i,k+1);
                end
            end
        end

        if draw == 1
            FH = 1;
            figure(FH)
            clf(FH)
            grid on
            fRoboAnimation(type1,FH,q(:,1:N), diag(r(1:2,1))*ones(2,N),0)
            q(:,k+1)
        end

        q = q(:,k+1);





    case '2d_RRRP'
        % 平面4関節　直動（ 0-0-0-=< ）
        x = r(1);
        y = r(2);
        eta = r(3);

        l1 = l(1);
        l2 = l(2);
        l3 = l(3);
        l4 = l(4);

        rd = [ x-(l3+l4+Rx)*cos(eta) ;
               y-(l3+l4+Rx)*sin(eta) ];

        K = sqrt( (rd(1)^2+rd(2)^2+l1^2+l2^2)^2 - 2*((rd(1)^2+rd(2)^2)^2+l1^4+l2^4) );
        if isreal(K) == 0
            disp('error f3L_iKinematics : out of range.')
            error = 1;

            return;
        end

        q(1) = atan2(rd(2),rd(1)) - atan2(K, rd(1)^2+rd(2)^2+l1^2-l2^2);
        q(2) = atan2(K, rd(1)^2+rd(2)^2-l1^2-l2^2);
        q(3) = eta-q(1)-q(2);
        q(4) = Rx;







    case '2d_RRP'
        % 平面3関節　直動（ 0-0-=< ）
        x = r(1);
        y = r(2);

        l1 = l(1);
        l2 = l(2);
        l3 = l(3);

        K = sqrt( (x^2+y^2+l1^2+(l2+l3+Rx)^2)^2 - 2*((x^2+y^2)^2+l1^4+(l2+l3+Rx)^4) );
        if isreal(K) == 0
            disp('error f3L_iKinematics : out of range.')
            error = 1;

            return;
        end

        q(1) = atan2(y,x) - atan2(K,x^2+y^2+l1^2-(l2+l3+Rx)^2);
        q(2) = atan2(K,x^2+y^2-l1^2-(l2+l3+Rx)^2);
        q(3) = Rx;



    otherwise
        error('error f3L_iKinematics');
    
end



if draw == 1
%     f3L_RoboAnimation_v3(q,r,0.001);
    fRoboAnimation(type,1,q,r(1:2),0);
end

end
