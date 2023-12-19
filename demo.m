% function demo
% min_x 0.5 ||Ax-b||_2^2, s.t. ||x||_0 <=k
% min_x 0.5 x'A'Ax - b'Ax, s.t. ||x||_0 <=k

clc; close all; clear all;
randn('seed',0);
rand('seed',0);
addpath('data','util','solver');


Alg1 = @(k,b,A,x0)CoSaMP(A,b,k);
Alg2 = @(k,b,A,x0)gp(b,A,size(A,2),'stopTol',k);
Alg3 = @(k,b,A,x0)ssp(k,A,b);
Alg4 = @(k,b,A,x0)OMP(k,b,A);
Alg5 = @(k,b,A,x0)proximal_gradient_l0c(x0,A,b,k);
Alg6 = @(k,b,A,x0)qpm(A,b,k);
Alg7 = @ (k,b,A,x0)romp(k,A,b);
Alg8 = @(k,b,A,x0)DecAlg(x0,A,b,k,[8;8]);


k = 100;
[A,b] = getdata(12);
 
x0 = randn(size(A,2),1)*1e-7;

HandleObj = @(x)0.5*norm(A*proj_l0(x,k)-b,'fro')^2;
x1  = Alg1(k,b,A,x0);
x2  = Alg2(k,b,A,x0);
x3  = Alg3(k,b,A,x0);
x4  = Alg4(k,b,A,x0);
x5  = Alg5(k,b,A,x0);
x6  = Alg6(k,b,A,x0);
x7  = Alg7(k,b,A,x0);

fprintf('Start to run our algorithm ...\n');
tic;
[x8,his]  = Alg8(k,b,A,x0); %plot(his)
toc;



fprintf('cosamp: %10.2f\n',HandleObj(x1));
fprintf('    gp: %10.2f\n',HandleObj(x2));
fprintf('   ssp: %10.2f\n',HandleObj(x3));
fprintf('   omp: %10.2f\n',HandleObj(x4));
fprintf('  prox: %10.2f\n',HandleObj(x5));
fprintf('   qpm: %10.2f\n',HandleObj(x6));
fprintf('  romp: %10.2f\n',HandleObj(x7));
fprintf('hybrid: %10.2f\n',HandleObj(x8));




