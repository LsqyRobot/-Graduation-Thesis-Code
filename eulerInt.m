clc
clear all
close all
q = [ -2.8414  -0.9626    1.5597   -2.1679    1.5708   -1.8710];
dq=[2.7206   0.5421   -5.3546   0   0  0];
qlist=q;
dqlist=dq;
endTime = 10;
%steps = 20000;
%dt = endTime/steps;
dt = 1e-4;
steps=endTime/dt;
t=0;
%alpha=10;
%beta=10;    
alpha=100;
beta=1000;
for i = 1:steps
    ddq = pinv(Jv(q))*(bv(q,dq,t)-alpha*dphi(q,dq,t)-beta*phi(q,t));
    dq=dq+ddq'*dt;
    q = q + dq*dt;
    qlist = [qlist;q];
    dqlist=[dqlist;dq];
    t = t + dt;
end

plotUr5=0;
plotDesiredMotion=0;
plotPhi=1;
plotDeleyTime=0.5;
method='Euler';
plotFunction(qlist,dqlist,endTime,plotUr5,plotPhi,plotDesiredMotion,plotDeleyTime,method)



