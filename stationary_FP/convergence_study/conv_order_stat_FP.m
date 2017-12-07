%% plot convergence study of solution of stationary FP equation

%clc;
%close all;
clear;
%% 

res = [16 32 64 128 256];
% quadratic
err = [0.02648485976584304 0.007217767105936836 0.001832842550137037 0.0004424192320062608 9.180890581274333*1.e-05];
% bistable
%err = [0.3864418691468419 0.006229823940074001 0.001556950818473072 0.0003765438531757732 7.901035092883382e-05];


%% plotting
loglog(res, err, '*');
grid on;
hold on;
xx = 8:0.5:256;
yy = xx.^(-2)*10^1;
loglog (xx,yy,'k-');
xlabel 'resolution 1/h';
ylabel ' error wrt reference solution';
legend('error', 'h^{-2}');
