% Ralf Mouthaan
% University of Cambridge
% August 2020
%
% Script to calculate T-matrix. Allows regularisation to be taken into
% account.

clc; clear variables; close all;

%% Read in data

Ein = dlmread('Holo In.txt').';
Ein_fft = zeros(size(Ein));
for ii = 1:size(Ein, 2)
    x = Ein(:,ii);
    x = RowMajorToMatrix(x, sqrt(length(x)), sqrt(length(x)));
    x = fftshift(fft2(fftshift(x)));
    x = MatrixToRowMajor(x);
    Ein_fft(:,ii) = x;
end
Eout = dlmread('Image Out.txt').';
%Eout = conj(Eout);

figure;
imagesc(abs(Eout));
title('Eout');

%% Take appropriate inverses

% This code is taken directly out of pinv(). I just do it myself so I can
% plot the singular values.

[U,S,V] = svd(Ein, 'econ');
S = diag(S);
figure;
plot(S, 'b-');
title('Ein SVs');
NoSVs = sum(S > max(S)*1e-3)+1;
V(:,NoSVs:end) = [];
U(:,NoSVs:end) = [];
S(NoSVs:end) = [];
hold on
plot(S, 'rx');
S = 1./S(:);
EinInv = (V.*S.')*U';

[U,S,V] = svd(Eout, 'econ');
S = diag(S);
figure('Position', [400 400 400 400]);
plot(S(1:end), 'b-', 'LineWidth', 2);
title('Eout SVs');
NoSVs = sum(S > max(S)*1e-2)+1;
V(:,NoSVs:end) = [];
U(:,NoSVs:end) = [];
S(NoSVs:end) = [];
hold on
plot(S(1:end), 'rx');
S = 1./S(:);
EoutInv = (V.*S.')*U';
xlim([1 1000]);
ylabel('Singular Value');
set(gca, 'FontSize', 14);
xlabel('Mode Number');
title('');
yline(86, 'k:', 'LineWidth', 2);
text(50, 200, '\tau*', 'FontSize', 14);
legend('Original Singular Values', 'Preserved Singular Values');

%% Calculate Ts

T = Eout * EinInv;
Tinv = Ein * EoutInv ;
Tfibre = Eout*pinv(Ein_fft); % THIS HAS NOT BEEN REGULARISED

save('T-Matrix.mat', 'T', 'Tinv', 'Tfibre');
