clear 
close all
tic
for j=1:1000
 testQ=-2*pi *(rand(1,6)-0.5);
  poseRef=ur5FK(testQ);
  obtainQ=ur5IK(poseRef);
  if size(obtainQ,1)<4 && size(obtainQ,2)<4
		  size(obtainQ)
  end

  for i=1:size(obtainQ,1)
     poseError=ur5FK(obtainQ(i,:))-poseRef;
  end
  if max(max(abs(poseError)))>1e-10
      error('IK solver is wrong')
  end
end
toc   

