clc;
close all;
clear all;

%% golden search results for quadratic

% % % for real part res = 100 but in range a \in -0.7, 0.7
% eeExt = [-0.751515 -0.751386 -0.751427 -0.751378 -0.751432 -0.75137 -0.498847 -0.751317 -0.751342 -0.751071 -0.751267 -0.751316 -0.751325 -0.725682 -0.621289 -0.575891 -0.546702 -0.526218 -0.512738 -0.505008 -0.502478 -0.505005 -0.512753 -0.526217 -0.546596 -0.576166 -0.62127 -0.725714 -0.75135 -0.751298 -0.751319 -0.751708 -0.751351 -0.745088 -0.75135 -0.751438 -0.751394 -0.751425 -0.751527 -0.751348 ];
% eeExt = -eeExt;
% % for modulus, res =100, but in range a \in -1., 1.
% eeExtMod = [1.0013 0.976675 0.952681 0.929413 0.90695 0.885351 0.498847 0.844879 0.826183 0.808353 0.79215 0.777048 0.763268 0.725682 0.621289 0.575891 0.546702 0.526218 0.512738 0.505008 0.502478 0.505005 0.512753 0.526217 0.546596 0.576166 0.62127 0.725714 0.763288 0.777045 0.79219 0.808863 0.826202 0.843709 0.864636 0.8854 0.907028 0.929491 0.952812 0.976578];
% aaExt = -1.:0.05:0.95;

%% golden search results bistable
eeExt = abs([-1.00298 -0.993865 -0.985053 -0.976554 -0.968379 -0.960542 -0.953055 -0.945934 -0.939195 -0.932856 -0.926937 -0.921453 -0.916442 -0.911918 -0.907909 -0.904446 -0.901557 -0.899274 -0.830009 -0.800627 -0.792554 -0.800627 -0.830009 -0.899274 -0.901557 -0.904445 -0.907909 -0.911918 -0.916443 -0.921458 -0.926937 -0.932856 -0.939195 -0.945934 -0.953055 -0.960542 -0.968379 -0.976554 -0.985053 -0.993865 -1.00305 -1.01248 -1.02219 -1.03217 -1.04242 -1.05293 -1.06369 -1.07471 -1.08596 -1.09745 -1.10917 -1.12112 -1.1333 -1.14569 -1.1583 -1.17112 -1.18415 -1.19738 -1.21082 -1.22446 -1.23829 -1.25232 -1.26654 -4.12268e-15 -4.18879e-15 -2.1491e-15 6.40549e-15 5.74006e-13 1.97183e-19]);
eeExtMod = [1.29119 1.25708 1.22397 1.19192 1.16102 1.13132 1.10292 1.07588 1.05031 1.02628 1.00389 0.983236 0.964426 0.947538 0.932671 0.919913 0.909347 0.901046 0.830009 0.800627 0.792554 0.800627 0.830009 0.901046 0.909347 0.919913 0.932671 0.947538 0.964427 0.983243 1.00389 1.02628 1.05031 1.07588 1.10292 1.13132 1.16102 1.19192 1.22397 1.25708 1.29106 1.32612 1.36208 1.39886 1.43644 1.47476 1.51379 1.55349 1.59382 1.63476 1.67627 1.71833 1.76091 1.804 1.84757 1.89161 1.9361 1.98102 2.02636 2.0721 2.11824 2.16476 2.21166 4.12268e-15 4.18879e-15 2.1491e-15 6.40549e-15 5.74006e-13 1.97183e-19 ];
aaExt = -1.:0.05:2.4;

%% plotting 
plot(aaExt, eeExt, '.', aaExt, eeExtMod, '.', 'markersize', 15);
legend 'real part' 'modulus'
xlabel 'perturbation'
ylabel 'spectral gap'
grid on;