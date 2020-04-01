function Phi = phi(q,t)
%pose = ur5FK(q);
a=[0,-0.425,-0.39225,0,0,0];
d=[0.089459,0,0,0.10915,0.09465,0.0823];
P(1)=cos(q(1))*(a(2)*cos(q(2))+a(3)*cos(q(2)+q(3))+d(5)*sin(q(2)+q(3)+q(4))...
       	-d(6)*sin(q(5))*cos(q(2)+q(3)+q(4)))+sin(q(1))*(d(6)*cos(q(5))+d(4));
P(2)=sin(q(1))*(a(2)*cos(q(2))+a(3)*cos(q(2)+q(3))+d(5)*sin(q(2)+q(3)+q(4)) ...
	-d(6)*sin(q(5))*cos(q(2)+q(3)+q(4)))-cos(q(1))*(d(6)*cos(q(5))+d(4));
P(3)=a(2)*sin(q(2))+a(3)*sin(q(2)+q(3))-d(6)*sin(q(2)+q(3)+q(4))*sin(q(5))-d(5)*cos(q(2)+q(3)+q(4))+d(1);
[rx,ry,rz]=GetDesiredMotion(t);
%Phi =  [pose(1)-rx;pose(2)-ry;pose(3)-rz];
Phi =  [P(1)-rx;P(2)-ry;P(3)-rz];
end
