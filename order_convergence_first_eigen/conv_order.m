%% plot convergence study of fisrt eigenvalue of FP operator
clc;
close all;
clear;
%% for FP operator with quadratic potential
res = [8 16 32 64 128 256];

%% for P1
eig = [-1.540290361979152 -0.7731296590611334 -0.5872411113824976 -0.5410867267235473 -0.5295644369174399 -0.5266848249256638];
%% for P2
%eig = [-0.5878618912865899 -0.5307044251129157 -0.5260590710474976 -0.525746297057882 -0.5257263730415214 -0.5257251218213317];
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