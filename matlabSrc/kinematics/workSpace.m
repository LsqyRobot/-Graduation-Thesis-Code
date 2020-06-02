%workSpace
% clear all
% clc
% close all
function workSpace(fig)
positionList = [];
eulerAngleList = [];
theta_min = -2*pi;
theta_max = 2*pi;
for k = 1:1e4
    q = theta_max - (theta_max-theta_min)*rand(1,6);
    poseRef = ur5FK(q);
    positionList = [positionList;poseRef(1:3)];
    eulerAngleList = [eulerAngleList;poseRef(4:end)];
end
 
[x,y,z]=deal(positionList(:,1),positionList(:,2),positionList(:,3));
[alpha,beta,gamma]=deal(eulerAngleList(:,1),eulerAngleList(:,2),eulerAngleList(:,3));


speed = floor(0.01*length(x));
for i = 1:speed:length(x)
fig.a1 = subplot(2,2,1);
scatter3(x(1:i),y(1:i),z(1:i),...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',[0 .75 .75],...
        'Marker', 'o',...
         'SizeData', 25);
 xlabel('x/m')
 ylabel('y/m')
 zlabel('z/m')
set(fig.a1,'Parent',fig.robot,'Units','normalized','Position',[0.1,0.6,0.3,0.3]);

%view(-30,10)


fig.a2 =  subplot(2,2,2);

scatter3(alpha(1:i),beta(1:i),gamma(1:i),...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',[0 .75 .75],...
        'Marker', 'o',...
         'SizeData', 15);
 xlabel('\alpha/rad')
 ylabel('\beta/rad')
 zlabel('\gamma/rad')
set(fig.a2,'Parent',fig.robot,'Units','normalized','Position',[0.45,0.6,0.3,0.3]);






fig.a3=subplot(2,2,3);
scatter3(x(1:i),y(1:i),0*z(1:i),...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor','r',...
        'Marker', 'o',...
         'SizeData', 25);
         hold on
scatter3(0*x(1:i),y(1:i),z(1:i),...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor','g',...
        'Marker', 'o',...
         'SizeData', 25);
scatter3(x(1:i),0*y(1:i),z(1:i),...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor','b',...
        'Marker', 'o',...
         'SizeData', 25);  
xlabel('x/m')
ylabel('y/m')
zlabel('z/m')
set(fig.a3,'Parent',fig.robot,'Units','normalized','Position',[0.1,0.2,0.3,0.3]);

%view(-30,10)
                   



fig.a4=subplot(2,2,4);
scatter3(alpha(1:i),beta(1:i),0*gamma(1:i),...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor','r',...
        'Marker', 'o',...
         'SizeData', 25);
         hold on
scatter3(0*alpha(1:i),beta(1:i),gamma(1:i),...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor','g',...
        'Marker', 'o',...
         'SizeData', 25);
scatter3(alpha(1:i),0*beta(1:i),gamma(1:i),...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor','b',...
        'Marker', 'o',...
         'SizeData', 25);  
xlabel('\alpha/rad')
ylabel('\beta/rad')
zlabel('\gamma/rad')
set(fig.a4,'Parent',fig.robot,'Units','normalized','Position',[0.45,0.2,0.3,0.3]);  
pause(1e-10)

end

%view([5,5,10])
end
