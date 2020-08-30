%*************************************************************************
%   > File Name: Jv.m
%   > Author: lsqyRobot
%   > Mail: lsqyRobot@gmail.com 
%   > Created Time: Fri Mar  6 16:10:08 2020
%***********************************************************************/

function JV = Jv(q)
a=[0,-0.425,-0.39225,0,0,0];
d=[0.089459,0,0,0.10915,0.09465,0.0823];
[q1,q2,q3,q4,q5,~]=deal(q(1),q(2),q(3),q(4),q(5),q(6));
Jv1=[cos(q1)*(d(6)*cos(q5)+d(4))-sin(q1)*(a(3)*cos(q2+q3)+a(2)*cos(q2)-d(6)*sin(q5)*cos(q2+q3+q4)+d(5)*sin(q2+q3+q4));cos(q1)*(a(3)*cos(q2+q3)+a(2)*cos(q2)-d(6)*sin(q5)*cos(q2+q3+q4)+d(5)*sin(q2+q3+q4))+sin(q1)*(d(6)*cos(q5)+d(4));0];
Jv2=[cos(q1)*(-a(3)*sin(q2+q3)-a(2)*sin(q2)+d(6)*sin(q5)*sin(q2+q3+q4)+d(5)*cos(q2+q3+q4));sin(q1)*(-a(3)*sin(q2+q3)-a(2)*sin(q2)+d(6)*sin(q5)*sin(q2+q3+q4)+d(5)*cos(q2+q3+q4));a(3)*cos(q2+q3)+a(2)*cos(q2)-d(6)*sin(q5)*cos(q2+q3+q4)+d(5)*sin(q2+q3+q4)];
Jv3=[cos(q1)*(-a(3)*sin(q2+q3)+d(6)*sin(q5)*sin(q2+q3+q4)+d(5)*cos(q2+q3+q4));sin(q1)*(-a(3)*sin(q2+q3)+d(6)*sin(q5)*sin(q2+q3+q4)+d(5)*cos(q2+q3+q4));a(3)*cos(q2+q3)-d(6)*sin(q5)*cos(q2+q3+q4)+d(5)*sin(q2+q3+q4)];
Jv4=[cos(q1)*(d(6)*sin(q5)*sin(q2+q3+q4)+d(5)*cos(q2+q3+q4));sin(q1)*(d(6)*sin(q5)*sin(q2+q3+q4)+d(5)*cos(q2+q3+q4));d(5)*sin(q2+q3+q4)-d(6)*sin(q5)*cos(q2+q3+q4)];
Jv5=[d(6)*(-cos(q1))*cos(q5)*cos(q2+q3+q4)-d(6)*sin(q1)*sin(q5);d(6)*cos(q1)*sin(q5)-d(6)*sin(q1)*cos(q5)*cos(q2+q3+q4);d(6)*(-cos(q5))*sin(q2+q3+q4)];
Jv6=[0;0;0];
JV=[Jv1,Jv2,Jv3,Jv4,Jv5,Jv6];
end
