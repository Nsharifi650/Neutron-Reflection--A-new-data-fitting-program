function output = minimisation(IG,Data)

% IG is initial guess
coder.extrinsic('fminuit');
disp('Press min to minimise, return to exit code, call 5 to plot');

[a b c] = fminuit('Chi2',IG, [Data]);
output = [a]