clear

rosbag = readtable("output_part_01.csv");
%%
[row,col] = size(rosbag);

q = nan(6,row);
q(1,:) = (rosbag.Var10)';
q(2,:) = (rosbag.Var11)';
q(3,:) = (rosbag.Var12)';
q(4,:) = (rosbag.Var13)';
q(5,:) = (rosbag.Var14)';
q(6,:) = (rosbag.Var15)';

dq = nan(6,row);
dq(1,:) = (rosbag.Var16)';
dq(2,:) = (rosbag.Var17)';
dq(3,:) = (rosbag.Var18)';
dq(4,:) = (rosbag.Var19)';
dq(5,:) = (rosbag.Var20)';
dq(6,:) = (rosbag.Var21)';

eff = nan(6,row);
eff(1,:) = (rosbag.Var22)';
eff(2,:) = (rosbag.Var23)';
eff(3,:) = (rosbag.Var24)';
eff(4,:) = (rosbag.Var25)';
eff(5,:) = (rosbag.Var26)';
eff(6,:) = (rosbag.Var27)';


% Load gravity torque parameters
data = readtable('../GravityVecotrParameter.csv');
p = table2array(data(:,2));

% Load coulomb friction parameters
data = readtable('../CoulombFrictionParameter.csv');
S = table2array(data(:,2));
al = table2array(data(:,3));

tau_c = nan(6,row);
tau_g = nan(6,row);

for k = 1:row
    % Estimate gravity torque vector
    A = get_A_xArm_gravity(q(:,k));
    tau_g(:,k) = A * p;

    % Estimate coulomb friction
    tau_c(:,k) = coulomb(dq(:,k),S,al);
end

tau = tau_c + tau_g;

%%

tab = table(q',dq',eff',tau', 'VariableNames',{'position','velocity','effort','torque'});

writetable(tab,'comp_torque.csv');