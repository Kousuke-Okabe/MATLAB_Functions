function[dec] = bi2de(bin)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   [dec] = bi2de(bin)
%
%       bin     : 2進数配列
%       dec     : 10進　整数値
%                                                       16.04.13 by.OKB
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[row,col] = size(bin);
if col < row
    bin = bin';
end
bin = round(bin);

dec = 0;
for i = 1:length(bin)
    dec = dec + 2^(i-1)*bin(1,i);
end

end