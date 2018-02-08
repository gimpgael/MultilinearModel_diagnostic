% Time Series tool
% 
% Script based on the excellent book: Pratique de la regression lineaire
% multiple (in French), with the objective of providing a diagnostic over a
% time series. Objective is to produce a report for a specific time series.
%
% As Inputs:
% - X: [m 1] time serie to be analyzed
%
% As Outputs:
% - Report containing statistical tests and graphs

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dashboard
alpha = 0.05;                   % Threshold cut for quantiles
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
warning off all

% ----------------------------------------
% First step: Different graph analysis
% The variable from a time series perspective
figure;
plot(X)
title('Variable');

% Box plot
figure;
boxplot(X);
title('Variable box plot');

% Q-Q plot
figure;
qqplot(X);
title('Q-Q plot');

% Sample (Partial) Autocorrelation and partial Autocorrelation
figure;
subplot(2,1,1)
autocorr(X)
title('Autocorrelation')

subplot(2,1,2)
parcorr(X)
title('Partial Autocorrelation')
% ----------------------------------------

% ----------------------------------------
% Second step: Outliers
% Leverage test 
[observations_1] = test_leverage(X);
disp(['Based on the leverage test, outliers are observations number: ' num2str(observations_1')]);
% ----------------------------------------

% ----------------------------------------
% Third step: Stationarity Test
% Unit root test
[h1, pVal1] = adftest(X,'model','ARD','alpha',alpha);
if h1 == 1 
    UR = 'rejected';
else
    UR = 'not rejected';
end

% Stationarity test
[h0, pVal0] = kpsstest(X,'trend',false,'alpha',alpha);
if h0 == 1 
    ST = 'rejected';
else
    ST = 'not rejected';
end
disp('Unit root (ADF) test (Ho: parameter on y_t-1 = 0)');
disp(['           ' UR ' at ' num2str(alpha*100) '% - p-value = ' num2str(pVal1)]);
disp('Stationarity (KPSS) test:');
disp(['           ' ST ' at ' num2str(alpha*100) '% - p-value = ' num2str(pVal0)]);
% ----------------------------------------

% ----------------------------------------
% Fourth step: Different tests
% Symetry test
[rej2, pVal2] = test_symmetry(X, alpha);
if rej2 == 1 
    SY = 'rejected';
else
    SY = 'not rejected';
end

% Jarque-Bera test
[h, pVal3] = jbtest(X, alpha);
if h == 1 
    JB = 'rejected';
else
    JB = 'not rejected';
end

disp('Symmetry test (Ho: residuals symmetrically distributed):');
disp(['           ' SY ' at ' num2str(alpha*100) '% - p-value = ' num2str(pVal2)]);
disp('Jarque-Bera test (Ho: residuals normally distributed with unknown mean and variance):');
disp(['           ' JB ' at ' num2str(alpha*100) '% - p-value = ' num2str(pVal3)]);

% P-values for the different tests
analysis_summary = {'Test','Null hypothesis','p-value';...
                    'Unit root (ADF)','y_t-1 = 0', pVal1;...
                    'KPSS','stationarity', pVal0;...
                    'Symmetry','residuals symmetrically distributed', pVal2;...
                    'Jarque-Bera','residuals normally distributed', pVal3};
% ----------------------------------------
