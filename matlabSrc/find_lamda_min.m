% %{
% Assuming noise peak is 0.2(rad) on joint/joint velocity?Just test in joint two, and the computation is much slowly than my predict
% s.t.
%           (1)abs(q-qa) < 0.2;
%           (2)abs(dq-dqa) < 0.2 ;
%           (3)t<=10;
%           (4)q/qa \in [-2*pi,2*pi], dq/dqa \in [-pi, pi]
%           Of course, Other optimal algorithm can also using in here.(^_^)
% %}
clear  all
clc
close all
Nvars = 24 + 1;  
lb1 = (-2*pi)*ones(1,12);  % Joint limit(q,qa) limit
ub1 = ( 2*pi)*ones(1,12);
lb2 = -pi*ones(1,12);    % Joint velocity (dq,dqa) limit
ub2 = pi*ones(1,12);
lb3 = 0;                   % Time limit
ub3 = 10;
lb = [lb1, lb2, lb3];
ub = [ub1, ub2, ub3];
%{
 GA toolbox, by the way, File-Exchange have lots of optimal algorithm, some are great, some are not(/doge).
 How to use GA toolbox? :help ga :)
%}
opts = gaoptimset('PopulationSize',100,'EliteCount',20,'CrossoverFraction',0.85,'Generations',200,'StallGenLimit',300,'TolFun',1e-20,'PlotFcns',@gaplotbestf);
tic
[x_lambda, lambda_min] = ga(@(x)optimal_lambda(x),Nvars,[],[],[],[],lb,ub,@(x)constraint(x),opts);
[x_beta, beta_max] = ga(@(x)optimal_beta(x,lambda_min),Nvars,[],[],[],[],lb,ub,@(x)constraint(x),opts);
toc 

%lambda_min  = 0.274325; beta_max = 1.5394e+03 < 1540


saveFile = 'GAToolBox.mat';
save(saveFile,'lambda_min','beta_max')





function lambda_min = optimal_lambda(sample) 
q = sample(1:6);
dq = sample(7:12);
qa = sample(13:18);
dqa = sample(19:24);
t = sample(25);
Ma = M(qa);
A=Jv(qa);
lambda_min=min(eig(A/(Ma)*pinv(A)));  % find min of lambda
end


function beta = optimal_beta(sample,lambda_min)
k=1;
q = sample(1:6);
dq = sample(7:12);
qa = sample(13:18);
dqa = sample(19:24);
t = sample(25);
Ma = M(qa);
Qa = Q(qa,dqa);
A=Jv(qa);
deltaDDotQ=Ma\(Qa+Qc(q,dq,t))-M(q)\(Q(q,dq)+Qc(q,dq,t)); % find max of beta
beta = -( norm(A)*norm(deltaDDotQ)+(norm(dotJv(qa,dqa))+k*(norm(A)))*norm(dphi(qa,dqa,t)))/lambda_min;
end



function [c,ceq] = constraint(sample)
q = sample(1:6);
dq = sample(7:12);
qa = sample(13:18);
dqa = sample(19:24);
t = sample(25);
ceq = [];
c=[abs(q-qa)-0.2;abs(dq-dqa)-0.2];
end



