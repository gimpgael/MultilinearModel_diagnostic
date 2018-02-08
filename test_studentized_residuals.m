function [influence_points] = test_studentized_residuals(X, r, alpha)
% Function using the technique of the studentized residuals test to 
% determine the outliers or influencial points.
% More information can be found here:
% https://en.wikipedia.org/wiki/Studentized_residual
%
% As Inputs:
% - X: [m n] explanatory variables of a model
% - r: [m 1] model residuals
% - alpha: value for the bilateral test (optional - by default 10%)
%
% As Outputs:
% - influence_points: [1 o] list of "out of the box" observations

% Extract full sample size
[m, n] = size(X);

if nargin < 3
    alpha = 0.1;
end

% Computation
H = X* ((X'*X)\X');
h = diag(H);
t = r ./ (std(r) * sqrt(1-h));
tStud = zeros(length(t),1);
for i = 1:length(t)
    tStud(i) = t(i) * sqrt((m-n-1) / (m-n- t(i)^2));
end
test = tinv(1 - alpha / 2, m-n-1);

% Influential points
influence_points = find(tStud > test);