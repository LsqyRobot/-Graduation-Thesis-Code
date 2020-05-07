function tau_f = Fri(fv,fc,dq) 
dq = dq(:);
tau_f = fv*dq + fc;
tau_f(6) = 0;
end
