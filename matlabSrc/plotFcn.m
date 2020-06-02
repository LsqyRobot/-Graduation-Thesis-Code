%{

    opts:   1)pose
            2)desiredMotion
            3)noise //three parameters, and time limit is [0,10]
            4)track
            5)Qu
%}


function plotFcn(model,opt)
try
    qList = model.qList;
    dqList = model.dqList;
    endTime = model.endTime;
    tspan=linspace(0,endTime,length(qList));
end
try
    qList = model.qlist;
    dqList = model.dqlist;
    endTime = model.endTime;
    tspan=linspace(0,endTime,length(qList));
end
try
    tp = model.tp;
    fat = model.fat;
    peak = model.peak;
end
try
    k = model.k;
    epsilon = model.epsilon;
end

try
    speed = floor(0.01*length(qList));
catch
    speed = floor(0.01*length(qlist));
end

    

if strcmp(opt,'Qu')
Q_u = zeros(length(qList),6);
for i = 1:length(qList) 
    Q_u(i,:) = Qu(qList(i,:),dqList(i,:),tspan(i));   
end
figure
plot(tspan,Q_u)
end


    
if strcmp(opt,'noise')
    t = 0:0.005:10;
    noiseList = arrayfun(@(t)noise(t,tp,peak,fat),t);
    figure
    plot(t,noiseList,'g--','LineWidth',1)
    xlabel('t/s')
    ylabel('noise/rad')
end
    

    
ur5_model;
if strcmp(opt, 'pose')
    pose = zeros(length(qList),6);
    for i = 1:length(qList)
        pose(i,:)= ur5FK(qList(i,:));
    end
        [px,py,pz] = deal(pose(:,1),pose(:,2),pose(:,3));
        for i = 1:speed:length(qList)
        ur5.plot(qList(i,:))
        hold on   
        plot3(px(1:i),py(1:i),pz(1:i),'r-', 'LineWidth',1)
        hold off
        end
end

if strcmp(opt, 'track')
    
    [rx,ry,rz] = GetDesiredMotion(tspan);
    pose = zeros(length(qList),6);
    for i = 1:length(qList)
        pose(i,:)= ur5FK(qList(i,:));
    end
    [px,py,pz] = deal(pose(:,1),pose(:,2),pose(:,3));
    %figure
    for i = 1:speed:length(qList)
    ur5.plot(qList(i,:))
    hold on
    plot3(rx(1:i),ry(1:i),rz(1:i),'g-', 'LineWidth',1.5)
    plot3(px(1:i),py(1:i),pz(1:i),'r-', 'LineWidth',0.1)
    %title(['Time is :' num2str(i*endTime/length(qList)) 's'])
    hold off
    end
end


if strcmp(opt, 'phi')
phiList=zeros(3,length(qList));
dphiList=zeros(3,length(qList));
[rx,ry,rz] = GetDesiredMotion(tspan);
pose = zeros(length(qList),6);
for i = 1:length(qList)
  pose(i,:)= ur5FK(qList(i,:));
end

[px,py,pz] = deal(pose(:,1),pose(:,2),pose(:,3));


hold on
grid on
plot3(rx,ry,rz,'g-', 'LineWidth',1.5);
plot3(px,py,pz,'r--', 'LineWidth',0.1);
legend('excepted','real')
title(['k= ' num2str(k),'\epsilon =' num2str(epsilon)])
view(3)
hold off

for i=1:length(qList)
phiList(:,i)=phi(qList(i,:),tspan(i));
dphiList(:,i)=dphi(qList(i,:),dqList(i,:),tspan(i));
end
figure
plot(tspan,phiList(1,:),'r--',tspan,phiList(2,:),'g--',tspan,phiList(3,:),'b--');
legend('x','y','z')
xlabel('Time(s)')
ylabel('Position Error(m)')
figure
plot(tspan,dphiList(1,:),'r--',tspan,dphiList(2,:),'g--',tspan,dphiList(3,:),'b--');
legend('x','y','z')
xlabel('Time(s)')
ylabel('Velocity Error(m/s)')
end
end
