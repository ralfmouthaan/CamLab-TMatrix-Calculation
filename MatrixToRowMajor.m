% Ralf Mouthaan
% University of Cambridge
% February 2019

function [RetVal] = MatrixToRowMajor(X)

    if ismatrix(X) == false
        error('Expecting a matrix')
    end
    if ndims(X) ~= 2
        error('Expecting a 2D matrix')
    end
    if size(X, 1) == 1 || size(X, 2) == 1
        error('Expecting a 2D matrix')
    end

    RetVal = reshape(X.', [], 1);

end