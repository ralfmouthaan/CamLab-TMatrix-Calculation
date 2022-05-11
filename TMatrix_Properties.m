% Ralf Mouthaan
% University of Cambridge
%
% Script to plot out several properties of current matrix.

clc; clear variables; close all;

%% Read in Transmission Matrix

% Read in transmission matrix
load('T-Matrix.mat');
TinvT = Tinv*T;

%% Diagonal Power Calculation

DiagPower = sum(diag(TinvT).^2);
fprintf('Power on diagonal: %f\n', sum(diag(abs(TinvT)).^2)/sum(sum(abs(TinvT).^2)));

%% Images of T-matrices

figure;

subplot(1,2,1);
imagesc(abs(T));
axis square;
title('T');

subplot(1,2,2);
imagesc(abs(Tinv));
axis square;
title('Tinv');

pause(1);

%% Images of matrix products

figure('Position', [400 400 400 400]);
imagesc(abs(T*conj(T).'));
axis square;
xticks(''); yticks('');

figure('position', [400 400 400 400]);
imagesc(abs(conj(T).'*T));
axis square;
xticks(''); yticks('');

pause(1);

%% Singular values

figure('position', [400 400 400 400]);

[U,S,V] = svd(T, 'econ');
Sdiag = diag(S);
plot(20*log10(Sdiag/Sdiag(2)), 'r-', 'linewidth', 3);
ylim([-40 0]);
xlim([0 1000]);
axis square;
xlabel('Mode Number');
ylabel('Singular Value (dB)');

pause(1);

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

figure('Position', [400 400 400 400]);
%subplot(1,3,3);
x = sum(abs(T.'));
x = RowMajorToMatrix(x, 60, 60);
imagesc(x);
axis square;
xlabel('x (px)'); ylabel('y (px)');
title('Fibre Output');

pause(1);

%% Left or Right Singular Values

figure;

for ii = 1:16
    i = ii; %randi([1, 50]);
    x = U(:,i);
    x = RowMajorToMatrix(x, Width, Height);
    subplot(4,4,ii);
    imagesc(abs(x));
    axis square;
    
    title(num2str(i));
end
