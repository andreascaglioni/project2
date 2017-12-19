%% plot convergence to stationary state study of unsteady FP equation
clc;
close all;
clear;
%% data importing

% unperturbed
id_unpertrubed = fopen('data/conv_perturbation_0.out');
err = fscanf(id_unpertrubed, '%f');
dt = err(1);
err = err(2:end);
% perturbed 0.35
id_pertrubed = fopen('data/conv_perturbation_0.35.out');
errP = fscanf(id_pertrubed,'%f');
dtP = errP(1);
errP = errP(2:end); 
% perturbed 0.5
id_pertrubed2 = fopen('data/conv_perturbation_0.5.out');
errP2 = fscanf(id_pertrubed2,'%f');
dtP2 = errP2(1);
errP2 = errP2(2:end); 
% perturbed 0.2
id_pertrubed3 = fopen('data/conv_perturbation_0.2.out');
errP3 = fscanf(id_pertrubed3,'%f');
dtP3 = errP3(1);
errP3 = errP3(2:end); 
% perturbed 1
id_pertrubed4 = fopen('data/conv_perturbation_1.out');
errP4 = fscanf(id_pertrubed4,'%f');
dtP4 = errP4(1);
errP4 = errP4(2:end); 
%% get local rate of convergence
nIter = length(err);
tt = (dt:dt:nIter*dt)';
lambda = -log(err/err(1))./tt;
lambdaP = -log(errP/errP(1))./tt;
lambdaP2 = -log(errP2/errP2(1))./tt;
lambdaP3 = -log(errP3/errP3(1))./tt;
lambdaP4 = -log(errP4/errP4(1))./tt;
theoretical = 0.5;
%% protting
loglog(tt, lambda, tt, lambdaP,tt, lambdaP2, tt, lambdaP3,tt, lambdaP4, [tt(1) tt(end)], [theoretical theoretical], 'linewidth', 2);
hold on;
grid on;
xlabel 'time';
ylabel 'local rate of convergence';
legend ('unperturbed', 'perturbed 0.35', 'perturbed 0.5','perturbed 0.1', 'perturbed 1', 'theoretical');