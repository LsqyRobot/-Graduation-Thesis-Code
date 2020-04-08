function q_dq=ddq_a(sample,t)
q=sample(1:6);
v=sample(7:12);     %%dq->int->q || ddq->int->dq .  int:integral
qa =q;         
dqa=v;         
qa(2) = q(2) +  noise(t,1,0.4,10);    %% add noise peak->0.2 peak->0.4
dqa(3) = dqa(3) + noise(t,3,1,5);
dv=M(qa)\(Q(qa,v)+Qc(q,v,t)+Qu(qa,dqa,t));
q_dq=[v,dv];
q_dq=q_dq(:);
disp(['Time is: ' num2str(t) 's'])     %% much slowly than you image.