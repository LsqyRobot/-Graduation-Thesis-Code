function [fvL,fcL,fvR,fcR,VelR,Tau_fR,VelL,Tau_fL]=LSM(vel,tau_f,bound);  %函数的功能为最小二乘线性拟合摩擦力随随度的变化情况。
t=length(tau_f);
[vR,fR,vTimesTauR,vi2R,vL,fL,vTimesTauL,vi2L,fcR(1),fcL(1),fvL(1),fvR(1)]=deal(0);
[VelR,Tau_fR,VelL,Tau_fL]=deal([]);
for i = 1:t
	if vel(i)>bound  
		  VelR=[VelR;vel(i)];                         %统计速度大于0的样本数量,不满足条件的直接舍弃。
		  Tau_fR=[Tau_fR;tau_f(i)]; 				  %与速度对应的摩擦力的大小记录下来。
		  vR=vR+vel(i);                               %计算 速度总和下面类似
		  fR=fR+tau_f(i);
		  vTimesTauR=vTimesTauR+vel(i)*tau_f(i);
		  vi2R=vi2R+vel(i)^2;
		  if length(VelR)>1
		  fvR(i)=  (length(VelR)*vTimesTauR-vR*fR)/(length(VelR)*vi2R-vR^2);  
		  fcR(i)=(vi2R*fR-vR*vTimesTauR)/(length(VelR)*vi2R-vR^2);
		  end
	elseif i>1 
		  fvR(i)=fvR(i-1);
		  fcR(i)=fcR(i-1);
    end

    if vel(i)<-bound
		  VelL=[VelL;vel(i)];          
		  Tau_fL=[Tau_fL;tau_f(i)]; 
		  vL=vL+vel(i);            
		  fL=fL+tau_f(i);
		  vTimesTauL=vTimesTauL+vel(i)*tau_f(i);
		  vi2L=vi2L+vel(i)^2;
		  if length(VelL)>1
		  fvL(i)=(length(VelL)*vTimesTauL-vL*fL)/(length(VelL)*vi2L-vL^2);  
		  fcL(i)=(vi2L*fL-vL*vTimesTauL)/(length(VelL)*vi2L-vL^2);
		  end
    elseif i>1
		  fvL(i)=fvL(i-1);
	      fcL(i)=fcL(i-1);
	end
end
