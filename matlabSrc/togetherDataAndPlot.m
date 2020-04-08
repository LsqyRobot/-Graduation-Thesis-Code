close all
endTime = 10;
load k10epMinus4.mat
k10epMinus4.qList = qlist;
k10epMinus4.dqList = dqlist;
k10epMinus4.endTime = endTime;
k10epMinus4.k = 10;
k10epMinus4.epsilon = 1e-4;
%plotFcn(k10epMinus4,'phi');
%plotFcn(k10epMinus4,'track');
plotFcn(k10epMinus4,'Qu');