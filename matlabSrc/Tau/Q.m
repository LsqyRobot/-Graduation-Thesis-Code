function Q = Q(q,dq)
grav=[0,0,9.81];
dq=dq(:);
Q=-C(q,dq)*dq-G(q,grav)';
