function M = M(q)
grav = [0,0,0];
n = length(q);
M = zeros(n,n);
qdot = zeros(1,n);
for i = 1:n
    qddot = zeros(1,n);
    qddot(i)=1;
    M(i,:) = rneOFur5(q, qdot, qddot,grav);
end
end



