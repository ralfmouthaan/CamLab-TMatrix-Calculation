% Ralf Mouthaan
% University of Cambridge
% August 2020
%
% Script to calculate T-matrix. Allows regularisation to be taken into
% account by setting estimates on the noise floor.
% T is the transmission matrix from the SLM to the fibre output.
% Tfibre is the transmission matrix from the fibre input to the fibre
% output.

clc; clear variables; close all;
addpath('Function Library/')

%% User-Defined Variables

bolCalculateTFibre = true;
bolConjugateEout = false; % Set to true if the wrong feature was selected in Fourier space for the off-axis holography.
EinNoiseFloor = 1e-3;
EinFftNoiseFloor = 1e-3;
EoutNoiseFloor = 1e-2;

%% Read in data

Ein = dlmread('Holo In.txt').';
Eout = dlmread('Image Out.txt').';

if bolConjugateEout == true
    Eout = conj(Eout); 
end

%% Calculate EinFftInv if necessary

% Assumes the fibre input facet is at the Fourier plane of the lens. Note,
% this is approximate, as it does not account for vignetting, etc.

if bolCalculateTFibre == true
    EinFft = zeros(size(Ein));
    for ii = 1:size(Ein, 2)
        x = Ein(:,ii);
        x = RowMajorToMatrix(x, sqrt(length(x)), sqrt(length(x)));
        x = fftshift(fft2(fftshift(x)));
        x = MatrixToRowMajor(x);
        EinFft(:,ii) = x;
    end
end

%% Inverse Calculations

% This is effectively lifted from pinv(), but doing it like this allows us
% to easy play with the noise floor a bit more easily.

% Ein
[U,S,V] = svd(Ein, 'econ');
S = diag(S);
NoSVs = sum(S > max(S)*EinNoiseFloor)+1;
V(:,NoSVs:end) = [];
U(:,NoSVs:end) = [];
S(NoSVs:end) = [];
S = 1./S(:);
EinInv = (V.*S.')*U';

% EinFft
[U,S,V] = svd(EinFft, 'econ');
S = diag(S);
NoSVs = sum(S > max(S)*EinFFtNoiseFloor)+1;
V(:,NoSVs:end) = [];
U(:,NoSVs:end) = [];
S(NoSVs:end) = [];
S = 1./S(:);
EinFftInv = (V.*S.')*U';

% Eout
[U,S,V] = svd(EOutNoiseFloor, 'econ');
S = diag(S);
NoSVs = sum(S > max(S)*1e-2)+1;
V(:,NoSVs:end) = [];
U(:,NoSVs:end) = [];
S(NoSVs:end) = [];
S = 1./S(:);
EoutInv = (V.*S.')*U';

%% Transmission Matrix Calculations

T = Eout * EinInv;
Tinv = Ein * EoutInv ;
Tfibre = Eout*EinFftInv;

%% Save Data

if bolCalculateTFibre == true
    save('T-Matrix.mat', 'T', 'Tinv', 'Tfibre');
else
    save('T-Matrix.mat', 'T', 'Tinv');
end
