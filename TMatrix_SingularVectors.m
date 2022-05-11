% Ralf Mouthaan
% University of Cambridge
%
% Script to plot out singular vectors of the transmission matrix
% Assumes square input and output fields

clc; clear variables; close all;

%%  Read in transmission matrix
load('T-Matrix.mat');

%% Calculate SVD

[U,S,V] = svd(T, 'econ');

%% Plot singular vectors

for ii = 1:16

    i = ii; %randi([1, 50]);

    % Left-hand singular vector
    figure(1)
    x = U(:,i);
    x = RowMajorToMatrix(x, sqrt(length(x)), sqrt(length(x)));
    subplot(4,4,ii);
    imagesc(abs(x));
    axis square;
    title(num2str(i));

    % Right-hand singular vector
    figure(2)
    x = V(:,i);
    x = RowMajorToMatrix(x, sqrt(length(x)), sqrt(length(x)));
    subplot(4,4,ii);
    imagesc(abs(x));
    axis square;
    title(num2str(i));

end
