
clear all
clc
q = zeros(1,6);          %replace it
dq = zeros(1,6);
endTime = 2;
steps = 2000;
dt = endTime/steps;
ur5_model;
speed = 10;
kp = 500;
kd = 50;

for i = 1:steps
    tau_dis = 200*rand(6,1)*(i<20);
    ddq=M(q)\(Q(q,dq) + u(q,dq,kp,kd) + tau_dis);
    dq = dq + ddq'*dt;
    q = q + dq*dt;
    if mod(i,speed) == 0
    ur5.plot(q);
    end
end

function y = u(q,dq,kp,kd)
q = q(:);
dq = dq(:);
y = M(q)*(-kd*dq - kp*q) - Q(q',dq');
end

function y = Q(q,dq)
y = -C(q,dq)*dq' - G(q)';
end


function error(qd,dq,ddq,t)
% Here you can input what you desired trajactory,
qd(6) = 0








