function q_dq=ddq(q,t)
q=q(1:6);
v=q(7:12);
dv=M(q)\(Q(q,v)+Qc_mod(q,v,50,50,t));
q_dq=[v,dv];
q_dq=q_dq(:);