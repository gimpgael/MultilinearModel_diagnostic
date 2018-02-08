function [influence_points] = test_leverage(X)
% Function using the technique of the Leverage to determine the outliers
% or influencial points.
% More information can be found here:
% https://en.wikipedia.org/wiki/Leverage_(statistics)
%
% As Inputs:
% - X: [m n] explanatory variables of a model
%
% As Outputs:
% - influence_points: [1 o] list of "out of the box" observations

% Extract full sample size
[m, n] = size(X);

% Computation
H = X*((X'*X)\X');
h = diag(H);

% Influential points
influence_points = find(h > 2 * n / m);