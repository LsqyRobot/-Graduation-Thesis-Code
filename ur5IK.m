%/*************************************************************************
%	> File Name: ur5IK.m
%	> Author: lsqyRobot
%	> Mail: lsqyRobot@gmail.com
%	> Created Time: Wed Dec 18 15:21:43 2019
% ************************************************************************/
function obtainQ=ur5IK(PoseRef)
if length(PoseRef)~=6
	error('Input Error');
end
a=[0,-0.425,-0.39225,0,0,0];
d=[0.089459,0,0,0.10915,0.09465,0.0823];
[px,py,pz]=deal(PoseRef(1),PoseRef(2),PoseRef(3));
[Alpha,Beta,Gamma]=deal(PoseRef(4),PoseRef(5),PoseRef(6));
nx=cos(Alpha)*cos(Beta);
ny=cos(Alpha)*sin(Beta)*sin(Gamma)+sin(Alpha)*cos(Gamma);
nz=sin(Alpha)*sin(Gamma)-cos(Alpha)*sin(Beta)*cos(Gamma);
ox=sin(Alpha)*(-cos(Beta));
oy=cos(Alpha)*cos(Gamma)-sin(Alpha)*sin(Beta)*sin(Gamma);
oz=sin(Alpha)*sin(Beta)*cos(Gamma)+cos(Alpha)*sin(Gamma);
ax=sin(Beta);
ay=-cos(Beta)*sin(Gamma);
az=cos(Beta)*cos(Gamma);
pw(1)=px-d(6)*ax;
pw(2)=py-d(6)*ay;
pw(3)=pz-d(6)*az;
sintheta1phi=d(4)/sqrt( pw(1)^2+pw(2)^2);
costheta1phi=sqrt( 1-sintheta1phi^2);
phi=-atan2( pw(2),pw(1));
q1=q1Sol(sintheta1phi,costheta1phi,phi);
thetaSol=[];

for i=1:length(q1)
    q5=q5Sol(q1(i));
    for j=1:length(q5)
        try
	    q6=q6Sol(q1(i),q5(j));
        q234=q234Sol(q1(i),q5(j),q6);
        [q3,q2]=q3Sol(q1(i),q6);
        for k=1:length(q3)
            q4=q234-q3(k)-q2(k);
	     thetaSol=[thetaSol;q1(i),q2(k),q3(k),q4,q5(j),q6];
        end
        end
    end
end
[m,n]=size(thetaSol);
for i=1:m
	for j=1:n
		 if thetaSol(i,j)>pi
            thetaSol(i,j) =thetaSol(i,j)-2*pi;
         end
         if thetaSol(i,j)<-pi
             thetaSol(i,j) =thetaSol(i,j)+2*pi;
         end
	end
end
obtainQ=thetaSol;
function q1=q1Sol(sintheta1phi,costheta1phi,phi)
         q1(1)= atan2( sintheta1phi,-costheta1phi)-phi; 
         q1(2)= atan2( sintheta1phi,costheta1phi)-phi; 
end
function q5=q5Sol(q1)
         cosTheta5=-ay*cos(q1)+ax*sin(q1);
         sinTheta5=sqrt(1-cosTheta5^2);
         q5(1)=atan2(sinTheta5,cosTheta5);
         q5(2)=atan2(-sinTheta5,cosTheta5);
end
function q6=q6Sol(q1,q5)
         q6=atan2((oy*cos(q1)-ox*sin(q1))/sin(q5),(-ny*cos(q1)+nx*sin(q1))/sin(q5)); 
         %q6=atan2((oy*cos(q1)-ox*sin(q1)),(-ny*cos(q1)+nx*sin(q1))); 

end
function q234=q234Sol(q1,q5,q6)
q234=atan2(cos(q5)*(nz*cos(q6)-oz*sin(q6))-az*sin(q5),(-sin(q5)*(ax*cos(q1)+ay*sin(q1))...
	+cos(q5)*cos(q6)*(nx*cos(q1)+ny*sin(q1))-sin(q6)*cos(q5)*(ox*cos(q1)+oy*sin(q1))));
end
function [q3,q2]=q3Sol(q1,q6)
c1=cos(q1)*(-ax*d(6)+d(5)*nx*sin(q6)+d(5)*ox*cos(q6)+px)+sin(q1)*(-ay*d(6)+d(5)*ny*sin(q6)+d(5)*oy*cos(q6)+py);
c2=-az*d(6)+d(5)*nz*sin(q6)+d(5)*oz*cos(q6)-d(1)+pz;
cosTheta3=(c1^2+c2^2-(a(2)^2+a(3)^2))/(2*a(2)*a(3));
sinTheta3=sqrt(1-cosTheta3^2);
q3(1)=atan2(sinTheta3,cosTheta3);  
q3(2)=atan2(-sinTheta3,cosTheta3);  
q2=atan2(c2*a(2)+a(3)*(c2*cos(q3)-c1*sin(q3)),c1*a(2)+a(3)*(c1*cos(q3)+c2*sin(q3)));
end
end
