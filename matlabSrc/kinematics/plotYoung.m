
young;
obtainQ1 = zeros(length(qing),6);
obtainQ2 = zeros(length(chun),6);
for i = 1:length(qing)
sol = ur5IK([0.7,qing(i,1)-0.25,qing(i,2),0,0,0]);
obtainQ1(i,:)=sol(1,:)';
end

for i = 1:length(chun)
sol = ur5IK([0.7,chun(i,1)+0.25,chun(i,2),0,0,0]);
obtainQ2(i,:)=sol(1,:)';
end


qlist = obtainQ1;
saveName = 'Qing';
savePath = './matFile/';
save([savePath saveName],'qlist')
qlist = obtainQ2;
saveName = 'Chun';
savePath = './matFile/';
save([savePath saveName],'qlist')


% this.qlist = obtainQ1;
% plotFcn(this,'pose')
% hold on
% this.qlist = obtainQ2;
% plotFcn(this,'pose')
% hold off
