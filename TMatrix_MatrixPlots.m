% Ralf Mouthaan
% University of Cambridge
%
% Script to plot out several properties of current transmission matrix.

clc; clear variables; close all;

%% Read in Transmission Matrix

% Read in transmission matrix
load('T-Matrix.mat');

%% Images of T-matrices

figure('Position', [400 400 400 400]);
imagesc(abs(T));
axis square;
title('T');
xticks(''); yticks('');

figure('Position', [400 400 400 400]);
imagesc(abs(Tinv));
axis square;
title('Tinv');
xticks(''); yticks('');

figure('Position', [400 400 400 400]);
imagesc(abs(T*conj(T).'));
axis square;
title('T^*T')
xticks(''); yticks('');

figure('position', [400 400 400 400]);
imagesc(abs(conj(T).'*T));
axis square;
title('TT^*')
xticks(''); yticks('');