function [variable_list] = test_VIF(X)
% Function computing the variance inflation factor (VIF) in order to
% determine the variables with high multicolinearity in a regression
% approach
% More information can be found here:
% https://en.wikipedia.org/wiki/Variance_inflation_factor
%
% As Inputs:
% - X: [m n] explanatory variables of a model
%
% As Outputs:
% - variable_list: [1 o] list of variables highly correlated with the other
%   ones.

% Correlation matrix between all variables
Mat = corr(X(:,var(X)~=0));
C = inv(Mat); c = diag(C);

% Return concerned variables
variable_list = find(c > 4);