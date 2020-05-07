%*************************************************************************
%   > File Name: GUI.m
%   > Author: lsqyRobot
%   > Mail: lsqyRobot@gmail.com 
%   > Created Time: Sun May  3 07:36:58 2020
%***********************************************************************/
function robotGUI
addpath(genpath(pwd));
fig.robot = figure('NumberTitle','off','Name','lsqyRobot','Menubar','none');
set(fig.robot,'Units','normalized','Position',[0.2,0.2,0.7,0.7])
% fig.input = figure;
% set(fig.input,'Units','normalized','Position',[0.1,0.1,0.3,0.3])
hold off
robotInit;

fig.hp = uipanel('Title','Control Panel','FontSize',12,...
             'BackgroundColor','white',...
             'Position',[.81 .15 .18 .8]);
    
fig.onlyGrav=uicontrol('Parent',fig.robot, ...
                 'style','push',...
                 'Units','normalized',...
                 'position',[0.82,0.85,0.05,0.05],...
                 'string','Grav',...
                 'callback',{@onlyGrav},...
                 'backgroundc',[0.94 .94 .94],...
                 'busyaction','cancel',...
                 'interrupt','off');
             
fig.init=uicontrol('Parent',fig.robot, ...
                 'style','push',...
                 'Units','normalized',...
                 'position',[0.9,0.85,0.05,0.05],...
                 'string','Init',...
                 'callback',{@initFcn},...
                 'backgroundc',[0.94 .94 .94],...
                 'busyaction','cancel',...
                 'interrupt','off');    
             
fig.onlyGrav=uicontrol('Parent',fig.robot, ...
                 'style','push',...
                 'Units','normalized',...
                 'position',[0.82,0.75,0.05,0.05],...
                 'string','path',...
                 'callback',{@ncuPlot},...
                 'backgroundc',[0.94 .94 .94],...
                 'busyaction','cancel',...
                 'interrupt','off');    
             
             
fig.friction1=uicontrol('Parent',fig.robot, ...
         'style','push',...
         'Units','normalized',...
         'position',[0.9,0.75,0.08,0.05],...
         'string','Friction Case 1',...
         'callback',{@friction1},...
         'backgroundc',[0.94 .94 .94],...
         'busyaction','cancel',...
         'interrupt','off');          
             
fig.friction2=uicontrol('Parent',fig.robot, ...
         'style','push',...
         'Units','normalized',...
         'position',[0.9,0.65,0.08,0.05],...
         'string','Frictrion Case 2',...
         'callback',{@friction2},...
         'backgroundc',[0.94 .94 .94],...
         'busyaction','cancel',...
         'interrupt','off');   
     
 fig.friction2=uicontrol('Parent',fig.robot, ...
         'style','push',...
         'Units','normalized',...
         'position',[0.9,0.55,0.08,0.05],...
         'string','Teach',...
         'callback',{@teachRobot},...
         'backgroundc',[0.94 .94 .94],...
         'busyaction','cancel',...
         'interrupt','off');  

     
     
     
             
           
end

function onlyGrav(~,~)
delete(gca)
load onlyGrav
this.qlist = qlist;
this.dqlist = dqlist;
this.endTime = endTime;
plotFcn(this,'pose')
end

function initFcn(~,~)
delete(gca);
hold off
robotInit;
end


function ncuPlot(~,~)
load c304Data
this.qlist = q;
this.dqlist = [];
this.endTime = [];
plotFcn(this,'pose');
end



function friction1(~,~)
load frictionData11.mat
this.qlist = qlist;
this.dqlist = [];
this.endTime = [];
plotFcn(this,'pose');
end

function friction2(~,~)
load frictionData31.mat
this.qlist = qlist;
this.dqlist = [];
this.endTime = [];
plotFcn(this,'pose');
end


function teachRobot(~,~)
ur5_model;
qz = zeros(1,6);
ur5.teach(qz);
end

