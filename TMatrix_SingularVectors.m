% Ralf Mouthaan
% University of Cambridge
%
% Script to plot out singular vectors of the transmission matrix

clc; clear variables; close all;

%%  Read in transmission matrix
load('T-Matrix.mat');

%% Determine Width and Height

% This relies on the processing being done on the same computer where the
% measurement was taken. Alternatively, set these manually.

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

%% Calculate SVD

[U,S,V] = svd(T, 'econ');

%% Plot singular vectors

for ii = 1:16

    i = ii; %randi([1, 50]);

    % Left-hand singular vector
    figure(1)
    x = U(:,i);
    x = RowMajorToMatrix(x, Width, Height);
    subplot(4,4,ii);
    imagesc(abs(x));
    axis square;
    title(num2str(i));

    % Right-hand singular vector
    figure(2)
    x = V(:,i);
    x = RowMajorToMatrix(x, Width, Height);
    subplot(4,4,ii);
    imagesc(abs(x));
    axis square;
    title(num2str(i));

end
