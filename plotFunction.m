%{

    opts:   1)pose
            2)desiredMotion


%}


function plotFunction(model,opt)
qList = model.qList;
dqList = model.dqList;
endTime = model.endTime;
tspan=linspace(0,endTime,length(qList));
ur5_model;
if strcmp(opt, 'pose')
    pose = zeros(length(qList),6);
    for i = 1:length(qList)
        pose(i,:)= ur5FK(qList(i,:));
    end
    [px,py,pz] = deal(pose(:,1),pose(:,2),pose(:,3));
    figure
    for i = 1:10:length(qList)
    ur5.plot(qList(i,:))
    hold on   
    plot3(px(1:i),py(1:i),pz(1:i),'r-', 'LineWidth',0.1)
    title(['((Euler integal method) Time is: '  num2str(i*endTime/length(qList))])
    hold off
    end
end


if strcmp(opt, 'pose')
    [rx,ry,rz] = GetDesiredMotion(tspan);
    pose = zeros(length(qList),6);
    for i = 1:length(qList)
        pose(i,:)= ur5FK(qList(i,:));
    end
    [px,py,pz] = deal(pose(:,1),pose(:,2),pose(:,3));
    figure
    for i = 1:10:length(qList)
    ur5.plot(qList(i,:))
    hold on
    plot3(rx(1:i),ry(1:i),rz(1:i),'g-', 'LineWidth',1.5)
    plot3(px(1:i),py(1:i),pz(1:i),'r-', 'LineWidth',0.1)
    title(['Time is :' num2str(i*endTime/length(qList)) 's'])
    hold off
    end
end
% 
% end
% 
% if plotPhi==1 && ~isempty(dqList)
% phiList=zeros(3,length(qList));
% dphiList=zeros(3,length(qList));
% % [rx,ry,rz] = GetDesiredMotion(tspan);
% %  pose = zeros(length(qList),6);
% % for i = 1:length(qList)
% %   pose(i,:)= ur5FK(qList(i,:));
% % end
% % 
% % [px,py,pz] = deal(pose(:,1),pose(:,2),pose(:,3));
% % 
% % figure
% % hold on
% % plot3(rx,ry,rz,'g-', 'LineWidth',1.5)
% % plot3(px,py,pz,'r--', 'LineWidth',0.1)
% % hold off
% 
% for i=1:length(qList)
% phiList(:,i)=phi(qList(i,:),tspan(i));
% dphiList(:,i)=dphi(qList(i,:),dqList(i,:),tspan(i));
% end
% 
% figure
% plot(tspan,phiList(1,:),'r--',tspan,phiList(2,:),'g--',tspan,phiList(3,:),'b--');
% legend('x','y','z')
% xlabel('Time(s)')
% ylabel('Position Error(m)')
% figure
% plot(tspan,dphiList(1,:),'r--',tspan,dphiList(2,:),'g--',tspan,dphiList(3,:),'b--');
% legend('x','y','z')
% xlabel('Time(s)')
% ylabel('Velocity Error(m/s)')
% end
% end
end
