%% plot convergence to stationary state study of unsteady FP equation bistable potential
clc;
close all;
clear;
set(0,'defaultAxesFontSize',16)
set(0,'defaultTextInterpreter','latex'); %trying to set the default
%% data importing
dir_name = 'data_quadratic/'; %'data_bistable/'
aa=[0. 0.1 0.35 1.];    % quadratic
%aa = [0  0.14 8 20]; %for bistable
%aa=[0 10 50 80]; % for 3-wells
for i = 1:length(aa)
    id(i) = fopen([dir_name 'conv_perturbation_' num2str(aa(i)) '.out']);
    err = fscanf(id(i), '%f');
    dt(i)=err(1);
    err = err(2:end); 
    err = err(find(err>1.e-13));
    nIter(i) = length(err);
    errV(i,1:nIter(i)) = err;
    tt = (dt(i):dt(i):nIter(i)*dt(i))';
    lambda(i,1:nIter(i)) = -log(err/err(3))./tt;
end

%% plotting
figure
set(gcf,'units','points','position',[0,0,500,300]);
for i = 1: length(aa)
    dtCurr = dt(i); nIterCurr = nIter(i);
    ttCurr = dtCurr:dtCurr:dtCurr*nIterCurr;
    semilogy(ttCurr, errV(i,1:length(ttCurr)),'-', 'linewidth',2);
    hold on;
end
tt1 = dt(1):dt(1):nIter(1)*dt(1);
semilogy(tt1, 10^(-3)*exp(-0.5*tt1), '--',ttCurr, 10^(-4)*exp(-0.75*ttCurr), '--', 'linewidth',2);
grid on;

%legend('a=0','a=0.14','a=8','a=20', 'C_1e^{-0.79t}','C_1e^{-4.2t}');
legend('a=0','a=0.1','a=0.35','a=1', 'C_1e^{-0.5t}','C_1e^{-0.75t}');
xlabel 'time t ';
ylabel '$\Vert \psi_t-\psi_\infty\Vert_{L^2(\psi_\infty^{-1})}$';
%% plot convergence rate
figure;
for i = 1: length(aa)
    dtCurr = dt(i); nIterCurr = nIter(i);
    ttCurr = dtCurr:dtCurr:dtCurr*nIter;
    semilogy(ttCurr, lambda(i,1:length(ttCurr)),'-', 'linewidth',2);
    hold on;
end
grid on;
legend(num2str(aa'));
xlabel('time $t$');
ylabel('$-\frac{1}{t}\log{\frac{\Vert \psi_t-\psi_\infty\Vert_{L^2(\psi_\infty^{-1})}}{\Vert \psi_0-\psi_\infty\Vert_{L^2(\psi_\infty^{-1})}}}$');