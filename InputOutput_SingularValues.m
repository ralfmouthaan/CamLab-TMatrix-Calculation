% Ralf Mouthaan
% University of Cambridge
% August 2020
%
% Script to calculate T-matrix. Allows regularisation to be taken into
% account.

clc; clear variables; close all;

%% User-Defined Variables

bolConjugateEout = false; % Set to true if the wrong feature was selected in Fourier space for the off-axis holography.
EinNoiseFloor = 1e-3;
EoutNoiseFloor = 1e-2;

%% Read in data

Ein = dlmread('Holo In.txt').';
Eout = dlmread('Image Out.txt').';

if bolConjugateEout == true
    Eout = conj(Eout); 
end

%% Singular Values - Input

[~,S,~] = svd(Ein, 'econ');
S = diag(S);
Strunc = S > max(S)*EinNoiseFloor;

figure;
plot(S, 'b-');
hold on
plot(Strunc, 'rx');

title('Ein SVs');
xlim([1 1000]);
ylabel('Singular Value');
set(gca, 'FontSize', 14);
xlabel('Mode Number');
legend('Original Singular Values', 'Preserved Singular Values');

%% Singular Values - Output

[~,S,~] = svd(Eout, 'econ');
S = diag(S);
Strunc = S > max(S)*EoutNoiseFloor;

figure('Position', [400 400 400 400]);
plot(S, 'b-', 'LineWidth', 2);
hold on
plot(S, 'rx');

title('Eout SVs');
xlim([1 1000]);
ylabel('Singular Value');
set(gca, 'FontSize', 14);
xlabel('Mode Number');
legend('Original Singular Values', 'Preserved Singular Values');
