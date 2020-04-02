%*************************************************************************
%   > File Name: bqAndBv.m
%   > Author: lsqyRobot
%   > Mail: lsqyRobot@gmail.com 
%   > Created Time: Sat Mar  7 23:16:28 2020
%***********************************************************************/
function Bq = bq(t)
eta = 0.3;
Bq = zeros(3,1);
Bq(1)=-2*pi*eta*sin(2*pi*t)*cos(4*pi*t)-4*pi*eta*sin(4*pi*t)*cos(2*pi*t);
Bq(2)=2*pi*eta*cos(2*pi*t)*cos(4*pi*t)-4*pi*eta*sin(2*pi*t)*sin(4*pi*t);
Bq(3)=2*pi*eta*cos(2*pi*t)*cos(4*pi*t)-4*pi*eta*sin(2*pi*t)*sin(4*pi*t);
end
%A\dq =bq