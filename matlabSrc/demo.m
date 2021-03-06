%*************************************************************************
%   > File Name: GUI.m
%   > Author: lsqyRobot
%   > Mail: lsqyRobot@gmail.com 
%   > Created Time: Sun May  3 07:36:58 2020
%***********************************************************************/
function demo()
addpath(genpath(pwd));
fig.robot = figure('NumberTitle','off','Name','lsqyRobot','Menubar','none');
set(fig.robot,'Units','normalized','Position',[0.2,0.2,0.7,0.7])
robotInit;
fig.hp = uipanel('Title','Control Panel','FontSize',12,...
             'BackgroundColor','white');    
fig.onlyGrav=uicontrol('Parent',fig.robot, ...
                 'style','push',...
                 'Units','normalized',...
                 'string','Gravity',...
                 'callback',{@onlyGrav},...
                 'backgroundc',[0.94 .94 .94],...
                 'busyaction','cancel',...
                 'interrupt','off');            
fig.init=uicontrol('Parent',fig.robot, ...
                 'style','push',...
                 'Units','normalized',...
                 'string','Init',...
                 'callback',{@initFcn},...
                 'backgroundc',[0.94 .94 .94],...
                 'busyaction','cancel',...
                 'interrupt','off');    
             
fig.Path=uicontrol('Parent',fig.robot, ...
                 'style','push',...
                 'Units','normalized',...
                 'string','path',...
                 'callback',{@plotPath},...
                 'backgroundc',[0.94 .94 .94],...
                 'busyaction','cancel',...
                 'interrupt','off');    
                        
fig.friction=uicontrol('Parent',fig.robot, ...
         'style','push',...
         'Units','normalized',...
         'string','Friction Case',...
         'callback',{@friction},...
         'backgroundc',[0.94 .94 .94],...
         'busyaction','cancel',...
         'interrupt','off');   
     
fig.PD=uicontrol('Parent',fig.robot, ...
         'style','push',...
         'Units','normalized',...
         'string','PD control',...
         'callback',{@pd},...
         'backgroundc',[0.94 .94 .94],...
         'busyaction','cancel',...
         'interrupt','off');  
     
fig.WS=uicontrol('Parent',fig.robot, ...
         'style','push',...
         'Units','normalized',...
         'string','work space',...
         'callback',{@WS},...
         'backgroundc',[0.94 .94 .94],...
         'busyaction','cancel',...
         'interrupt','off'); 
     
fig.myCase=uicontrol('Parent',fig.robot, ...
         'style','push',...
         'Units','normalized',...
         'string','Based on UK',...
         'callback',{@myCaseHaveNoise},...
         'backgroundc',[0.94 .94 .94],...
         'busyaction','cancel',...
         'interrupt','off');  
     
set(fig.hp,'Position',[.81 .15 .18 .8])
set(fig.onlyGrav,'Parent',fig.robot,'position',[0.85,0.55,0.1,0.05]) 
set(fig.init,'Parent',fig.robot,'position',[0.85,0.85,0.1,0.05]) 
set(fig.Path,'Parent',fig.robot,'position',[0.85,0.65,0.1,0.05]) 
set(fig.friction,'Parent',fig.robot,'position',[0.85,0.45,0.1,0.05]) 
set(fig.PD,'Parent',fig.robot,'position',[0.85,0.35,0.1,0.05]) 
set(fig.WS,'Parent',fig.robot,'position',[0.85,0.75,0.1,0.05])
set(fig.myCase,'Parent',fig.robot,'position',[0.85,0.25,0.1,0.05])

setappdata(0,'fig',fig)
end

function onlyGrav(~,~)
delete(gca)
robotInit;
load onlyGrav
this.qlist = qlist;
this.dqlist = dqlist;
this.endTime = endTime;
plotFcn(this,'pose')
end

function initFcn(~,~)
for i = 1:4
delete(gca)
end
hold off
robotInit;
end

function plotPath(~,~)
delete(gca)
robotInit;
load Qing
ur5Plot = qlist;
load Chun
ur5_backup;
UR5Plot = qlist;
poseur5 = zeros(length(ur5Plot),6);
poseUR5 = zeros(length(UR5Plot),6);
    for i = 1:length(ur5Plot)
        poseur5(i,:)= ur5FK(ur5Plot(i,:));
    end
    for i = 1:length(UR5Plot)
        poseUR5(i,:)= ur5FK(UR5Plot(i,:));
    end
        [px_ur5,py_ur5,pz_ur5] = deal(poseur5(:,1),poseur5(:,2),poseur5(:,3));
        [px_UR5,py_UR5,pz_UR5] = deal(poseUR5(:,1),poseUR5(:,2),poseUR5(:,3));
    speed = floor(0.03*length(poseUR5));
        deleyNum = abs(length(pz_UR5) -length(pz_ur5));
        for i = 1:speed:length(poseUR5)
        view([1,0.8,0.7])
        ur5.plot(ur5Plot(i,:))
        hold on   
        UR5.plot(UR5Plot(i,:))
        plot3(px_ur5(1:i+deleyNum),py_ur5(1:i+deleyNum),pz_ur5(1:i+deleyNum),'r-', 'LineWidth',1)
        plot3(px_UR5(1:i),py_UR5(1:i),pz_UR5(1:i),'r-', 'LineWidth',1)
        end   
end


function friction(~,~)
delete(gca)
load frictionData31.mat
this.qlist = qlist;
this.dqlist = [];
this.endTime = [];
plotFcn(this,'pose');
end

function pd(~,~)
delete(gca)
load pdControl.mat
this.qlist = qlist;
this.dqlist = [];
this.endTime = [];
plotFcn(this,'pose');
end

function WS(~,~)
delete(gca)
fig = getappdata(0,'fig');
workSpace(fig);
end


function myCaseHaveNoise(~,~)
delete(gca);
%% dataPre
load k10epMinus4.mat
fig = getappdata(0,'fig');
delete(fig.hp)
delete(fig.onlyGrav)
delete(fig.init)
delete(fig.Path)
delete(fig.friction)
delete(fig.PD)
delete(fig.WS)
delete(fig.myCase)
qList = qlist;
dqList = dqlist;
speed = floor(length(qList)*0.005);
endTime = 10;
t = [];
dt = endTime/length(qList);
    pose = zeros(length(qList),6);
for i = 1:length(qList)
    pose(i,:)= ur5FK(qList(i,:));
end
%[px,py,pz] = deal(pose(:,1),pose(:,2),pose(:,3));
noiseList1 = zeros(length(qlist),1);
noiseList2 = zeros(length(qlist),1);
phiList = zeros(length(qlist),3);
dphiList = zeros(length(qlist),3);

for i = 1:length(qlist)
    t = [t;i*dt];
    noiseList1(i) = noise(t(i),1,0.4,10);
    noiseList2(i) = noise(t(i),3,1,5);
    phiList(i,:) = phi(qList(i,:),t(i));
    dphiList(i,:) = dphi(qList(i,:),dqList(i,:),t(i));
end
[rx,ry,rz] = GetDesiredMotion(t);
ur5_model;
%%endData pre
a2 = subplot(2,3,3);
a3 = subplot(2,3,4);
a4 = subplot(2,3,5);
a5 = subplot(2,3,6);
a1 = subplot(2,3,[1,2]);
set(a1,'parent',gcf,'Units','normalized','Position',[0.2,0.5,0.4,0.45]);
for i = 1:speed:length(qList)

ur5.plot(qList(i,:))
hold on
plot3(a1,rx,ry,rz,'g-', 'LineWidth',0.5)
%plot3(a1,px(1:i),py(1:i),pz(1:i),'r-', 'LineWidth',0.3)


plot(a2,t(1:i),noiseList1(1:i),'r.','LineWidth',0.1);
plot(a5,t(1:i),noiseList2(1:i),'b.','LineWidth',0.1);
plot(a3,t(1:i),phiList(1:i,1),'r--',t(1:i),phiList(1:i,2),'g--',t(1:i),phiList(1:i,3),'b--');
plot(a4,t(1:i),dphiList(1:i,1),'r--',t(1:i),dphiList(1:i,2),'g--',t(1:i),dphiList(1:i,3),'b--');
end

xlabel(a2,'t/s')
ylabel(a2,'noise/rad')
xlabel(a5,'t/s')
ylabel(a2,'noise/rad')

xlabel(a3,'t/s')
ylabel(a3,'e/m')

xlabel(a4,'t/s')
ylabel(a4,'$\dot{e}$/m','Interpreter','latex')

end


function robotInit
	ur5_model;
	qz = zeros(1,6);
	ur5.plot(qz);
end

