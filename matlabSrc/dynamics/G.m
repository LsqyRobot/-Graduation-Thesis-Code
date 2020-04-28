function G=G(q,grav)
n=length(q);
G = rneOFur5(q,zeros(1,n),zeros(1,n),grav);
end