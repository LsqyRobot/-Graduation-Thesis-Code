%% The motion of the manipulator (only influenced by gravity)
clc
clear all
close all
q = rand(1,6); 
dq = zeros(1,6);
endTime = 5;
steps = 1000;
dt = endTime/steps;
ur5_model;
speed = 5;
tic
for i = 1:steps
	ddq=M(q)\(-C(q,dq)*dq(:) - G(q)');
	dq = dq + ddq'*dt;
	q = q + dq*dt;
	if mod(i,speed) == 0
	      ur5.plot(q);
	end	      
end
toc
