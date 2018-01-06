clc;
close all;
clear;
%% plotting potentials and invariants
potNumber = 3;
switch potNumber
    case 0
        S = [1,0;0,0.5];
        pot = @(x,y) ([x,y]*S*[x;y]);
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
inv_plot = zeros(length(xx));
pot_plot = inv_plot;
for i = 1:length(xx)
    for j = 1:length(xx)
        inv_plot(j,i) = inv(xx(i),xx(j));
        pot_plot(j,i) = pot(xx(i), xx(j));
        
    end
end
%% plot
figure;
colormap(parula);
subplot(1,2,1)
contour(xx,xx,inv_plot);
vv = -5:0.1:3; % for 3 wells
[C,h] = contour(xx,xx,pot_plot, vv);
grid on;
colorbar;
pbaspect([1 1 1]);
subplot(1,2,2)
%vv = 0.1:0.2:1.9; % for bistable
vv = exp(-vv); % for 3 wells
[C,h] = contour(xx,xx,inv_plot,vv);
grid on;
colorbar;
pbaspect([1 1 1]);
%clabel(C,h);