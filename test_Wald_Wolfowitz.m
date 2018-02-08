function [rej, pVal] = test_Wald_Wolfowitz(r, alpha)
% Function checking the randomness hypothesis for a two valued sequence
% More information can be found here:
% https://en.wikipedia.org/wiki/Wald%E2%80%93Wolfowitz_runs_test
%
% As Inputs:
% - r: [m 1] model residuals
% - alpha: value for the bilateral test (by default 5%)
%
% As Outputs:
% - rej: boolean depending if the test is rejected (true) or not
%   (false)
% - pVal: corresponding p-Value

n = length(r);
if nargin < 2
    alpha = 0.05;
end

% Separate positives and negatives residuals
nPos = (r > 0); nNeg = (r < 0);
mu = 2 * sum(nPos) * sum(nNeg) / n + 1;
sigma = sqrt((mu-1) * (mu-2) / (n-1));

% Number of sequences where residuals keep the same sign
seq = sum(abs(sign(diff([0;sign(r)]))));
z = (seq - mu) / sigma;
pVal = 2*(1-normcdf(abs(z)));

% Test
if pVal < alpha
    rej = true;
else
    rej = false;
end