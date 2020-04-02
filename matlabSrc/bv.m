function bv = bv(q,dq,t)
eta=0.3;
ddrd=zeros(3,1);
bv=zeros(3,1);
dq=dq(:);
ddrd(1)=16*pi^2*eta*sin(2*pi*t)*sin(4*pi*t)-20*pi^2*eta*cos(2*pi*t)*cos(4*pi*t);
ddrd(2)=-20*pi^2*eta*sin(2*pi*t)*cos(4*pi*t)-16*pi^2*eta*sin(4*pi*t)*cos(2*pi*t);
ddrd(3)=-20*pi^2*eta*sin(2*pi*t)*cos(4*pi*t)-16*pi^2*eta*sin(4*pi*t)*cos(2*pi*t);
bv=ddrd-dotJv(q,dq)*dq;
end
