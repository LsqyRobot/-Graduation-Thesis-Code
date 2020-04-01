
% q = [3.1416  0   0   0  1.5708  0];
% dq = zeros(1,6);
% qlist=q;
% dqlist=dq;
% t=0;
% endTime = 4;
% steps = 2000;
% dt = endTime/steps;
% tspan = 0:dt:endTime;
% ur5_model;
% for i = 1:steps
%     ddq = M(q)\(-C(q,dq)*dq'-G(q,grav)');
%     dq = dq + ddq'*dt;
%     q = q + dq*dt;
%     dqlist=[dqlist;dq];
%     qlist=[qlist;q];
% end
% 
% pose = zeros(length(qlist),6);
% for i = 1:length(qlist)
% pose(i,:)= ur5FK(qlist(i,:));
% end
% [px,py,pz] = deal(pose(:,1),pose(:,2),pose(:,3)); %% plot 
% figure
% for i = 1:10:length(qlist)
% ur5.plot(qlist(i,:))
% hold on
% plot3(px(1:i),py(1:i),pz(1:i),'r-', 'LineWidth',0.1)
% title(['((Euler integal method) Time is: '  num2str(i*endTime/length(qlist))])
% end
% 
% 
% %%% ODE Algorithm/Of course  this method is much slowly than Euler method
%  if strcmp(methodChoose, 'ODE')
% q = [3.1416  0   0   0  1.5708  0];
% dq = zeros(1,6);
% sample=[q,dq];
% endTime=4;
% dt=1e-3;
% tspan = 0:dt:endTime;
% [~,y]= ode15s(@(t,q)ddq_onlyGrav(q,t),tspan,sample);
% qlist=y(:,1:6);
% dqlist=y(:,7:12);  % not use this
% pose = zeros(length(qlist),6);
% for i = 1:length(qlist)
% pose(i,:)= ur5FK(qlist(i,:));
% end
% [px,py,pz] = deal(pose(:,1),pose(:,2),pose(:,3)); 
% ur5_model;
% figure
% for i = 1:10:length(qlist)
% ur5.plot(qlist(i,:))
% hold on
% plot3(px(1:i),py(1:i),pz(1:i),'r-', 'LineWidth',0.1)
% title(['((ODE method) Time is: '  num2str(i*endTime/length(qlist))])
% end
% %%
% end
% 
% 
% 
% function onlyGrav_ddq = ddq_onlyGrav(sample,t)
% q=sample(1:6);
% qdot=sample(7:12);
% a=M(q)\Q(q,qdot);
% onlyGrav_ddq=[qdot,a];
% onlyGrav_ddq=onlyGrav_ddq(:);
% end
%  clc
%  clear all
% tic 
% t= 0;
% dt = 1e-10;
% for i = 1:10000
%     sample = rand(12,1);
%     t=t+dt;
%     ddq_a(sample,t);
% end
% toc
    

tic
A = rand(2,6);
pinvA = pinv(A);
toc

tic 
B = A;
[Q,R] = qr(A);
invR = (R'*R)\R';
qrInvB = invR*Q';
toc

tic
