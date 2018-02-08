function [p, F] = test_chow(Y, X, s)
% Function using the Chow test to determine if any structural change within
% a time series, by comaping the regression coefficients.
% More information can be found here:
% https://en.wikipedia.org/wiki/Chow_test
%
% As Inputs:
% - Y: [m 1] dependent variable
% - X: [m n] explanatory variable
% - s: size of the first sample. The second sample will be with a size of
%   m-s
%
% As Outputs:
% - p: p-value of the test
% - F: Chow test statistic

% Size checking
check_size(Y, X)

% Extract full sample size
[m, n] = size(X);

% Split the data
Y1 = Y(1:s); Y2 = Y(s+1:end);
X1 = X(1:s,:); X2 = X(s+1:end,:);

% Computes the individual residuals and sum them
[~,~,r] = regress(Y,X); SCR = sum(r.^2);
[~,~,r1] = regress(Y1,X1); SCR1 = sum(r1.^2);
[~,~,r2] = regress(Y2,X2); SCR2 = sum(r2.^2);

% Computes the test and the probability
F = ( (SCR - (SCR1+SCR2) ) / n) / ( (SCR1+SCR2) / (m-2*n) );
p = 1-fcdf(F,n,m-2*n);