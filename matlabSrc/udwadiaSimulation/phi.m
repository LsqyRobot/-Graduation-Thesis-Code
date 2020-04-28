function Phi = phi(q,t)
pose = ur5FK(q);
[rx,ry,rz]=GetDesiredMotion(t);
Phi =  [pose(1)-rx;pose(2)-ry;pose(3)-rz];
end
