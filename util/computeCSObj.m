function [fobj] = computeCSObj(x,A,b,k)
x = proj_l0(x,k);
fobj = 0.5 * norm(A*x-b,'fro')^2;
