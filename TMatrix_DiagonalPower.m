% Ralf Mouthaan
% University of Cambridge
%
% Script to plot out several properties of current transmission matrix.

clc; clear variables; close all;

%% Read in Transmission Matrix

% Read in transmission matrix
load('T-Matrix.mat');
TinvT = Tinv*T;
DiagPower = sum(diag(TinvT).^2);
fprintf('Power on diagonal: %f\n', sum(diag(abs(TinvT)).^2)/sum(sum(abs(TinvT).^2)));