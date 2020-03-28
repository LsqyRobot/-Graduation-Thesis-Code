function dphi = dphi(q,dq,t)
dq=dq(:);
dphi=Jv(q)*dq-bq(t);
end