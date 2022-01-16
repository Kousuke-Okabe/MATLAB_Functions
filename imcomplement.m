function[Re] = imcomplement(X)

Re = X;
[a,b] = size(X);

for i = 1:a
    for j = 1:b
        if X(i,j) > 0
            Re(i,j) = 0;
        else
            Re(i,j) = 1;
        end
    end
end

end