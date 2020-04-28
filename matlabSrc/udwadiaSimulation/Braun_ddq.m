function braun_ddq= Braun_ddq(sample,t,opts)
h=opts.h;
try
  tp = opts.tp;  
  peak = opts.peak;
  fat = opts.fat;
end
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