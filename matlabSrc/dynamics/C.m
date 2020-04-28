function C = C(q,qd)
grav = [0,0,0];
n = length(q);
C = zeros(n,n);
Csq = zeros(n,n);
for j=1:n
    QD = zeros(1,n);
    QD(j) = 1;
    tau = rneOFur5(q, QD, zeros(1,n), grav);
    Csq(:,j) = Csq(:,j) + tau.';
end

for j=1:n
        for k=j+1:n
            QD = zeros(1,n);
            QD(j) = 1;
            QD(k) = 1;
            tau = rneOFur5(q, QD, zeros(1,n), grav);
            C(:,k) = C(:,k) + (tau.' - Csq(:,k) - Csq(:,j)) * qd(j)/2;
            C(:,j) = C(:,j) + (tau.' - Csq(:,k) - Csq(:,j)) * qd(k)/2;
        end
end
C = C + Csq * diag(qd);   
end