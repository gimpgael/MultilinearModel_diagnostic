function [influence_points] = test_cook_distance(X, r)
% Function using the technique of Cook's distance to determine the outliers
% or influencial points.
% More information can be found here:
% https://en.wikipedia.org/wiki/Cook%27s_distance
%
% As Inputs:
% - X: [m n] explanatory variables of a model
% - r: [m 1] model residuals
%
% As Outputs:
% - influence_points: [1 o] list of "out of the box" observations

% Size checking
check_size(r, X)

% Extract full sample size
[m, n] = size(X);

% Computation
H = X * ((X'*X)\X');
h = diag(H);
t = r ./ (std(r) * sqrt(1-h));
D = t.^2 .* h ./ (n * (1-h));

% Influential points
influence_points = find(D > 4/(m-n));