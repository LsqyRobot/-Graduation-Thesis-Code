%% The motion of the manipulator only influenced by gravity
clear all
clc
close all
warning off
tic
q = zeros(1,6);  %replace it
dq = zeros(1,6);
endTime = 10;
steps = 2000;
dt = endTime/steps;
[qlist, dqlist] = deal(zeros(length(0:dt:endTime),6));
qlist(1,:) = q;
dqlist(1,:) =dq;
ur5_model;
fv = 0.1;
fc = 0.2;
for i = 1:steps
    ddq=M(q)\(Q(q,dq) - Fri(0.5,0.1,dq));
    dq = dq + ddq'*dt;
    q = q + dq*dt;
    qlist(i+1,:) = q;
    dqlist(i+1,:)=dq;
    disp(['run at: ' num2str(i*100/steps) '%']);
end
toc
this.qList = qlist;
this.dqList = dqlist;
this.endTime = endTime;
plotFcn(this,'pose')

saveName = 'frictionData31';
savePath = '../matFile/';
save([savePath saveName],'qlist','dqlist','endTime')