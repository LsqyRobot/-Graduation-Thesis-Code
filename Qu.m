function Qu = Qu(q,dq,qa,dqa,t)
k=10;
epsilon=1e-4;     %%1) 1e-4 k=1; (2) k = 10, ep = 1e-4 (3) k = 10, ep=1e-5
% Ma = M(qa);
% Qa = Q(qa,dqa);
 A=Jv(qa);
% deltaDDotQ=Ma\(Qa+Qc(q,dq,t))-M(q)\(Q(q,dq)+Qc(q,dq,t));
% lambda_min=min(eig(A/(Ma)*pinv(A)));
% beta = ( norm(A)*norm(deltaDDotQ)+(norm(dotJv(qa,dqa))+k*(norm(A)))*norm(dphi(qa,dqa,t)))/lambda_min;
beta=1343.402;
s = dphi(qa,dqa,t) + k*phi(qa,t);
Qu = -beta*pinv(A)*(s/epsilon);