function braun_ddq= Braun_ddq(sample,t)
h=1e-3;
%h=1e-4;  %Time Cost: 3958.799124 seconds. %q0 dq0 + 0.2 -> 3979 seconds in
%MacBookPro
q=sample(1:6);
qdot=sample(7:12);
v=qdot;
a=M(q)\Q(q,qdot);
A=Jv(q);
B = A*M(q)^(-1/2);
qdot = v + M(q)^(-1/2)*pinv(B)*(bq(t)-A*v-phi(q,t)/h);
dv=a+ M(q)^(-1/2)*pinv(B)*(bv(q,v,t)-A*a - dphi(q,v,t)/h);
braun_ddq=[qdot,dv];
braun_ddq=braun_ddq(:);
% noise = ;
% braun_ddq = braun_ddq + noise;
end