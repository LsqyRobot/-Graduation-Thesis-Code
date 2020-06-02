%*************************************************************************
%   > File Name: Kinematics.m
%   > Author: lsqyRobot
%   > Mail: lsqyRobot@gmail.com 
%   > Created Time: Mon Mar  2 11:39:44 2020
%***********************************************************************/
%% using RTB
ur5_model;
%% FK Test
qtest=rand(1,6);
figure
ur5.teach(qtest,'workspace',W,'noshading','noshadow')
pose=ur5FK(qtest);
position=pose(1:3);
EulerAngles=pose(4:6)*180/pi;
[position,EulerAngles];
%% IK Test
obtainQ=ur5IK(pose);
for i = 1:length(obtainQ)
figure
ur5.teach(obtainQ(i,:),'workspace',W,'noshading','noshadow')
end



