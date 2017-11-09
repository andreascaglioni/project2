clc;
close all;
clear;
%% compute error on external domain
S = [1., 0.; 0., 0.5];
Sinv = S^(-1);

f = @(x,y) 1/(2*pi*sqrt(det(S))) * exp((-0.5)*(x.^2*Sinv(1,1)+x.*y*(Sinv(1,2)+Sinv(2,1))+Sinv(2,2)*y.^2));
check = integral2(f,-inf,inf,-inf,inf);
fSquare = @(x,y) f(x,y).^2;
a = 2.5:0.5:5;
external_error = zeros(length(2.5:0.5:5),1);
for i = 1:length(a)
    ai = a(i);
    external_error(i) =  sqrt( integral2(fSquare , -inf,-ai,-inf,inf) + ...
                               integral2(fSquare , ai,inf,-inf,inf) + ...
                               integral2(fSquare , -ai,ai,ai,inf) + ...
                               integral2(fSquare , -ai,ai,-ai,-inf));
end

%% internal errors (from freefem)
internal_error = [0.02002438194206024; 0.006210732629485956; 0.001496091113411886; 0.0002751045508243029; 3.844472804500194e-05;  6.030059627944629e-06];
total_error =  external_error+internal_error;
loglog(a, internal_error, '.', a, external_error,'.', a, total_error, '.' , 'markersize', 20);
grid on;
legend ('internal', 'external', 'total');

