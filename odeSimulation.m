%{
    Since this simulation process costed much time than my expected,
    the key data was saved as method.mat
%}
clc
clear all
close all
dbstop if error
if isempty(gcp('nocreate'))
    parpool;
end
tic
dt=1e-3;
endTime=10;
tspan =0:dt:endTime;
opts = odeset('RelTol',1e-11,'AbsTol',1e-11); 

ur5_model;
%case1
q = [ -2.8414  -0.9626    1.5597   -2.1679    1.5708   -1.8710];
dq=[2.7206   0.5421   -5.3546   0   0  0];
%case2
% q = [ -2.8414  -0.9626    1.5597   -2.1679    1.5708   -1.8710]+0.2;
% dq=[2.7206   0.5421   -5.3546   0   0  0]+0.2;

q0=[q,dq]; 
% Braun Case
[~,y]= ode15s(@(t,q)Braun_ddq(q,t),tspan,q0);

% myCase
%[t,y]= ode15s(@(t,q)ddq_a(q,t),tspan,q0);
%[t,y]= ode15s(@(t,q)ddq_a(q,t),tspan,q0,opts);


% figure
% plot(y(:,1:6));
% figure
% plot(y(:,7:12));
toc
qlist=y(:,1:6);
dqlist=y(:,7:12);
plotUr5=0;
plotDesiredMotion=0;
plotPhi=1;
method='Euler';
plotFunction(qlist,dqlist,endTime,plotUr5,plotPhi,plotDesiredMotion,method)

%parpool local close 
