function [x] = computeprox(theta,a,lambda)
% 0.5 theta ||x - a||^2 + g(x)
[x] = prox_l0(a,lambda/theta);