%*************************************************************************
%   > File Name: jointContorlCase1.m
%   > Author: lsqyRobot
%   > Mail: lsqyRobot@gmail.com 
%   > Created Time: Tue Apr 28 08:42:02 2020
%***********************************************************************/
function jointContorlCase1()
clc
clear all
close all
dbstop if error
if isempty(gcp('nocreate'))
    parpool;
end
tic
dt=1e-3;
endTime=1;
tspan =0:dt:endTime;
opts = odeset('RelTol',1e-11,'AbsTol',1e-11); 
q0= zeros(1,12);
[t,y]= ode15s(@(t,q)case1(q,t),tspan,q0,opts);


qlist=y(:,1:6);
dqlist=y(:,7:12);
thiscase.qlist = qlist;
thiscase.dqlist = dqlist;
thiscase.endTime = endTime;
plotFcn(thiscase,'Qu')
savePath = './caseMatFile/';
saveFile = 'case1.mat';
save([savePath saveFile],'qlist','dqlist', 'u');
end



function y = case1(q,t)
q=q(1:6);
dq=q(7:12);
ddq=M(q)\(Q(q,dq)) + u(q,t);
y=[dq,ddq];
y=q_dq(:);
end

function u = u(q,t)
%% parameters choose
c = 100;
eta = 304;
q=q(1:6);
dq=q(7:12);
[e,de] = s(q,t);
s = c*de + e;
u = M(q)*(-Q(q,dq)  -c*de - eta*sign(s));
end


function  [thd,dthd,ddthd] = th_d(t)
thd = sin(t)*ones(6,1);
dthd = cos(t)*ones(6,1);
ddthd = -sin(t)*ones(6,1);
end

function [e,de] = s(q,t)
q=q(1:6);
dq=q(7:12);
[thd,dthd] = th_d(t);
e = q - thd;
de = dq - dthd ;
end
