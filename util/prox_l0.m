function [X] = prox_l0(A,lambda)
% solving the following OP:
% min_{X} 0.5 ||X - A||_2^2 + lambda * ||X||_0
% min_{x} 0.5 xx - ax + lambda * ||x||_0
X = A;
I = find(((A.^2)./(2*lambda))<=1);
X(I) = 0;