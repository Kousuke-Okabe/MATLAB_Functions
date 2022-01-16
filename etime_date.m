function[] = etime_date(t0)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   [] = etime_date(t0)
%
%       t0 : Time of program starting
%
%                                                       16.06.22. by.OKB
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
t1 = clock;
edata = etime(t1,t0);
% edata = 3*60*60*24 + 1*60*60 + 30*60 + 25;

sec = rem(edata, 60);
min = rem(edata-sec, 60*60)/60;
hour = rem(edata-sec-min*60, 60*60*24)/(60*60);
day = floor( (edata-sec-min*60-hour*60*60)/(60*60*24) );

disp([ num2str(day),'day ', num2str(hour),'h ',num2str(min),'m ',num2str(floor(sec)),'s' ])

end