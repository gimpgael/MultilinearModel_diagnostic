function [influence_points] = test_DFFITS(X, r)
% Function using the technique DFFITS test to determine the outliers
% or influencial points.
% More information can be found here:
% https://en.wikipedia.org/wiki/DFFITS
%
% As Inputs:
% - X: [m n] explanatory variables of a model
% - r: [m 1] model residuals
%
% As Outputs:
% - influence_points: [1 o] list of "out of the box" observations

% Extract full sample size
[m, n] = size(X);

% Computation
H = X * ((X'*X)\X');
h = diag(H);
t = r ./ (std(r) * sqrt(1-h));
tStud = zeros(length(t),1);
tDFFITS = zeros(length(t),1);
for i = 1:length(t)
    tStud(i) = t(i) * sqrt((m-n-1) / (m-n- t(i)^2));
    tDFFITS = tStud(i) * sqrt(h(i) / (1-h(i)));
end

% Influential points
influence_points = find(tDFFITS > 2 * sqrt(n/m));