%*************************************************************************
%	> File Name: rneOFur5.m
%	> Author: lsqyRobot
%	> Mail: lsqyRobot@gmail.com
%	> Created Time: Thu Dec 12 08:18:39 2019
%*************************************************************************
%% ur5 dynamics parameters
function tau = rneOFur5(q, qdot, qddot,grav)
dh.alpha=[pi/2,0,0,pi/2,-pi/2,0];
dh.a=[0,-0.425,-0.39225,0,0,0];
dh.d=[0.089459,0,0,0.10915,0.09465,0.0823];
dh.m=[3.7,8.393,2.33,1.219,1.219,0.1632];
dh.r(:,1)=[0, -0.02561, 0.00193]';
dh.r(:,2)=[0.2125, 0, 0.1134]';
dh.r(:,3)=[0.15, 0, 0.0265]';
dh.r(:,4)=[0, -0.0018, 0.01634]';
dh.r(:,5)=[0, -0.0018, 0.01634]';
dh.r(:,6)=[0, 0, -0.001159]';
[Ix1,Iy1,Iz1]=deal(0.00375,0.00765,0.00765);
[Ix2,Iy2,Iz2]=deal(0.0085,0.208,0.208);
[Ix3,Iy3,Iz3]=deal(2.46e-4,0.00719,0.00719);
[Ix4,Iy4,Iz4]=deal(9.09e-4,0.00119,0.00119);
[Ix5,Iy5,Iz5]=deal(9.09e-4,0.00119,0.00119);
[Ix6,Iy6,Iz6]=deal( 1.22e-4,8.21e-5,8.21e-5);
dh.I(:,:,1)=diag([Ix1,Iy1,Iz1]);
dh.I(:,:,2)=diag([Ix2,Iy2,Iz2]);
dh.I(:,:,3)=diag([Ix3,Iy3,Iz3]);
dh.I(:,:,4)=diag([Ix4,Iy4,Iz4]);
dh.I(:,:,5)=diag([Ix5,Iy5,Iz5]);
dh.I(:,:,6)=diag([Ix6,Iy6,Iz6]);
dh.theta=q;
z0 = [0; 0; 1]; 
N=length(q);
    % ---------------------------------------------------------------------
    % Forward recursion, R 
    for i = 1 : N
        T = DH( i, dh);
        R(:,:,i) = T(1:3, 1:3)';  %%  R_{i,i-1}^T
				p(:,i) = R(:,:,i)*T(1:3,4);   
        if i > 1
            w(:,i)=R(:,:,i)*(w(:,i-1)+qdot(i).*z0); 
            wdot(:, i) = R(:,:,i)*(wdot(:, i-1) +  qddot(i).*z0 + ...
                cross(w(:, i-1), qdot(i).*z0));
            vdot(:,i) = R(:,:,i)*vdot(:,i-1) + cross(wdot(:,i), p(:,i)) + ...
                cross(w(:,i), cross(w(:,i),p(:,i)));
        else
            w(:, i) =  R(:,:,i)*(qdot(i).*z0);
            wdot(:, i) = R(:,:,i)*(qddot(i).*z0);
            vdot(:,i) = R(:,:,i)*grav' + cross(wdot(:,i), p(:,i)) + ...
                cross(w(:,i), cross(w(:,i),p(:,i)));  %%\cite{Robotics: Modelling, Planning and Control.}  
        end
    end
    % Backward recursion
    for i = N:-1:1
        vcdot = vdot(:,i) + cross(wdot(:,i),dh.r(:,i)) + ...
            cross(w(:,i),cross(w(:,i),dh.r(:,i)));
        F = dh.m(i)*vcdot;  %%m(i)*\ddot{p}_C_i^i
        NN = dh.I(:,:,i)*wdot(:,i)+cross(w(:,i),dh.I(:,:,i)*w(:,i));  
        if i < N
              f(:,i) = R(:,:,i+1).'*f(:,i+1)+F;
            n(:,i) =-cross(f(:,i),dh.r(:,i)+p(:,i))+R(:,:,i+1).'*n(:,i+1)+cross( R(:,:,i+1).'*f(:,i+1),dh.r(:,i))+NN;
        else
            f(:,i) = F;
            n(:,i) =-cross(f(:,i),dh.r(:,i)+p(:,i))+ NN;
        end
        tau(i) = n(:,i)'*R(:,:,i)*z0;
    end
end

function T = DH(i,dh)
cth = cos(dh.theta(i));
sth = sin(dh.theta(i));
ca = cos(dh.alpha(i));
sa = sin(dh.alpha(i));
d=dh.d(i); 
a=dh.a(i);
T= [cth,-sth*ca,sth*sa,a*cth;sth,cth*ca,-cth*sa,a*sth;0,sa,ca,d;0,0,0,1];
end
