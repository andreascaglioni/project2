%% plot convergence study of fisrt eigenvalue of Kol operator and compare it with FP
clc;
close all;
clear;
%% for Kol operator with quadratic potential
res = [8 16 32 64 128 256];
% for P1
eigKol = [-0.5025807753019748 -0.5025124668146099 -0.5024868248664364 -0.5024795616039632 -0.5024776839320485 -0.5024772104881058];

%% for FP operator 8same potential)
% for P1
eigFP = [-1.540290361979151 -0.7731296590611344 -0.5872411113824971 -0.5410867267235467 -0.5295644369174396 -0.5266848249256644];

%% plotting
errKol = abs(eigKol - (eigKol(end))*ones(1,length(eigKol)));
loglog(res, errKol, '*');
hold on;
errFP = abs(eigFP - (eigFP(end))*ones(1,length(eigFP)));
loglog(res, errFP, '*');
hold on;
xx = res(1):0.5:res(end);
yy = xx.^(-2)*10^(1.5);
loglog (xx,yy,'k-');
yy = xx.^(-2)*10^(-1.8);
loglog (xx,yy,'k-');
grid on;
xlabel 'resolution 1/h';
ylabel 'eigenvalue error';
legend('error Kol', 'error FP', 'h^{-2}', 'h^{-2}');
