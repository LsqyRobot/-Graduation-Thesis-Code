%% kinematic parameters
DOF=6;
offset=0;
alpha=[pi/2,0,0,pi/2,-pi/2,0];
a=[0,-0.425,-0.39225,0,0,0];
d=[0.089459,0,0,0.10915,0.09465,0.0823];
for i=1:DOF
ur5Link(i) = Link([0,d(i),a(i),alpha(i)],'standard');
end

ur5=SerialLink(ur5Link,'name','ur5');
W=[-1.5, 1.5 -1.5  1.5 -1.5 1.5 ];
%ur5.teach([0,0,0,0,0,0],'workspace',W,'noshading','jaxes')	
%ur5.teach([-pi/2,-pi/2,0,-pi/2,0,0])


%% dynamics parameters
m=[3.7,8.393,2.33,1.219,1.219,0.1632];
grav=[0,0,9.81];
alpha=[pi/2,0,0,pi/2,-pi/2,0];
[a(1),a(4),a(5),a(6),d(2),d(3)]=deal(0);
[d(1),d(4),d(5),d(6)]=deal(0.089459,0.10915,0.09465,0.0823);
[a(2),a(3)]=deal(-0.425,-0.39225);
pc1=[0, -0.02561, 0.00193]';
pc2=[0.2125, 0, 0.1134]';
pc3=[0.15, 0, 0.0265]';
pc4=[0, -0.0018, 0.01634]';
pc5=[0, -0.0018, 0.01634]';
pc6=[0, 0, -0.001159]';
r=[pc1';pc2';pc3';pc4';pc5';pc6'];
[Ix(1),Iy(1),Iz(1)]=deal(0.00375,0.00765,0.00765);
[Ix(2),Iy(2),Iz(2)]=deal(0.0085,0.208,0.208);
[Ix(3),Iy(3),Iz(3)]=deal(2.46e-4,0.00719,0.00719);
[Ix(4),Iy(4),Iz(4)]=deal(9.09e-4,0.00119,0.00119);
[Ix(5),Iy(5),Iz(5)]=deal(9.09e-4,0.00119,0.00119);
[Ix(6),Iy(6),Iz(6)]=deal( 1.22e-4,8.21e-5,8.21e-5);


for i=1:DOF
ur5.links(i).qlim=[-2*pi,2*pi];   
ur5.links(i).I=[Ix(i),Iy(i),Iz(i)];
ur5.links(i).Jm=0;
ur5.links(i).G=0;
ur5.links(i).r=[r(i,1),r(i,2),r(i,3)];
ur5.links(i).m=m(i);
end
