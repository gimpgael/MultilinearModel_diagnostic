function [v1, v2] = test_Klein(X, r2)
% Function computing the Klein test: comparing the correlation squared 
% between two variables versus model R-square.
%
% As Inputs:
% - X: [m n] explanatory variables of a model
% - r2: model R-square
%
% As Outputs:
% - v1 and v2: [o 1] variables vectors when paired has a higher correlation
%   compared to the R-square model

% Square the correlation matrix
M = corr(X(:,var(X)~=0)); M = M.^2;

% Consider the upper diagonal
M = triu(M,1);

% Pairs
[v1, v2] = find(M > r2);