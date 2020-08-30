
clear all
clc
q = zeros(1,6);          %replace it
dq = zeros(1,6);
endTime = 2;
steps = 2000;
dt = endTime/steps;
[qlist, dqlist] = deal(zeros(length(0:dt:endTime),6));
qlist(1,:) = q;
dqlist(1,:) =dq;
ur5_model;
kp = 500;
kd = 50;
for i = 1:steps
    ddq=M(q)\(Q(q,dq) + u(q,dq,kp,kd));
    dq = dq + ddq'*dt;
    q = q + dq*dt;
    q(2) = noise(dt*i,0.2,0.2,10) + q(2);
    qlist(i+1,:) = q;
    dqlist(i+1,:)=dq;
    disp(['run at: ' num2str(i*100/steps) '%']);
end

this.qList = qlist;
this.dqList = dqlist;
this.endTime = endTime;
this.tp=0.2;
this.fat = 10;
this.peak = 0.2;
plotFcn(this,'pose')
plotFcn(this,'noise')

saveName = 'pdControl';
savePath = './matFile/';
save([savePath saveName],'qlist','dqlist','endTime')


function y = u(q,dq,kp,kd)
q = q(:);
dq = dq(:);
y = M(q)*(-kd*dq - kp*q) - Q(q,dq);
end