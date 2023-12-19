function [fobj,grad] = computeObj(x,A,y)
diff = A*x-y;
fobj = 1/2*norm(diff,'fro')^2 ;
grad = A'*diff ;


