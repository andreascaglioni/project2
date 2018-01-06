%% plot convergence to stationary state study of unsteady FP equation bistable potential
clc;
%close all;
clear;
set(0,'defaultAxesFontSize',15)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
%% data importing
dir_name = 'data_bistable/'

aa = [0 0.12 0.14 8 12 20];


for i = 1:length(aa)
    id(i) = fopen([dir_name 'conv_perturbation_' num2str(aa(i)) '.out']);
    err = fscanf(id(i), '%f');
    dt(i)=err(1);
    err = err(2:end); 
    err = err(find(err>1.e-14));
    nIter(i) = length(err);
    errV(i,1:nIter(i)) = err;
    tt = (dt(i):dt(i):nIter(i)*dt(i))';
    lambda(i,1:nIter(i)) = -log(err/err(3))./tt;
end

%% plotting
figure
for i = 1: length(aa)
    dtCurr = dt(i); nIterCurr = nIter(i);
    ttCurr = dtCurr:dtCurr:dtCurr*nIter;
    semilogy(ttCurr, errV(i,1:length(ttCurr)),'.-');
    hold on;
end
grid on;
legend(num2str(aa'));
%% plot convergence rate
figure;
for i = 1: length(aa)
    dtCurr = dt(i); nIterCurr = nIter(i);
    ttCurr = dtCurr:dtCurr:dtCurr*nIter;
    semilogy(ttCurr, lambda(i,1:length(ttCurr)),'.-');
    hold on;
end
grid on;
legend(num2str(aa'));
% 
% % unperturbed
% id_unpertrubed = fopen('data/conv_perturbation_0.out');
% err = fscanf(id_unpertrubed, '%f');
% dt = err(1);
% err = err(2:end);
% nIter = length(err);
% tt = (dt:dt:nIter*dt)';
% % perturbed 0.12
% id_pertrubed = fopen('data/conv_perturbation_0.12.out');
% errP = fscanf(id_pertrubed,'%f');
% dtP = errP(1);
% errP = errP(2:end); 
% nIterP = length(errP);
% ttP = (dtP:dtP:nIterP*dtP)';
% % perturbed 0.14
% id_pertrubed2 = fopen('data/conv_perturbation_0.14.out');
% errP2 = fscanf(id_pertrubed2,'%f');
% dtP2 = errP2(1); 
% errP2 = errP2(2:end); 
% nIterP2 = length(errP2);
% ttP2 = (dtP2:dtP2:nIterP2*dtP2)';
% % perturbed 8
% id_pertrubed3 = fopen('data/conv_perturbation_8.out');
% errP3 = fscanf(id_pertrubed3,'%f');
% dtP3 = errP3(1);
% errP3 = errP3(2:end); 
% nIterP3 = length(errP3);
% ttP3 = (dtP3:dtP3:nIterP3*dtP3)';
% % perturbed 12
% id_pertrubed4 = fopen('data/conv_perturbation_12.out');
% errP4 = fscanf(id_pertrubed4,'%f');
% dtP4 = errP4(1);
% errP4 = errP4(2:end); 
% nIterP4 = length(errP4);
% ttP4 = (dtP4:dtP4:nIterP4*dtP4)';
% % perturbed 20
% id_pertrubed5 = fopen('data/conv_perturbation_20.out');
% errP5 = fscanf(id_pertrubed4,'%f');
% dtP4 = errP4(1);
% errP4 = errP4(2:end); 
% nIterP4 = length(errP4);
% ttP4 = (dtP4:dtP4:nIterP4*dtP4)';
% %% get local rate of convergence
% lambda = -log(err/err(1))./tt;
% lambdaP = -log(errP/errP(1))./ttP;
% lambdaP2 = -log(errP2/errP2(1))./ttP2;
% lambdaP3 = -log(errP3/errP3(1))./ttP3;
% lambdaP4 = -log(errP4/errP4(1))./ttP4;
% theoretical_unperturbed = 0.5;
% theoretical_optimally_perturbed = 0.75;
%% plotting
% semilogy(tt, err,  ttP3, errP3, ttP, errP,ttP2, errP2,ttP4, errP4,tt, 1.e-3*exp(-0.5*tt), '--', ttP4, 1.e-4*exp(-0.75*ttP4), '--', 'linewidth', 2);
% hold on;
% grid on;
% xlabel 'time t ';
% ylabel '$\Vert \psi_t-\psi_\infty\Vert_{L^2(\psi_\infty^{-1})}$';
% legend ('unperturbed', 'perturbed 0.1','perturbed 0.35', 'perturbed 0.5', 'perturbed 1', 'theoretical unperturbed rate 0.5', 'theoretical best rate 0.75');
% %% plotting estimates of spectral gap from above
% semilogy(tt, lambda, ttP, lambdaP,ttP2, lambdaP2, ttP3, lambdaP3, ttP4, lambdaP4, [tt(1) tt(end)], [theoretical_unperturbed theoretical_unperturbed], 'linewidth', 2);
% hold on;
% grid on;
% xlabel('time $t$');
% ylabel('$-\frac{1}{t}\log{\frac{\Vert \psi_t-\psi_\infty\Vert_{L^2(\psi_\infty^{-1})}}{\Vert \psi_0-\psi_\infty\Vert_{L^2(\psi_\infty^{-1})}}}$');
% legend ('unperturbed', 'perturbed 0.35', 'perturbed 0.5','perturbed 0.1', 'perturbed 1', 'theoretical');