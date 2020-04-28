%% The motion of the manipulator only influenced by gravity
clear all
clc
close all
warning off
tic
q = rand(1,6);  %replace it
dq = zeros(1,6);
endTime = 3;
steps = 2000;
dt = endTime/steps;
[qlist, dqlist] = deal(zeros(length(0:dt:endTime),6));
qlist(1,:) = q;
dqlist(1,:) =dq;
ur5_model;
for i = 1:steps
    ddq=M(q)\(Q(q,dq));
    dq = dq + ddq'*dt;
    q = q + dq*dt;
    qlist(i+1,:) = q;
    dqlist(i+1,:)=dq;
end
toc
this.qList = qlist;
this.dqList = dqlist;
this.endTime = endTime;
plotFcn(this,'pose')