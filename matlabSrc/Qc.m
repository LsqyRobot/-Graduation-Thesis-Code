function Qc = Qc(q,dq,t)
a=M(q)\Q(q,dq);
A=Jv(q);
b=bv(q,dq,t);
Qc = A'*pinv(A*inv(M(q))*A')*(b-A*a); %this work  ok, but so slowly