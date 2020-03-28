%/*************************************************************************
%	> File Name: ur5FK.m
%	> Author: lsqyRobot
%	> Mail: lsqyRobot@gmail.com
%	> Created Time: Mon Dec  2 11:24:07 2019
% ************************************************************************/
function poseRef=ur5FK(q)
if length(q)~=6
	error('Input Error');
end
a=[0,-0.425,-0.39225,0,0,0];
d=[0.089459,0,0,0.10915,0.09465,0.0823];
R(1,1)=sin(q(1))*sin(q(5))*cos(q(6))+cos(q(1))*(cos(q(2)+q(3)+q(4))*cos(q(5))*cos(q(6))  -sin(q(2)+q(3)+q(4))*sin(q(6)));
R(1,2)=-sin(q(1))*sin(q(5))*sin(q(6))-cos(q(1))*(sin(q(2)+q(3)+q(4))*cos(q(6)) +sin(q(6))*cos(q(2)+q(3)+q(4))*cos(q(5)));
R(1,3)=sin(q(1))*cos(q(5))-sin(q(5))*cos(q(1))*cos(q(2)+q(3)+q(4));
R(2,1)=cos(q(6))*(sin(q(1))*cos(q(2)+q(3)+q(4))*cos(q(5))-sin(q(5))*cos(q(1))) -sin(q(1))*sin(q(2)+q(3)+q(4))*sin(q(6));
R(2,2)=sin(q(6))*(sin(q(5))*cos(q(1))-sin(q(1))*cos(q(2)+q(3)+q(4))*cos(q(5))) -sin(q(1))*sin(q(2)+q(3)+q(4))*cos(q(6));
R(2,3)=-cos(q(1))*cos(q(5))-sin(q(1))*sin(q(5))*cos(q(2)+q(3)+q(4));
R(3,1)=sin(q(2)+q(3)+q(4))*cos(q(5))*cos(q(6))+sin(q(6))*cos(q(2)+q(3)+q(4));
R(3,2)=cos(q(2)+q(3)+q(4))*cos(q(6))-sin(q(2)+q(3)+q(4))*sin(q(6))*cos(q(5));
R(3,3)=-sin(q(2)+q(3)+q(4))*sin(q(5));
P(1)=cos(q(1))*(a(2)*cos(q(2))+a(3)*cos(q(2)+q(3))+d(5)*sin(q(2)+q(3)+q(4))...
       	-d(6)*sin(q(5))*cos(q(2)+q(3)+q(4)))+sin(q(1))*(d(6)*cos(q(5))+d(4));
P(2)=sin(q(1))*(a(2)*cos(q(2))+a(3)*cos(q(2)+q(3))+d(5)*sin(q(2)+q(3)+q(4)) ...
	-d(6)*sin(q(5))*cos(q(2)+q(3)+q(4)))-cos(q(1))*(d(6)*cos(q(5))+d(4));
P(3)=a(2)*sin(q(2))+a(3)*sin(q(2)+q(3))-d(6)*sin(q(2)+q(3)+q(4))*sin(q(5))-d(5)*cos(q(2)+q(3)+q(4))+d(1);
alpha = -atan2(R(1,2), R(1,1)); 
beta = atan(R(1,3)*cos(alpha)/R(1,1));
gamma = -atan2(R(2,3), R(3,3));
%% have problem
poseRef=[P(1),P(2),P(3),alpha,beta,gamma];
end
