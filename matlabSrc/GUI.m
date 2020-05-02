%*************************************************************************
%   > File Name: GUI.m
%   > Author: lsqyRobot
%   > Mail: lsqyRobot@gmail.com 
%   > Created Time: Sun May  3 07:36:58 2020
%***********************************************************************/

  function myGUI

fig.h = figure;
set(fig.h,'Units','normalized','Position',[0.3,0.3,0.5,0.5])
fig.ax = axes('Parent',fig.h,'Units','normalized','Position',[0.1,0.1,0.7,0.7]);


uicontrol('Parent',fig.h,'Style','text','Enable','inactive','Units','normalized','Position',[0.82,0.73,0.1,0.1], ...
                       'FontSize',10,'String','LB','HorizontalAlignment','left');
                   
function lsqyMain(~,~)
addpath(genpath(pwd));
fig = getappdata(0,'fig');
rmpath(genpath(pwd));
end




