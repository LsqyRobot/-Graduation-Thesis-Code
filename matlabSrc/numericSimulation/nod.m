close all
warning off
tic
q = zeros(1,6);  
dq = zeros(1,6);

dt=1e-3;
endTime=1;
tspan =0:dt:endTime;
opts = odeset('RelTol',1e-11,'AbsTol',1e-11); 

q0 = [q,dq];
[t,y]= ode15s(@(t,q)ddq_a(q,t),tspan,q0,opts);

toc
qlist=y(:,1:6);
dqlist=y(:,7:12);
thiscase.qlist = qlist;
thiscase.dqlist = dqlist;
thiscase.endTime = endTime;
plotFcn(this,'pose')


function pd = pdControl(Kp,Kd,dq,q)
dq = dq(:);
q = q(:);
pd = Kp*q + Kd*dq;
dq(6) = 0;
q(6) = 0;
end


function inputForce = u(dq,q)
inputForce = -Q(q,dq) + pdControl(1000,10000,dq,q);
end



function ddq = PDControlDDQ(sample)
q=sample(1:6);
v=sample(7:12);     %%dq->int->q || ddq->int->dq .  int:integral         
q(2) = q(2) +  noise(t,1,0.1,10);    
dv=M(q)\(Q(q,v)+u(v,q));
q_dq=[v,dv];
q_dq=q_dq(:);
disp(['Time is: ' num2str(t) 's'])    
end



