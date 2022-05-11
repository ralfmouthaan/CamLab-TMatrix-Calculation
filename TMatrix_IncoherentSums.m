% Ralf Mouthaan
% University of Cambridge
%
% Script to plot out several properties of current transmission matrix.
% Assumes input and output fields are square.

clc; clear variables; close all;

%% Read in Transmission Matrix

% Read in transmission matrix
load('T-Matrix.mat');

%% Incoherent Sums

figure('Position', [400 400 400 400]);
x = sum(abs(T));
x = RowMajorToMatrix(x, sqrt(length(x)), sqrt(length(x)));
x(1,1) = (x(1,2) + x(2,1))/2;
imagesc(x);
axis square;
xlabel('x (px)'); ylabel('y (px)');
title('SLM');

if exist('Tfibre', 'var')
    figure('Position', [400 400 400 400]);
    x = sum(abs(Tfibre));
    x = RowMajorToMatrix(x, sqrt(length(x)), sqrt(length(x)));
    imagesc(x);
    axis square;
    xlabel('x (px)'); ylabel('y (px)');
    title('Fibre Input');
end

figure('Position', [400 400 400 400]);
x = sum(abs(T.'));
x = RowMajorToMatrix(x, sqrt(length(x)), sqrt(length(x)));
imagesc(x);
axis square;
xlabel('x (px)'); ylabel('y (px)');
title('Fibre Output');
