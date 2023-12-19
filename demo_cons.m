function demo_cons
% min_x 0.5 ||Ax-b||_2^2, s.t. ||x||_0 <=k
% min_x 0.5 x'A'Ax - b'Ax, s.t. ||x||_0 <=k

clc; close all; clear;
addpath('util','solver','data');
randn('seed',1);
rand('seed',1);

data_id = [1:4 11:14];


Alg1 = @(k,b,A,x0)CoSaMP(A,b,k);
Alg2 = @(k,b,A,x0)gp(b,A,size(A,2),'stopTol',k);
Alg3 = @(k,b,A,x0)OMP(k,b,A);
Alg4 = @(k,b,A,x0)proximal_gradient_l0c(x0,A,b,k);
Alg5 = @(k,b,A,x0)qpm(A,b,k);
Alg6 = @(k,b,A,x0)romp(k,A,b);
Alg7 = @(k,b,A,x0)ssp(k,A,b);
Alg8 = @(k,b,A,x0)DecAlg(x0,A,b,k,[12,2]);

for i=1:length(data_id)
    iwhich = data_id(i);
    [A,b] = getdata(iwhich);
    run_and_save(A,b,iwhich,Alg1,'cosamp');
    run_and_save(A,b,iwhich,Alg2,'gp');
    run_and_save(A,b,iwhich,Alg3,'omp');
    run_and_save(A,b,iwhich,Alg4,'prox');
    run_and_save(A,b,iwhich,Alg5,'qpm');
    run_and_save(A,b,iwhich,Alg6,'romp');
    run_and_save(A,b,iwhich,Alg7,'ssp');
    run_and_save(A,b,iwhich,Alg8,'hybrid1002');
end


function run_and_save(A,b,which,AlgHandle,mfilename)

ks = [3:5:50];
times = 5;

for j = 1:length(ks)
    k = ks(j);
    
    HandleObj = @(x)computeCSObj(x,A,b,k);
    fs =[];
    ts = [];
    for t=1:times
        randn('seed',t);
        rand('seed',t);
        x0 = randn(size(A,2),1)*1e-11;
        tic;
        x = AlgHandle(k,b,A,x0);
        ts(t) = toc;
        fs(t) = HandleObj(x);
    end
    One = [];
    One.fobj = min(0.5*b'*b,mean(fs));
    One.timespent = mean(ts);
    One.m = size(A,1);
    One.n = size(A,2);
    One.k = k;
    result{j} = One;
end

save(sprintf('result\\cons_%d_%s',which,mfilename),'result')

