function[Vt] = get_TranslateVector(q,dx)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   [Vt = get_TranslateVector(x,dx)
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% clear
% 
% x = [ 0.2; 0.2, pi/6 ];
% dx = [ 0; 0; 0 ];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

param = get_parameter();
    N = param.Link;

[J,Jp,Jd,U,Ud,err] = fJacobi_tensor_q(q);
Je = [J;U'];
Jei = [Jp,U];


dq = Jei*dx;
[M,h,g,hd] = get_matrix_plus(q,dq);

% Transpose Vector of DMP
Jed = Jd;
Jed(3,:,:) = Ud;

Jck = zeros(N,N,N);
Jch = zeros(N,N,N);
Mi =inv(M);
for i = 1:N
    for j = 1:N
        for k = 1:N
            for n = 1:N
                for o = 1:N
                    Jck(i,n,o) = Jck(i,n,o) + Jed(i,j,k)*Jei(j,n)*Jei(k,o);
                end
            end
        end
    end
end
for i = 1:N
    for j = 1:N
        for k = 1:N
            for l = 1:N
                for m = 1:N
                    for n = 1:N
                        for o = 1:N
                            Jch(i,n,o) = Jch(i,n,o) - Je(i,j)*Mi(j,k)*hd(k,l,m)*Jei(l,n)*Jei(m,o);
                        end
                    end
                end
            end
        end
    end
end

DMP_ck = zeros(N,1);
DMP_ch = zeros(N,1);
for i = 1:N
    for j = 1:N
        for k = 1:N
            DMP_ch(i) = DMP_ch(i) + Jch(i,j,k)*dx(j)*dx(k);
            DMP_ck(i) = DMP_ck(i) + Jck(i,j,k)*dx(j)*dx(k);
        end
    end
end

% DMP_ch
% norm(DMP_ch)
% DMP_ck
% norm(DMP_ck)

Vt = DMP_ch + DMP_ck;
    
end
    
