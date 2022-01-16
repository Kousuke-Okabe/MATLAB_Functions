function[oStruct] = sort_struct(iStruct,field)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   [oStruct] = sort_struct(iStruct,field)
%
%   iStruct(i)ÇÃç\ë¢ëÃÇfieldÇÃílÇ≈ç~èáÇ≈ï¿Ç◊ë÷Ç¶
%
%       oStruct     : Output structs sorted by value of 'field'
%       iStruct     : Input structs
%       field       : Sorting parameter
%
%                                                       16.06.20 by.OKB
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %%
% clear all
% 
% iStruct = struct('ds',[],'temp',[]);
% for i=1:10
%     iStruct(i).ds = rand(1);
%     iStruct(i).temp = i;
% end
% clearvars -except iStruct
% 
% field = 'ds';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

oStruct = iStruct;

lStruct = length(iStruct);
evaluate = nan(lStruct,1);

evaluate(1) = iStruct(1).(field);
oStruct(1) = iStruct(1);

for i = 2:lStruct       % Insart date
    F_sort = 0;
    for j = 1:i         % Conpared date
        if j == i && F_sort == 0
            evaluate(j) = iStruct(i).(field);
            oStruct(j) = iStruct(i);
        elseif F_sort == 0 && evaluate(j) < iStruct(i).(field)
            F_sort = 1;
            
            Etemp = evaluate(j);
            Stemp = oStruct(j);
            
            evaluate(j) = iStruct(i).(field);
            oStruct(j) = iStruct(i);
            
        elseif F_sort == 1
            Etemp_offhand = evaluate(j);
            Stemp_offhand = oStruct(j);
            
            evaluate(j) = Etemp;
            oStruct(j) = Stemp;
            
            Etemp = Etemp_offhand;
            Stemp = Stemp_offhand;
            
        end
    end
end

end
