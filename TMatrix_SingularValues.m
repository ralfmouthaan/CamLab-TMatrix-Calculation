% Ralf Mouthaan
% University of Cambridge
% May 2022
%
% Script to plot the transmission matrix singular values.

clc; clear variables; close all;

load('T-Matrix.mat');

figure('position', [400 400 400 400]);

[U,S,V] = svd(T, 'econ');
Sdiag = diag(S);
plot(20*log10(Sdiag/Sdiag(1)), 'r-', 'linewidth', 3);
ylim([-40 0]);
xlim([0 1000]);
axis square;
xlabel('Mode Number');
ylabel('Singular Value (dB)');