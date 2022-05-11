% Ralf Mouthaan
% University of Cambridge
% February 2019

function [RetVal] = RowMajorToMatrix(X, Width, Height)

    RetVal = reshape(X, [Width, Height]).';

end