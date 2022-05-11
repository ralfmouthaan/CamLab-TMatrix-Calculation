% Ralf Mouthaan
% University of Cambridge
%
% Script to plot out several properties of current transmission matrix.

clc; clear variables; close all;

%% Read in Transmission Matrix

% Read in transmission matrix
load('T-Matrix.mat');

%% Get Width, Height

% This assumes the script is run on the same computer where the
% measurements were taken. Alternatively, can just enter these by hand.

fid = fopen("D:/RPM Data Files/Output Camera Pol 1.txt");
for i = 1:7
    s = fgets(fid);
end
s = fgets(fid);
s = strsplit(s, '\t');
Height = str2num(s{2})-2;
s = fgets(fid);
s = strsplit(s, '\t');
Width = str2num(s{2})-2;
fclose(fid);

%% Incoherent Sums

figure('Position', [400 400 400 400]);

%subplot(1,3,1);
x = sum(abs(T));
x = RowMajorToMatrix(x, sqrt(length(x)), sqrt(length(x)));
x(1,1) = (x(1,2) + x(2,1))/2;
imagesc(x);
axis square;
xlabel('x (px)'); ylabel('y (px)');
title('SLM');

figure('Position', [400 400 400 400]);
%subplot(1,3,2);
x = sum(abs(Tfibre));
x = RowMajorToMatrix(x, sqrt(length(x)), sqrt(length(x)));
imagesc(x);
axis square;
xlabel('x (px)'); ylabel('y (px)');
title('Fibre Input');

figure('Position', [400 400 400 400]);
%subplot(1,3,3);
x = sum(abs(T.'));
x = RowMajorToMatrix(x, 60, 60);
imagesc(x);
axis square;
xlabel('x (px)'); ylabel('y (px)');
title('Fibre Output');
