function time_series_residuals(Y, X, r)
% Function used as diagnostic tool.
% It computes the residuals of a model, and then plot:
% - the residuals distribution
% - the residuals evolution across time
% - the residuals versus each explanatory variable
% - the residuals versus the dependent variable
%
% As Inputs;
% - Y: [m 1] dependent variable
% - X: [m n] explanatory variable
% - r: [m 1] residuals
%
% As Outputs:
% Charts

% Size checking
check_size(Y, X);
check_size(Y, r);

% Residuals in a time series format
figure;
subplot(211);
plot(r, '.b');
title('Residuals graph - time serie format');
xlabel('Time');
ylabel('Residuals');

% Distribution of residuals
subplot(212);
histogram(r);
title('Residuals distribution');

% Determine the dimension of the second plot
[~, n] = size(X);
nbre = ceil(sqrt(n));

figure;

% Residuals versus each explanatory variable
for var = 1:n
    subplot(nbre, nbre, var);
    plot(X(:,var), r, '.b');
    title(['Residuals versus Variable ' num2str(var)]);
    xlabel(['Variable' num2str(var)]);
    ylabel('Residuals');
end

% Residuals versus Y
figure;
plot(Y, r, '.b');
title('Residuals versus Dependent variable');
xlabel('Dependent variable');
ylabel('Residuals');

