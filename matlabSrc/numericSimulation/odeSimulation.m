%{
    Since this simulation process costed much time than my expected,
    the key data was saved as method.mat.
    Note:noise apply in joint2 and joint3's velocity; (whatever, if you want)
%}
clc
clear all
close all
% dbstop if error
% if isempty(gcp('nocreate'))
%     parpool;
% end
tic
dt=1e-3;
endTime=1;
tspan =0:dt:endTime;
opts = odeset('RelTol',1e-11,'AbsTol',1e-11); 


%case1
case1.q = [ -2.8414  -0.9626    1.5597   -2.1679    1.5708   -1.8710];
case1.dq=[2.7206   0.5421   -5.3546   0   0  0];
%case2
% case2.q = [ -2.8414  -0.9626    1.5597   -2.1679    1.5708   -1.8710]+0.2;
% case2.dq=[2.7206   0.5421   -5.3546   0   0  0]+0.2;
q0=[case1.q,case1.dq]; 
% noiseSet.tp = 2;
% noiseSet.peak=0.2;      %if peak is zero, means no noise on manipulator
% noiseSet.fat = 10;

%[~,y]= ode15s(@(t,q)Braun_ddq(q,t,noiseSet),tspan,q0);

% myCase
[t,y]= ode15s(@(t,q)ddq_a(q,t),tspan,q0,opts);


toc
qlist=y(:,1:6);
dqlist=y(:,7:12);
thiscase.qlist = qlist;
thiscase.dqlist = dqlist;
thiscase.endTime = endTime;
plotFcn(thiscase,'Qu')
% 
% 
% plotFcn(noiseSet,'noise')
% hold on 
% disSet.tp = 1;
% disSet.fat = 5;
% disSet.peak = 0.2;
% plotFcn(disSet,'noise')

saveFile = 'unknown.mat';
save(saveFile,'qlist','dqlist');








