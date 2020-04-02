function Qc = Qc_mod(q,dq,alpha,beta,t)
a=M(q)\Q(q,dq);
A=Jv(q);
b=bv(q,dq,t);
hat_b=b-2*alpha*dphi(q,dq,t)-beta^2*phi(q,t);
Qc = A'*pinv(A*inv(M(q))*A')*(hat_b-A*a);