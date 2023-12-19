function demo_generate_data
clc;clear all;close all;
randn('seed',0);
rand('seed',0);

load YearPredictionMSD
[m,d]=size(x);
seq = randperm(m,5000);
x = x(seq,:);
y = y(seq);
save dfdfd x y


% for i=11:18,
% [A,b]=getdata(i);
% size(A)
% size(b)
% end



