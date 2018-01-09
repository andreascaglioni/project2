clc;
close all;
clear;
%% plotting potentials and invariants
potNumber = 3;
switch potNumber
    case 0
        S = [1,0;0,0.5];
        pot = @(x,y) (S(1,1)*x.*x+ (S(1,2)+S(2,1))*x.*y+S(2,2).*y.*y);%[x,y]*S*[x;y]);
    case 1
        pot = @(x,y) (0.25*(x.^2-1).^2+0.5*y.^2);
    case 2
        pot = @(x,y) (0.25*(y.^2-1).^2+ 1.25*(y-0.5*x).^2);
    case 3 
        %pot = @(x,y) (3*exp(-x.^2-(y-1/3).^2)-3*exp(-x.^2-(y-5/3).^2)-5*exp(-(x-1).^2-y.^2)-5*exp(-(x+1).^2-y.^2)+0.2*x.^4+0.2*(y-1/3)^4);
         pot= @(x,y) 3*exp(-x.^2-(y-1/3).^2)-3*exp(-x.^2-(y-5/3).^2)-5*exp(-(x-1).^2-y.^2)-5*exp(-(x+1).^2-y.^2)+0.2*x.^4+0.2*(y-1/3).^4;
end
inv = @(x,y) (exp(-pot(x,y)));

xx = -5:0.1:5;
yy = -5:0.1:5;
%xx = -3.5:0.1:3.5; yy = -3:0.1:4; %3-wells
inv_plot = zeros(length(xx));
pot_plot = inv_plot;
for i = 1:length(xx)
    for j = 1:length(yy)
        pot_plot(j,i) = pot(xx(i), yy(j));
        inv_plot(j,i) = inv(xx(i),yy(j));
    end
end
% normalizinnormalizing
int = integral2(inv,-inf,inf,-inf,inf);
inv_plot=inv_plot/int;
%% plot
figure;
x0=10; y0=10; width=1000; height=400;
set(gcf,'units','points','position',[x0,y0,width,height]);
subplot(1,2,1)
    vv = -4:0.5:5; % for 3 wells
    cm = gray(length(vv)*2); cm = cm(length(vv)/2+1:end,:); colormap(cm);
    [C,h] = contourf(xx,yy,pot_plot, vv);
    xlim([-2 2]); ylim([-1.5 2]); grid on; colorbar; set(gca,'FontSize',16);pbaspect([1 1 1]);
subplot(1,2,2)
    vv = exp(-vv)/int; % for 3 wells
    [C,h] = contourf(xx,yy,inv_plot,vv);
    xlim([-2 2]); ylim([-1.5 2]); grid on; colorbar; set(gca,'FontSize',16);pbaspect([1 1 1]);