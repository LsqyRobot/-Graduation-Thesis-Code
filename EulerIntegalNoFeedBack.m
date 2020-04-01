clc
clear all
close all
warning off
q = [ -2.8414  -0.9626    1.5597   -2.1679    1.5708   -1.8710];
dq=[2.7206   0.5421   -5.3546   0   0  0];
qlist = q;
dqlist=dq;
%% Euler  Integral Parameters;
endTime = 20;
% steps = 100000;
% dt = endTime/steps;
dt = 2e-3;
steps=endTime/dt;
t=0;
%% End Euler Parameters
ur5_model;
for i = 1:steps
    ddq=M(q)\(Q(q,dq)+Qc(q,dq,t));
    %ddq=M(q)\(Q(q,dq)+Qc_mod(q,dq,50,50,t));
    qlist = [qlist;q];
    dqlist=[dqlist;dq];
    q = q + dq*dt;
    dq = dq + ddq'*dt;
    t = t + dt;
end

plotUr5=0;
plotDesiredMotion=0;
plotPhi=1;
plotDeleyTime=0.5;
method='Euler';
plotFunction(qlist,dqlist,endTime,plotUr5,plotPhi,plotDesiredMotion,method)

