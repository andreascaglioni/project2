%% plot convergence study of fisrt eigenvalue of FP operator
clc;
close all;
clear;
%% for FP operator with quadratic potential
res = [8 16 32 64 128 256];

%% for P1
eig = [-1.540290361979151 -0.7731296590611344 -0.5872411113824971 -0.5410867267235467 -0.5295644369174396 -0.5266848249256644];

%% plotting
err = abs(eig - eig(6)*ones(1,6));
loglog(res, err, '*');
grid on;
hold on;
xx = 8:0.5:256;
yy = xx.^(-2)*10^2;
loglog (xx,yy,'k-');
xlabel 'resolution 1/h';
ylabel 'eigenvalue error';
legend('error', 'h^{-2}');