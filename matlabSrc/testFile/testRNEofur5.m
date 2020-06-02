clear all
ur5_model;

for j=1:1000
qtest=rand(1,6);
qdtest=rand(1,6); 
qddtest=rand(1,6);
rtbRNE=ur5.rne_dh(qtest,qdtest,qddtest);
myRNE=rneOFur5(qtest,qdtest,qddtest,grav);
if abs(myRNE-rtbRNE)>1e-12
     error('Dynamics model is wrong!');
end
end



%% 
plotInertiaError=[];
plotCoriolisError=[];
plotGravityError=[];
for k = 1:100
qtest = rand(1,6);
qdtest = rand(1,6);
inertiaError=ur5.inertia(qtest) - inertiaOFUr5(qtest);
plotInertiaError = [plotInertiaError,reshape(inertiaError,[],1)];
coriolisError=ur5.coriolis(qtest,qdtest) - ur5Coriolis(qtest,qdtest);
plotCoriolisError = [plotCoriolisError,reshape(coriolisError,[],1)];
gravityError = ur5.gravload(qtest) - gravityForce(qtest,grav);
plotGravityError=[plotGravityError;gravityError];
end


figure
subplot(2,2,[1,2])
plot(plotInertiaError,'g.','LineWidth',2)
xlabel('Mass Matrix')
ylabel('Inertia Error')

subplot(2,2,3);
plot(plotCoriolisError,'g.','LineWidth',1.5)
xlabel('Coriolis Matrix')
ylabel('Coriolis Error')

subplot(2,2,4);
plot(plotGravityError','g.','LineWidth',1.5)
xlabel('Gravity vector')
ylabel('Gravity Error')






