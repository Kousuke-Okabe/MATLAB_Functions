function[fs,df,ddf, r,dr,ddr, s,t, Ns,Ts, pName,dim] = get_reference(ds)

%**************************************************************************
%
%   [fs,df,ddf, r,dr,ddr, s,t, Ns,Ts, pName,dim] = get_reference(ds)
%
%       fs  : 手先軌道関数
%       df  : 手先速度関数
%       ddf : 手先加速度関数
%       r   : 手先軌道              r(2,Ns,n) = [r1,r2,...rn]
%       dr  : 手先速度
%       ddr : 手先加速度
%       s   : 軌跡上の位置軸         s = ds*t
%       cell: セル分割フラグ         cell = [1;0;1]   1:Difficult Part 0:Easy Part
%       Ns  : 軌道サンプル数         Ns = [Ns1;Ns2;...Nsn]
%       t   : 時間軸
%       Ts  : サンプリングタイム
%       pName : 軌道名
%                                                       14.01. by OKB
%**************************************************************************

draw = 0;

% %%
% disp('TEST MODE : get_reference')
% 
% clear all
% ds = 0.5;
% % 
% draw = 1;
% anime = 0;
% 
% FS = 17;
% FS_tex = 20;

%**************************************************************************

param = get_parameter;
    Fs = param.Fs;
    Ts = param.Ts;


% % 丸角四角 (RSJ2014)
% pName = 'RoundCornerSquare';
% dim = 2;
% dim_r = 2;
% 
% r_cell = nan(2,5000,8);
% dr_cell = nan(2,5000,8);
% ddr_cell = nan(2,5000,8);
% Ns_cell = nan(8,1);
% 
% R = 3/1000;
% C1 = [200;  0]/1000;
% C2 = [200; 50]/1000;
% C3 = [160; 50]/1000;
% C4 = [160;  0]/1000;
% % R = 1/1000;
% % C1 = [200;  0]/1000;
% % C2 = [200;100]/1000;
% % C3 = [100;100]/1000;
% % C4 = [100;  0]/1000;
% 
% [fs_t,df_t,ddf_t, r_t,dr_t,ddr_t, Ns_t,s] = fRef_Straight(ds,C1+[0;R],C2+[0;-R],Ts);
% Ns_cell(1) = Ns_t-1;
% r_cell(:,1:Ns_t-1,1) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,1) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,1) = ddr_t(:,1:Ns_t-1);
% 
% [fs_t,df_t,ddf_t, r_t,dr_t,ddr_t, Ns_t,s] = fRef_Arc2(ds,C2+[-R;-R],R,[0;pi/2],Fs);
% Ns_cell(2) = Ns_t-1;
% r_cell(:,1:Ns_t-1,2) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,2) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,2) = ddr_t(:,1:Ns_t-1);
% 
% [fs_t,df_t,ddf_t, r_t,dr_t,ddr_t, Ns_t,s] = fRef_Straight(ds,C2+[-R;0],C3+[R;0],Ts);
% Ns_cell(3) = Ns_t-1;
% r_cell(:,1:Ns_t-1,3) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,3) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,3) = ddr_t(:,1:Ns_t-1);
% 
% [fs_t,df_t,ddf_t, r_t,dr_t,ddr_t, Ns_t,s] = fRef_Arc2(ds,C3+[R;-R],R,[pi/2;pi],Fs);
% Ns_cell(4) = Ns_t-1;
% r_cell(:,1:Ns_t-1,4) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,4) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,4) = ddr_t(:,1:Ns_t-1);
% 
% [fs_t,df_t,ddf_t, r_t,dr_t,ddr_t, Ns_t,s] = fRef_Straight(ds,C3+[0;-R],C4+[0;R],Ts);
% Ns_cell(5) = Ns_t-1;
% r_cell(:,1:Ns_t-1,5) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,5) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,5) = ddr_t(:,1:Ns_t-1);
% 
% [fs_t,df_t,ddf_t, r_t,dr_t,ddr_t, Ns_t,s] = fRef_Arc2(ds,C4+[R;R],R,[pi;pi*3/2],Fs);
% Ns_cell(6) = Ns_t-1;
% r_cell(:,1:Ns_t-1,6) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,6) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,6) = ddr_t(:,1:Ns_t-1);
% 
% [fs_t,df_t,ddf_t, r_t,dr_t,ddr_t, Ns_t,s] = fRef_Straight(ds,C4+[R;0],C1+[-R;0],Ts);
% Ns_cell(7) = Ns_t-1;
% r_cell(:,1:Ns_t-1,7) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,7) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,7) = ddr_t(:,1:Ns_t-1);
% 
% [fs_t,df_t,ddf_t, r_t,dr_t,ddr_t, Ns_t,s] = fRef_Arc2(ds,C1+[-R;R],R,[-pi/2;0],Fs);
% Ns_cell(8) = Ns_t-1;
% r_cell(:,1:Ns_t-1,8) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,8) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,8) = ddr_t(:,1:Ns_t-1);










% % ROBOMECH2015
% pName = 'ROBOMECH2015';
% dim = 2;
% dim_r = 2;
% 
% r_cell = nan(2,5000,5);
% dr_cell = nan(2,5000,5);
% ddr_cell = nan(2,5000,5);
% Ns_cell = nan(5,1);
% 
% R = 2/1000;
% C1 = [200;  0]/1000;
% C2 = [200; 20]/1000;
% C3 = [180; 20]/1000;
% C4 = [180;  0]/1000;
% 
% [fs_t,df_t,ddf_t, r_t,dr_t,ddr_t, Ns_t,s] = fRef_Straight(ds,C1,C2+[0;-R],Ts);
% Ns_cell(1) = Ns_t-1;
% r_cell(:,1:Ns_t-1,1) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,1) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,1) = ddr_t(:,1:Ns_t-1);
% 
% [fs_t,df_t,ddf_t, r_t,dr_t,ddr_t, Ns_t,s] = fRef_Arc2(ds,C2+[-R;-R],R,[0;pi/2],Fs);
% Ns_cell(2) = Ns_t-1;
% r_cell(:,1:Ns_t-1,2) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,2) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,2) = ddr_t(:,1:Ns_t-1);
% 
% [fs_t,df_t,ddf_t, r_t,dr_t,ddr_t, Ns_t,s] = fRef_Straight(ds,C2+[-R;0],C3+[R;0],Ts);
% Ns_cell(3) = Ns_t-1;
% r_cell(:,1:Ns_t-1,3) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,3) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,3) = ddr_t(:,1:Ns_t-1);
% 
% [fs_t,df_t,ddf_t, r_t,dr_t,ddr_t, Ns_t,s] = fRef_Arc2(ds,C3+[R;-R],R,[pi/2;pi],Fs);
% Ns_cell(4) = Ns_t-1;
% r_cell(:,1:Ns_t-1,4) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,4) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,4) = ddr_t(:,1:Ns_t-1);
% 
% [fs_t,df_t,ddf_t, r_t,dr_t,ddr_t, Ns_t,s] = fRef_Straight(ds,C3+[0;-R],C4,Ts);
% Ns_cell(5) = Ns_t-1;
% r_cell(:,1:Ns_t-1,5) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,5) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,5) = ddr_t(:,1:Ns_t-1);












% % 丸角四角 (JRM2014)
% pName = 'JRM2014';
% dim = 2;
% 
% r_cell = nan(2,5000,3);
% dr_cell = nan(2,5000,3);
% ddr_cell = nan(2,5000,3);
% Ns_cell = nan(3,1);
% 
% R = 5/1000;
% C1 = [200;  0]/1000;
% C2 = [200; 20]/1000;
% C3 = [180; 20]/1000;
% 
% [fs_t,df_t,ddf_t, r_t,dr_t,ddr_t, Ns_t,s] = fRef_Straight(ds,C1,C2+[0;-R],Ts);
% Ns_cell(1) = Ns_t-1;
% r_cell(:,1:Ns_t-1,1) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,1) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,1) = ddr_t(:,1:Ns_t-1);
% 
% [fs_t,df_t,ddf_t, r_t,dr_t,ddr_t, Ns_t,s] = fRef_Arc2(ds,C2+[-R;-R],R,[0;pi/2],Fs);
% Ns_cell(2) = Ns_t-1;
% r_cell(:,1:Ns_t-1,2) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,2) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,2) = ddr_t(:,1:Ns_t-1);
% 
% [fs_t,df_t,ddf_t, r_t,dr_t,ddr_t, Ns_t,s] = fRef_Straight(ds,C2+[-R;0],C3,Ts);
% Ns_cell(3) = Ns_t-1;
% r_cell(:,1:Ns_t-1,3) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,3) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,3) = ddr_t(:,1:Ns_t-1);

















% % 複雑（RSJ2014）
% pName = 'RSJ2014';
% dim = 2;            % マニピュレータ構成次元
% dim_r = 2;          % マニピュレータ手先次元
% Link = 3;
% nCell = 9;
% 
% r_cell = nan(dim,5000,nCell);
% dr_cell = nan(dim,5000,nCell);
% ddr_cell = nan(dim,5000,nCell);
% Ns_cell = nan(nCell,1);
% 
% R = 3/1000;
% Ex = 10/1000;
% Ey = 6/1000;
% C1 = [170; -15]/1000;
% C2 = [180; -15]/1000;
% C3 = [180;  -5]/1000;
% C4 = [200;  -5]/1000;
% C5 = [200;  15]/1000;
% C6 = [170;  15]/1000;
% 
% Cell = 1;
% [~,~,~, r_t,dr_t,ddr_t, Ns_t,~] = fRef_Straight(ds,C1,C2+[-R;0],Ts);
% Ns_cell(Cell) = Ns_t-1;
% r_cell(:,1:Ns_t-1,Cell) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,Cell) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,Cell) = ddr_t(:,1:Ns_t-1);
% 
% Cell = 2;
% [~,~,~, r_t,dr_t,ddr_t, Ns_t,~] = fRef_Arc2(ds,C2+[-R;R],R,[-pi/2;0],Fs);
% Ns_cell(Cell) = Ns_t-1;
% r_cell(:,1:Ns_t-1,Cell) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,Cell) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,Cell) = ddr_t(:,1:Ns_t-1);
% 
% Cell = 3;
% [~,~,~, r_t,dr_t,ddr_t, Ns_t,~] = fRef_Straight(ds,C2+[0;R],C3+[0;-R],Ts);
% Ns_cell(Cell) = Ns_t-1;
% r_cell(:,1:Ns_t-1,Cell) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,Cell) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,Cell) = ddr_t(:,1:Ns_t-1);
% 
% Cell = 4;
% [~,~,~, r_t,dr_t,ddr_t, Ns_t,~] = fRef_Arc2(ds,C3+[R;-R],R,[pi;pi/2],Fs);
% Ns_cell(Cell) = Ns_t-1;
% r_cell(:,1:Ns_t-1,Cell) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,Cell) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,Cell) = ddr_t(:,1:Ns_t-1);
% 
% Cell = 5;
% [~,~,~, r_t,dr_t,ddr_t, Ns_t,~] = fRef_Straight(ds,C3+[R;0],C4+[-R;0],Ts);
% Ns_cell(Cell) = Ns_t-1;
% r_cell(:,1:Ns_t-1,Cell) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,Cell) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,Cell) = ddr_t(:,1:Ns_t-1);
% 
% Cell = 6;
% [~,~,~, r_t,dr_t,ddr_t, Ns_t,~] = fRef_Arc2(ds,C4+[-R;R],R,[-pi/2;0],Fs);
% Ns_cell(Cell) = Ns_t-1;
% r_cell(:,1:Ns_t-1,Cell) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,Cell) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,Cell) = ddr_t(:,1:Ns_t-1);
% 
% Cell = 7;
% [~,~,~, r_t,dr_t,ddr_t, Ns_t,~] = fRef_Straight(ds,C4+[0;R],C5+[0;-Ey],Ts);
% Ns_cell(Cell) = Ns_t-1;
% r_cell(:,1:Ns_t-1,Cell) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,Cell) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,Cell) = ddr_t(:,1:Ns_t-1);
% 
% Cell = 8;
% [~,~,~, r_t,dr_t,ddr_t, Ns_t,~] = fRef_ellipse(ds,C5+[-Ex;-Ey],Ex,Ey,[0,pi/2],Ts);
% Ns_cell(Cell) = Ns_t-1;
% r_cell(:,1:Ns_t-1,Cell) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,Cell) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,Cell) = ddr_t(:,1:Ns_t-1);
% 
% Cell = 9;
% [~,~,~, r_t,dr_t,ddr_t, Ns_t,~] = fRef_Straight(ds,C5+[-Ex;0],C6,Ts);
% Ns_cell(Cell) = Ns_t-1;
% r_cell(:,1:Ns_t-1,Cell) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,Cell) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,Cell) = ddr_t(:,1:Ns_t-1);









% % 複雑（姿勢含む）
% pName = 'complication';
% dim = 2;
% dim_r = 3;
% Nr = dim+1;
% nCell = 9;
% 
% r_cell = nan(Nr,5000,nCell);
% dr_cell = nan(Nr,5000,nCell);
% ddr_cell = nan(Nr,5000,nCell);
% Ns_cell = nan(nCell,1);
% 
% R = 3/1000;
% Ex = 10/1000;
% Ey = 6/1000;
% C1 = [170; -15]/1000;
% C2 = [180; -15]/1000;
% C3 = [180;  -5]/1000;
% C4 = [200;  -5]/1000;
% C5 = [200;  15]/1000;
% C6 = [170;  15]/1000;
% 
% 
% Cell = 1;
% [fs_t,df_t,ddf_t, r_t,dr_t,ddr_t, Ns_t,s] = fRef_Straight(ds,C1,C2+[-R;0],Ts);
% Ns_cell(Cell) = Ns_t-1;
% r_cell(1:dim,1:Ns_t-1,Cell) = r_t(:,1:Ns_t-1);
% dr_cell(1:dim,1:Ns_t-1,Cell) = dr_t(:,1:Ns_t-1);
% ddr_cell(1:dim,1:Ns_t-1,Cell) = ddr_t(:,1:Ns_t-1);
% 
% 
% Cell = 2;
% [fs_t,df_t,ddf_t, r_t,dr_t,ddr_t, Ns_t,s] = fRef_Arc2(ds,C2+[-R;R],R,[-pi/2;0],Fs);
% Ns_cell(Cell) = Ns_t-1;
% r_cell(1:dim,1:Ns_t-1,Cell) = r_t(:,1:Ns_t-1);
% dr_cell(1:dim,1:Ns_t-1,Cell) = dr_t(:,1:Ns_t-1);
% ddr_cell(1:dim,1:Ns_t-1,Cell) = ddr_t(:,1:Ns_t-1);
% 
% 
% Cell = 3;
% [fs_t,df_t,ddf_t, r_t,dr_t,ddr_t, Ns_t,s] = fRef_Straight(ds,C2+[0;R],C3+[0;-R],Ts);
% Ns_cell(Cell) = Ns_t-1;
% r_cell(1:dim,1:Ns_t-1,Cell) = r_t(:,1:Ns_t-1);
% dr_cell(1:dim,1:Ns_t-1,Cell) = dr_t(:,1:Ns_t-1);
% ddr_cell(1:dim,1:Ns_t-1,Cell) = ddr_t(:,1:Ns_t-1);
% 
% 
% Cell = 4;
% [fs_t,df_t,ddf_t, r_t,dr_t,ddr_t, Ns_t,s] = fRef_Arc2(ds,C3+[R;-R],R,[pi;pi/2],Fs);
% Ns_cell(Cell) = Ns_t-1;
% r_cell(1:dim,1:Ns_t-1,Cell) = r_t(:,1:Ns_t-1);
% dr_cell(1:dim,1:Ns_t-1,Cell) = dr_t(:,1:Ns_t-1);
% ddr_cell(1:dim,1:Ns_t-1,Cell) = ddr_t(:,1:Ns_t-1);
% 
% 
% Cell = 5;
% [fs_t,df_t,ddf_t, r_t,dr_t,ddr_t, Ns_t,s] = fRef_Straight(ds,C3+[R;0],C4+[-R;0],Ts);
% Ns_cell(Cell) = Ns_t-1;
% r_cell(1:dim,1:Ns_t-1,Cell) = r_t(:,1:Ns_t-1);
% dr_cell(1:dim,1:Ns_t-1,Cell) = dr_t(:,1:Ns_t-1);
% ddr_cell(1:dim,1:Ns_t-1,Cell) = ddr_t(:,1:Ns_t-1);
% 
% 
% Cell = 6;
% [fs_t,df_t,ddf_t, r_t,dr_t,ddr_t, Ns_t,s] = fRef_Arc2(ds,C4+[-R;R],R,[-pi/2;0],Fs);
% Ns_cell(Cell) = Ns_t-1;
% r_cell(1:dim,1:Ns_t-1,Cell) = r_t(:,1:Ns_t-1);
% dr_cell(1:dim,1:Ns_t-1,Cell) = dr_t(:,1:Ns_t-1);
% ddr_cell(1:dim,1:Ns_t-1,Cell) = ddr_t(:,1:Ns_t-1);
% 
% 
% Cell = 7;
% [fs_t,df_t,ddf_t, r_t,dr_t,ddr_t, Ns_t,s] = fRef_Straight(ds,C4+[0;R],C5+[0;-Ey],Ts);
% Ns_cell(Cell) = Ns_t-1;
% r_cell(1:dim,1:Ns_t-1,Cell) = r_t(:,1:Ns_t-1);
% dr_cell(1:dim,1:Ns_t-1,Cell) = dr_t(:,1:Ns_t-1);
% ddr_cell(1:dim,1:Ns_t-1,Cell) = ddr_t(:,1:Ns_t-1);
% 
% 
% Cell = 8;
% [fs_t,df_t,ddf_t, r_t,dr_t,ddr_t, Ns_t,s] = fRef_ellipse(ds,C5+[-Ex;-Ey],Ex,Ey,[0,pi/2],Ts);
% Ns_cell(Cell) = Ns_t-1;
% r_cell(1:dim,1:Ns_t-1,Cell) = r_t(:,1:Ns_t-1);
% dr_cell(1:dim,1:Ns_t-1,Cell) = dr_t(:,1:Ns_t-1);
% ddr_cell(1:dim,1:Ns_t-1,Cell) = ddr_t(:,1:Ns_t-1);
% 
% 
% Cell = 9;
% [fs_t,df_t,ddf_t, r_t,dr_t,ddr_t, Ns_t,s] = fRef_Straight(ds,C5+[-Ex;0],C6,Ts);
% Ns_cell(Cell) = Ns_t-1;
% r_cell(1:dim,1:Ns_t-1,Cell) = r_t(:,1:Ns_t-1);
% dr_cell(1:dim,1:Ns_t-1,Cell) = dr_t(:,1:Ns_t-1);
% ddr_cell(1:dim,1:Ns_t-1,Cell) = ddr_t(:,1:Ns_t-1);
% 
% 
% E0 = pi/2;
% E1 = pi*3/2;
% Ns = sum(Ns_cell);
% [r,dr,ddr] = trapezoid_plus(E1-E0, Ns, 0, 0, Ts, E0);
% 
% for i = 1:Cell
%     r_cell(Nr,1:Ns_cell(i),i) = r(:,sum(Ns_cell(1:i-1))+1:sum(Ns_cell(1:i)));
%     dr_cell(Nr,1:Ns_cell(i),i) = dr(1,1)*ones(1,Ns_cell(i));
%     ddr_cell(Nr,1:Ns_cell(i),i) = zeros(1,Ns_cell(i));
% end












% % 角（姿勢指令含む）-D_pre-
% pName = 'orientation';
% dim = 2;            % マニピュレータ構成次元
% dim_r = 3;          % マニピュレータ手先次元
% Link = 4;             % マニピュレータ関節次元
% nCell = 4;          % セグメント数
% 
% r_cell = nan(dim_r,5000,nCell);
% dr_cell = nan(dim_r,5000,nCell);
% ddr_cell = nan(dim_r,5000,nCell);
% Ns_cell = nan(nCell,1);
% 
% Rs = 5/1000;
% C1 = [250; 150]/1000;
% C2 = [225; 150]/1000;
% C3 = [200; 150]/1000;
% % C4 = [200; 250]/1000;
% C4 = [200; 200]/1000;
% 
% E_rate1 = 0.2;
% E_rate2 = 0.5;
% Eta = [
%     pi*2/4; % 1
% 	pi*1/4; % 2
% 	pi*1/4; % 3
% 	pi*1/4; % 4
% 	pi*0/4; % 5
% ];
% 
% nCell = 1;
% [temp,temp,temp, r_t,dr_t,ddr_t, Ns_t,temp] = fRef_Straight(ds,C1,C2,Ts);
% Ns_cell(nCell) = Ns_t-1;
% r_cell(1:dim,1:Ns_t-1,nCell) = r_t(:,1:Ns_t-1);
% dr_cell(1:dim,1:Ns_t-1,nCell) = dr_t(:,1:Ns_t-1);
% ddr_cell(1:dim,1:Ns_t-1,nCell) = ddr_t(:,1:Ns_t-1);
% 
% [r_cell(dim+1:dim_r,1:Ns_t-1,nCell),dr_cell(dim+1:dim_r,1:Ns_t-1,nCell),ddr_cell(dim+1:dim_r,1:Ns_t-1,nCell)] ...
%     = trapezoid_plus(Eta(nCell+1)-Eta(nCell), Ns_t-1, E_rate1,E_rate1, Ts, Eta(nCell));
% 
% nCell = 2;
% [temp,temp,temp, r_t,dr_t,ddr_t, Ns_t,temp] = fRef_Straight(ds,C2,C3+[Rs;0],Ts);
% Ns_cell(nCell) = Ns_t-1;
% r_cell(1:dim,1:Ns_t-1,nCell) = r_t(:,1:Ns_t-1);
% dr_cell(1:dim,1:Ns_t-1,nCell) = dr_t(:,1:Ns_t-1);
% ddr_cell(1:dim,1:Ns_t-1,nCell) = ddr_t(:,1:Ns_t-1);
% 
% [r_cell(dim+1:dim_r,1:Ns_t-1,nCell),dr_cell(dim+1:dim_r,1:Ns_t-1,nCell),ddr_cell(dim+1:dim_r,1:Ns_t-1,nCell)] ...
%     = trapezoid_plus(Eta(nCell+1)-Eta(nCell), Ns_t-1, E_rate1,E_rate1, Ts, Eta(nCell));
% 
% nCell = 3;
% [temp,temp,temp, r_t,dr_t,ddr_t, Ns_t,temp] = fRef_Arc2(ds,C3+[Rs;Rs],Rs,[-pi/2;-pi],Fs);
% Ns_cell(nCell) = Ns_t-1;
% r_cell(1:dim,1:Ns_t-1,nCell) = r_t(:,1:Ns_t-1);
% dr_cell(1:dim,1:Ns_t-1,nCell) = dr_t(:,1:Ns_t-1);
% ddr_cell(1:dim,1:Ns_t-1,nCell) = ddr_t(:,1:Ns_t-1);
% 
% [r_cell(dim+1:dim_r,1:Ns_t-1,nCell),dr_cell(dim+1:dim_r,1:Ns_t-1,nCell),ddr_cell(dim+1:dim_r,1:Ns_t-1,nCell)] ...
%     = trapezoid_plus(Eta(nCell+1)-Eta(nCell), Ns_t-1, E_rate1,E_rate1, Ts, Eta(nCell));
% 
% nCell = 4;
% [temp,temp,temp, r_t,dr_t,ddr_t, Ns_t,temp] = fRef_Straight(ds,C3+[0;+Rs],C4,Ts);
% Ns_cell(nCell) = Ns_t-1;
% r_cell(1:dim,1:Ns_t-1,nCell) = r_t(:,1:Ns_t-1);
% dr_cell(1:dim,1:Ns_t-1,nCell) = dr_t(:,1:Ns_t-1);
% ddr_cell(1:dim,1:Ns_t-1,nCell) = ddr_t(:,1:Ns_t-1);
% 
% [r_cell(dim+1:dim_r,1:Ns_t-1,nCell),dr_cell(dim+1:dim_r,1:Ns_t-1,nCell),ddr_cell(dim+1:dim_r,1:Ns_t-1,nCell)] ...
%     = trapezoid_plus(Eta(nCell+1)-Eta(nCell), Ns_t-1, E_rate2,E_rate2, Ts, Eta(nCell));












% % 空間マニピュレータ
% pName = 'Dpre_3D';
% dim = 3;            % マニピュレータ構成次元
% dim_r = 3;          % マニピュレータ手先次元
% Link = 4;             % マニピュレータ関節次元
% nCell = 7;          % セグメント数
% 
% r_cell = nan(dim_r,5000,nCell);
% dr_cell = nan(dim_r,5000,nCell);
% ddr_cell = nan(dim_r,5000,nCell);
% Ns_cell = nan(nCell,1);
% 
% R = 5/1000;
% ed = 30/1000;
% C1 = [0.2;      0.1;     0.1    ];
% C2 = [0.2;      0.1+ed;  0.1    ];
% C3 = [0.2;      0.1+ed;  0.1+ed ];
% C4 = [0.2-ed;   0.1+ed;  0.1+ed ];
% C5 = [0.2-ed;   0.1+ed;  0.1    ];
% C6 = [0.2-ed;   0.1;     0.1    ];
% 
% cell = 1;
% [~,~,~, r_t,dr_t,ddr_t, Ns_t,~] = fRef_Straight(ds,C1,C2+[0;-R;0],Ts);
% Ns_cell(cell) = Ns_t-1;
% r_cell(:,1:Ns_t-1,cell) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,cell) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,cell) = ddr_t(:,1:Ns_t-1);
% 
% cell = 2;
% [~,~,~, r_t,dr_t,ddr_t, Ns_t,~] = fRef_Arc2(ds,C2(2:3)+[-R;R],R,[-pi/2;0],Fs);
% Ns_cell(cell) = Ns_t-1;
% r_cell(:,1:Ns_t-1,cell) = [ C2(1)*ones(1,Ns_t-1); r_t(:,1:Ns_t-1) ];
% dr_cell(:,1:Ns_t-1,cell) = [ zeros(1,Ns_t-1); dr_t(:,1:Ns_t-1) ];
% ddr_cell(:,1:Ns_t-1,cell) = [ zeros(1,Ns_t-1); ddr_t(:,1:Ns_t-1) ];
% 
% cell = 3;
% [~,~,~, r_t,dr_t,ddr_t, Ns_t,~] = fRef_Straight(ds,C2+[0;0;R],C3+[0;0;-R],Ts);
% Ns_cell(cell) = Ns_t-1;
% r_cell(:,1:Ns_t-1,cell) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,cell) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,cell) = ddr_t(:,1:Ns_t-1);
% 
% cell = 4;
% [~,~,~, r_t,dr_t,ddr_t, Ns_t,~] = fRef_Arc2(ds,C3(1:2:3)+[-R;-R],R,[0;pi/2],Fs);
% Ns_cell(cell) = Ns_t-1;
% r_cell(:,1:Ns_t-1,cell) = [ r_t(1,1:Ns_t-1)         ;
%                             C3(2)*ones(1,Ns_t-1)    ;
%                             r_t(2,1:Ns_t-1)         ];
% dr_cell(:,1:Ns_t-1,cell) = [ dr_t(1,1:Ns_t-1)       ;
%                              zeros(1,Ns_t-1)        ;
%                              dr_t(2,1:Ns_t-1)       ];
% ddr_cell(:,1:Ns_t-1,cell) = [ ddr_t(1,1:Ns_t-1)     ;
%                               zeros(1,Ns_t-1)       ;
%                               ddr_t(2,1:Ns_t-1)     ];
% 
% cell = 5;
% [~,~,~, r_t,dr_t,ddr_t, Ns_t,~] = fRef_Straight(ds,C3+[-R;0;0],C4+[R;0;0],Ts);
% Ns_cell(cell) = Ns_t-1;
% r_cell(:,1:Ns_t-1,cell) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,cell) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,cell) = ddr_t(:,1:Ns_t-1);
% 
% cell = 6;
% [~,~,~, r_t,dr_t,ddr_t, Ns_t,~] = fRef_Arc2(ds,C4(1:2:3)+[R;-R],R,[pi/2;pi],Fs);
% Ns_cell(cell) = Ns_t-1;
% r_cell(:,1:Ns_t-1,cell) = [ r_t(1,1:Ns_t-1)         ;
%                             C4(2)*ones(1,Ns_t-1)    ;
%                             r_t(2,1:Ns_t-1)         ];
% dr_cell(:,1:Ns_t-1,cell) = [ dr_t(1,1:Ns_t-1)       ;
%                              zeros(1,Ns_t-1)        ;
%                              dr_t(2,1:Ns_t-1)       ];
% ddr_cell(:,1:Ns_t-1,cell) = [ ddr_t(1,1:Ns_t-1)     ;
%                               zeros(1,Ns_t-1)       ;
%                               ddr_t(2,1:Ns_t-1)     ];
% 
% cell = 7;
% [~,~,~, r_t,dr_t,ddr_t, Ns_t,~] = fRef_Straight(ds,C4+[0;0;-R],C5+[0;0;R],Ts);
% Ns_cell(cell) = Ns_t-1;
% r_cell(:,1:Ns_t-1,cell) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,cell) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,cell) = ddr_t(:,1:Ns_t-1);
% 
% cell = 8;
% [~,~,~, r_t,dr_t,ddr_t, Ns_t,~] = fRef_Arc2(ds,C5(2:3)+[-R;R],R,[0;-pi/2],Fs);
% Ns_cell(cell) = Ns_t-1;
% r_cell(:,1:Ns_t-1,cell) = [ C5(1)*ones(1,Ns_t-1)    ;
%                             r_t(1,1:Ns_t-1)         ;
%                             r_t(2,1:Ns_t-1)         ];
% dr_cell(:,1:Ns_t-1,cell) = [ zeros(1,Ns_t-1)        ;
%                              dr_t(1,1:Ns_t-1)       ;
%                              dr_t(2,1:Ns_t-1)       ];
% ddr_cell(:,1:Ns_t-1,cell) = [ zeros(1,Ns_t-1)       ;
%                               ddr_t(1,1:Ns_t-1)     ;
%                               ddr_t(2,1:Ns_t-1)     ];
% 
% cell = 9;
% [~,~,~, r_t,dr_t,ddr_t, Ns_t,~] = fRef_Straight(ds,C5+[0;-R;0],C6+[0;0;0],Ts);
% Ns_cell(cell) = Ns_t-1;
% r_cell(:,1:Ns_t-1,cell) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,cell) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,cell) = ddr_t(:,1:Ns_t-1);












% % 直線
% pName = 'Straight';
% dim = 2;            % マニピュレータ構成次元
% dim_r = 2;          % マニピュレータ手先次元
% Link = 3;           % マニピュレータ関節次元
% nCell = 1;          % セグメント数
% 
% r_cell = nan(dim_r,5000,nCell);
% dr_cell = nan(dim_r,5000,nCell);
% ddr_cell = nan(dim_r,5000,nCell);
% Ns_cell = nan(nCell,1);
% 
% C1 = [100; 30]/1000;
% C2 = [150; 30]/1000;
% 
% nCell = 1;
% [~,~,~, r_t,dr_t,ddr_t, Ns_t,~] = fRef_Straight(ds,C1,C2,Ts);
% Ns_cell(nCell) = Ns_t-1;
% r_cell(:,1:Ns_t-1,nCell) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,nCell) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,nCell) = ddr_t(:,1:Ns_t-1);










% % 円弧
% pName = 'Arc';
% dim = 2;            % マニピュレータ構成次元
% dim_r = 2;          % マニピュレータ手先次元
% Link = 3;           % マニピュレータ関節次元
% nCell = 1;          % セグメント数
% 
% r_cell = nan(dim_r,5000,nCell);
% dr_cell = nan(dim_r,5000,nCell);
% ddr_cell = nan(dim_r,5000,nCell);
% Ns_cell = nan(nCell,1);
% 
% Rs = 50/1000;
% C1 = [100; 100]/1000;
% 
% nCell = 1;
% [~,~,~, r_t,dr_t,ddr_t, Ns_t,~] = fRef_Arc2(ds,C1+[Rs;Rs],Rs,[-pi/4;0],Fs);
% Ns_cell(nCell) = Ns_t-1;
% r_cell(1:dim,1:Ns_t-1,nCell) = r_t(:,1:Ns_t-1);
% dr_cell(1:dim,1:Ns_t-1,nCell) = dr_t(:,1:Ns_t-1);
% ddr_cell(1:dim,1:Ns_t-1,nCell) = ddr_t(:,1:Ns_t-1);










% 円弧(姿勢あり)
pName = 'Arc';
dim = 2;            % マニピュレータ構成次元
dim_r = 3;          % マニピュレータ手先次元
nCell = 1;          % セグメント数

r_cell = nan(dim_r,5000,nCell);
dr_cell = nan(dim_r,5000,nCell);
ddr_cell = nan(dim_r,5000,nCell);
Ns_cell = nan(nCell,1);

Rs = 50/1000;
C1 = [150; 150]/1000;

nCell = 1;
[~,~,~, r_t,dr_t,ddr_t, Ns_t,~] = fRef_Arc2(ds,C1,Rs,[-pi/2;pi/2],Fs);
Ns_cell(nCell) = Ns_t-1;
r_cell(1:dim,1:Ns_t-1,nCell) = r_t(:,1:Ns_t-1);
dr_cell(1:dim,1:Ns_t-1,nCell) = dr_t(:,1:Ns_t-1);
ddr_cell(1:dim,1:Ns_t-1,nCell) = ddr_t(:,1:Ns_t-1);
[r_cell(dim+1:dim_r,1:Ns_t-1,nCell),dr_cell(dim+1:dim_r,1:Ns_t-1,nCell),ddr_cell(dim+1:dim_r,1:Ns_t-1,nCell)] ...
    = trapezoid_plus(pi, Ns_t-1, 0,0, Ts, -pi/2);








% % D_pre (temp)
% pName = 'D_pre';
% dim = 2;
% dim_r = 2;
% 
% r_cell = nan(2,5000,3);
% dr_cell = nan(2,5000,3);
% ddr_cell = nan(2,5000,3);
% Ns_cell = nan(3,1);
% 
% R = 3/1000;
% C1 = [200;  0]/1000;
% C2 = [200; 5]/1000;
% C3 = [195; 5]/1000;
% 
% [fs_t,df_t,ddf_t, r_t,dr_t,ddr_t, Ns_t,s] = fRef_Straight(ds,C1,C2+[0;-R],Ts);
% Ns_cell(1) = Ns_t-1;
% r_cell(:,1:Ns_t-1,1) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,1) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,1) = ddr_t(:,1:Ns_t-1);
% 
% [fs_t,df_t,ddf_t, r_t,dr_t,ddr_t, Ns_t,s] = fRef_Arc2(ds,C2+[-R;-R],R,[0;pi/2],Fs);
% Ns_cell(2) = Ns_t-1;
% r_cell(:,1:Ns_t-1,2) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,2) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,2) = ddr_t(:,1:Ns_t-1);
% 
% [fs_t,df_t,ddf_t, r_t,dr_t,ddr_t, Ns_t,s] = fRef_Straight(ds,C2+[-R;0],C3,Ts);
% Ns_cell(3) = Ns_t-1;
% r_cell(:,1:Ns_t-1,3) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,3) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,3) = ddr_t(:,1:Ns_t-1);











% % Doctor (270deg)
% pName = '270';
% dim = 2;            % マニピュレータ構成次元
% dim_r = 2;          % マニピュレータ手先次元
% Link = 3;           % マニピュレータ関節次元
% nCell = 3;          % セクション数
% 
% r_cell = nan(dim_r,5000,nCell);
% dr_cell = nan(dim_r,5000,nCell);
% ddr_cell = nan(dim_r,5000,nCell);
% Ns_cell = nan(nCell,1);
% 
% R = 5/1000;
% C1 = [200; 40]/1000;
% C2 = [200; 50]/1000;
% C3 = [210; 50]/1000;
% 
% [fs_t,df_t,ddf_t, r_t,dr_t,ddr_t, Ns_t,s] = fRef_Straight(ds,C1,C2+[0;R],Ts);
% Ns_cell(1) = Ns_t-1;
% r_cell(:,1:Ns_t-1,1) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,1) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,1) = ddr_t(:,1:Ns_t-1);
% 
% [fs_t,df_t,ddf_t, r_t,dr_t,ddr_t, Ns_t,s] = fRef_Arc2(ds,C2+[-R;R],R,[0;pi*3/2],Fs);
% Ns_cell(2) = Ns_t-1;
% r_cell(:,1:Ns_t-1,2) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,2) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,2) = ddr_t(:,1:Ns_t-1);
% 
% [fs_t,df_t,ddf_t, r_t,dr_t,ddr_t, Ns_t,s] = fRef_Straight(ds,C2+[-R;0],C3,Ts);
% Ns_cell(3) = Ns_t-1;
% r_cell(:,1:Ns_t-1,3) = r_t(:,1:Ns_t-1);
% dr_cell(:,1:Ns_t-1,3) = dr_t(:,1:Ns_t-1);
% ddr_cell(:,1:Ns_t-1,3) = ddr_t(:,1:Ns_t-1);











% % 停止
% pName = 'Stop';
% dim = 2;            % マニピュレータ構成次元
% dim_r = 2;          % マニピュレータ手先次元
% Link = 3;           % マニピュレータ関節次元
% nCell = 1;          % セグメント数
% 
% r_cell = diag([0.18,0])*ones(dim_r,100,nCell);
% dr_cell = zeros(dim_r,100,nCell);
% ddr_cell = zeros(dim_r,100,nCell);
% Ns_cell = nan(nCell,1);
% 
% nCell = 1;
% Ns_cell(nCell) = 100;











Ns = sum(Ns_cell);

t = (0:Ns-1)*Ts;
s = ds*t;

r = nan(size(r_cell,1),Ns);
dr = nan(size(r_cell,1),Ns);
ddr = nan(size(r_cell,1),Ns);

for k = 1:length(Ns_cell)
    if k == 1
        r(:,1:Ns_cell(k)) = r_cell(:,1:Ns_cell(k),k);
        dr(:,1:Ns_cell(k)) = dr_cell(:,1:Ns_cell(k),k);
        ddr(:,1:Ns_cell(k)) = ddr_cell(:,1:Ns_cell(k),k);
    else
        r( :,sum(Ns_cell(1:k-1))+1:sum(Ns_cell(1:k)) ) = r_cell(:,1:Ns_cell(k),k);
        dr( :,sum(Ns_cell(1:k-1))+1:sum(Ns_cell(1:k)) ) = dr_cell(:,1:Ns_cell(k),k);
        ddr( :,sum(Ns_cell(1:k-1))+1:sum(Ns_cell(1:k)) ) = ddr_cell(:,1:Ns_cell(k),k);
    end
end

fs = r;
df = dr/ds;
ddf = ddr/ds^2;

if draw == 1
    if dim_r == 2
        figure(1)
            plot(r(1,:),r(2,:),'r- .')
            axis equal
            grid on
            xlabel('x')
            ylabel('y')
    elseif dim_r == 3
        figure(1)
            plot3(r(1,:),r(2,:),r(3,:),'r- .')
            axis equal
            grid on
            xlabel('x')
            ylabel('y')
            zlabel('z')
    end
end

if 1 && draw == 1
    figure(2)
    subplot(3,1,1)
        plot(fs(1:2,:)')
        xlim([1,Ns])
        legend('x','y')
        grid on
    subplot(3,1,2)
        plot(df(1:2,:)')
        xlim([1,Ns])
        grid on
    subplot(3,1,3)
        plot(ddf(1:2,:)')
        xlim([1,Ns])
        grid on
    
    if dim_r > dim
        figure(3)
        clf(3)
        hold on
        subplot(3,1,1)
            set(gca, 'FontSize',FS)
            plot(s(1,:),fs(3,:)','k', 'LineWidth',1.0)
            xlim([min(s) max(s)])
%             legend('Eta')
%             grid on
            ylabel('$$H [rad]$$', 'interpreter','latex', 'FontSize',FS_tex)
            
        subplot(3,1,2)
            set(gca, 'FontSize',FS)
            plot(s,df(3,:)','k', 'LineWidth',1.0)
            xlim([min(s) max(s)])
%             ylim([-50 10])
%             grid on
            ylabel('$$\dot{H} [rad$$/$$s]$$', 'interpreter','latex', 'FontSize',FS_tex)
            
        subplot(3,1,3)
            plot(s,ddf(3,:)','k', 'LineWidth',1.0)
            set(gca, 'FontSize',FS)
            xlim([min(s) max(s)])
%             grid on
            xlabel('$$s[m]$$', 'interpreter','latex', 'FontSize',FS_tex)
            ylabel('$$\ddot{H} [rad$$/$$s^2]$$', 'interpreter','latex', 'FontSize',FS_tex)
    end
    
    param = get_parameter();
    Link = param.Link;
    
    if anime == 1
        if dim == 2
            q = nan(Link,Ns);
            for k = 1:Ns
                [q(:,k), error] = f3L_iKinematics(r(:,k),0);
            end
            f3L_RoboAnimation_v3(q, r,Ts);
        elseif dim == 3
            q = nan(Link,Ns);
            for k = 1:Ns
                [q(:,k), error] = f3L_iKinematics(r(:,k),pi/3);
            end
            f3L_RoboAnimation_3D(q, r,Ts);
        end
    else
        % Prohibited Area
        Rxlim = [ 0, 2*pi ];
        Rvlim = [-1,1]*20;

        Nx = 10;
        Nv = 10;
        Sigma_Rx = linspace(Rxlim(1),Rxlim(2),Nx);
        Sigma_Rv = linspace(Rvlim(1),Rvlim(2),Nv);

        [Gtm,Ftm,Gqm,Fqm] = f3L_ProhibitedArea_v3(r,dr,ddr, Sigma_Rx,Sigma_Rv, Nx,Nv);
        
        FH_PA = 4;
        f3L_ProhibitedArea_TaV_plot(FH_PA, ds, Gtm,Ftm,Gqm,Fqm, s,Sigma_Rx,Sigma_Rv);
    end
end

end
