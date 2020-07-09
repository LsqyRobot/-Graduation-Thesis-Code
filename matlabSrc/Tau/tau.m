function tau(q,dq,t)
a=M(q)\Q(q,dq);

Qc = A'*pinv(A*inv(M(q))*A')*(b-A*a);