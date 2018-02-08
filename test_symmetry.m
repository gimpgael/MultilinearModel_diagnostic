function [rej, pVal] = test_symmetry(r, alpha)
% Function computing the symetry test on a residual vector
%
% As Inputs:
% - r: [m 1] residuals
% - alpha: value for bilateral test (optional - by default 10%)
%
% As Outputs:
% - rej: boolean depending if the test is rejected (true) or not (false)
% - pVal: p-value

if nargin < 2
    alpha = 0.1;
end

n = length(r);
r2 = r.^2; r3 = r.^3;

% Empirical asymmetry coefficient
g = 1/n * sum(r3) / ((1/n * sum(r2)) ^(3/2));
z = g / sqrt(6/n);
pVal = 2*(1-normcdf(abs(z)));

% Test result
if pVal < alpha
    rej = true;
else
    rej = false;
end