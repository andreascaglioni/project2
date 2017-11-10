clc;
close all;
clear all;
%% plotting potentials and invariants

S = [1,0;0,0.5];
VQuad = @(x,y) (x.^2 + 0.5*y.^2);
invVQuad = @(x,y) (exp(-VQuad(x,y)));

X = -5:0.1:5;
Z = VQuad(X,X');
contourf(X,X,VQuad(X,X));