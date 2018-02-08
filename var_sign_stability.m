function [pct] = var_sign_stability(Y, X, depth)
% Function testing the variables coefficient stability in a backtest
% approach for a multilinear regression.
%
% As Inputs:
% - Y: [m 1] dependent variable
% - X: [m n] explanatory variable
% - depth: time length for the back test
%
% As Outputs:
% - pct: [n 1] coefficients stability percentage

% Size checking
check_size(Y, X)

% Variables declaration
[m, n] = size(X);
coeffs = zeros(n, depth+1);
incr = 1;

% Construction of the coefficients matrix
for backtest = depth:-1:0  
    % Sub matrix
    y_int = Y(1:m-backtest,:); x_int = X(1:m-backtest,:);
    
    % Regress and stock coefficients
    b = regress(y_int,x_int); 
    coeffs(:, incr) = b;
    
    % Increase the incrementator
    incr = incr + 1;
end

% Grab the coefficients signs
sgn = sign(coeffs);

% Sum of the coefficients for each variables across the time
sum_coeff = abs(sum(sgn')) / (depth + 1);
pct = sum(sum_coeff) / n;



