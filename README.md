# CamLab-TMatrix-Calculation

Scripts for calculating the transmission matrix from the raw data, as collected by CamLab-TMatrix-Measurement.

- Input_OutputSingularValues.m calculates the singular values of Ein and Eout, corresponding to matrices of measured input fields and output fields, respectively.
- TMatrix_Calculation.m calculates the transmission matrix.
- TMatrix_Diagonalpower.m calculates the power on the diagonal of inv(T)\*T
- TMatrix_IncoherentSums.m displays the sum of the matrix rows and columns, giving an idea of what region of the SLM couples light into the fibre, what region of the input facet plane couples light into the fibre, and where in the output facet plane the light exits the fibre.
- TMatrix_MatrixPlots.m shows images of the calculated transmission matrix.
- TMatrix_SingularValues.m plots the singular values of the transmission matrix.
- TMatrix_SingularVectors.m plots the left-singular vectors and the right-singular vectors of the transmission matrix, corresponding to orthogonal input and output distributions respectively (Note, these are not propagation-invariant modes).

The TMatrix_Calculation.m script outputs a .mat file with a transmission matrix that is used by most of the other scripts, as well as scripts in the CamLab-TMatrix-Imaging and CamLab-TMatrix-Projection repositories.