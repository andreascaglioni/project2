%% plot convergence study of first eigenvalue of Kol operator and compare it with FP
clc;
close all;
clear;

% % for Kol operator with quadratic potential P1
% resKol = [8 16 32 64 128 256];
% eigKol = [-0.5025807753019748 -0.5025124668146099 -0.5024868248664364 -0.5024795616039632 -0.5024776839320485 -0.5024772104881058];
% % for FP operator with quadratic potential P1
% resFP = [8 16 32 64 128 256];
% eigFP = [-1.540290361979151 -0.7731296590611344 -0.5872411113824971 -0.5410867267235467 -0.5295644369174396 -0.5266848249256644];

% for Kol operator with bistable potential P1
resKol = [8 16 64 128 256 512 1024];
eigKol = [-0.8441069143478424 -0.8058159443963826 -0.7930075548017084 -0.7923190273109462 -0.792146128137855 -0.792102855183316 -0.792092033931411];

% for FP operator with bistable potential P1
resFP = [64 128 256 512 1024];
eigFP = [ -0.9305772839236884 -0.8278874149376021 -0.8012101327772743 -0.7944751493558576 -0.7927872369830383]


%% compute error
errKol = abs(eigKol - (eigKol(end))*ones(1,length(eigKol)));
errFP = abs(eigFP - (eigFP(end))*ones(1,length(eigFP)));
loglog(resKol, errKol, '*');
hold on;
loglog(resFP, errFP, '*');
hold on;
xxKol = resKol(1):0.5:resKol(end);
yyKol = xxKol.^(-2)*errKol(1)/resKol(1)^(-2.);
loglog (xxKol,yyKol,'k-');
xxFP = resFP(1):0.5:resFP(end);
yyFP = xxFP.^(-2) * errFP(1)/resFP(1)^(-2.);
loglog (xxFP,yyFP,'k-');
grid on;
xlabel 'resolution 1/h';
ylabel 'eigenvalue error';
legend('error Kol', 'error FP', 'h^{-2}', 'h^{-2}');
