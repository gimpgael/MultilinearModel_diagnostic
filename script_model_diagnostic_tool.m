% Model diagnostic tool
% 
% Script based on the excellent book: Pratique de la regression lineaire
% multiple (in French), with the objective of providing a diagnostic over a
% multilinear model. The model is characterized by its dependent variable Y
% and its explanatory variables X.
% The objective of this script is to have a look at a model, once this
% model has been defined by its input / output variables.
%
% As Inputs:
% - Y: [m 1] dependent variable
% - X: [m n] explanatory variables. It is the model
%
% As Outputs:
% - Report containing statistical tests and graphs

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dashboard
warning('off', 'stats:regress:RankDefDesignMat')    % Turn off the warning of the regress function
warning('off', 'MATLAB:singularMatrix')

alpha = 0.05;                                       % Threshold cut for quantiles
add_constant = 'Y';                                 % Add a column with a constant on the X
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Add biais if required
X = add_biais(X, add_constant);

% Multiple linear regression statistics
[b,bint,r,rint,stats] = regress(Y,X); 

% ----------------------------------------
% Outliers: Tests to determine if there are any outliers within the input
% variables

% Leverage test 
[observations_1] = test_leverage(X);

% Student residual test 
[observations_2] = test_studentized_residuals(X, r, alpha);

% DFFITS test 
[observations_3] = test_DFFITS(X, r);

% Cook distance 
[observations_4] = test_cook_distance(X, r);

% Print observations that could be considered as outliers
fprintf('\n==== Outliers tests ===\n');
disp(['Based on the leverage test, outliers are observations number: ' num2str(observations_1')]);
disp(['Based on the Student residual test, outliers are observations number: ' num2str(observations_2')]);
disp(['Based on the DFFITS test, outliers are observations number: ' num2str(observations_3')]);
disp(['Based on the Cook distance test, outliers are observations number: ' num2str(observations_4')]);
% ----------------------------------------

% ----------------------------------------
% Graphical analysis: Plot the different variables, as well as the
% residuals

% Box plots
graphs_box_plots(X)

% Time series graphs
graphs_variables(X)

% Focus on residuals
time_series_residuals(Y, X, r)

% Q-Q plot graphic
figure;
qqplot(r);
% ----------------------------------------

% ----------------------------------------
% Residuals analysis
% Durbin Watson test
pVal0 = dwtest(r,X);
if pVal0 < alpha
    DW = 'rejected';
else
    DW = 'not rejected';
end

% Wald-Wolfowitz Test
[rej1, pVal1] = test_Wald_Wolfowitz(r, alpha);
if rej1 == 1 
    WW = 'rejected';
else
    WW = 'not rejected';
end

% Symetry test
[rej2, pVal2] = test_symmetry(r, alpha);
if rej2 == 1 
    SY = 'rejected';
else
    SY = 'not rejected';
end

% Jarque-Bera test
[h, pVal3] = jbtest(r, alpha);
if h == 1 
    JB = 'rejected';
else
    JB = 'not rejected';
end

% Print results of residuals analysis
fprintf('\n==== Residual analysis ===\n');
disp('Durbin Watson test (Null hypothesis: residuals not correlated):');
disp(['           ' DW ' at ' num2str(alpha*100) '% - p-value = ' num2str(pVal0)]);
disp('Wald Wolfowitz test (Null hypothesis: elements of the sequence mutually independent):');
disp(['           ' WW ' at ' num2str(alpha*100) '% - p-value = ' num2str(pVal1)]);
disp('Symmetry test (Null hypothesis: residuals symmetrically distributed):');
disp(['           ' SY ' at ' num2str(alpha*100) '% - p-value = ' num2str(pVal2)]);
disp('Jarque-Bera test (Null hypothesis: residuals normally distributed with unknown mean and variance):');
disp(['           ' JB ' at ' num2str(alpha*100) '% - p-value = ' num2str(pVal3)]);

% P-values for the different tests
analysis_summary = {'Test','Null hypothesis','p-value';...
                    'Durbin Watson','residuals not correlated', pVal0;...
                    'Wald Wolfowitz','mutually independent', pVal1;...
                    'Symmetry','residuals symmetrically distributed', pVal2;...
                    'Jarque-Bera','residuals normally distributed', pVal3};         
% ----------------------------------------

% ----------------------------------------
% Multicollinearity test among the explanatory variables

% Matrix of correlation
Mat = corr(X(:,var(X)~=0));

% Klein Test
[varList] = test_Klein(X,stats(1));

% VIF Test
[var1] = test_VIF(X);

% Print suspicious variables
fprintf('\n==== Colinearity tests ===\n');
disp('Matrix correlation for all variables:');
disp(Mat);
disp('Variables appearing too strongly correlated based on Klein test are:');
disp(varList);
disp(['Based on the VIF test, variables too strongly correlated with others are: ' num2str(var1)]);
% ----------------------------------------

% ----------------------------------------
% Coefficient stability

% Tested sample size: half
pct = var_sign_stability(Y, X, round(length(Y)/2));

disp(['The coefficient stability test for the model is: ' num2str(pct * 100) ' %, based on ' num2str(round((round(length(Y)/2)/length(Y))*100)) '% of the sample']);
% ----------------------------------------

% ----------------------------------------
% Structural test
% Chow test for structural changes on half of the size
[p3, F] = test_chow(Y, X, round(length(Y)/2));

% The analyst can modify the p-value to determine the threshold
if p3 < alpha
    CW = 'a structural change';
else
    CW = 'no structural change';
end

% Print results on test for structural change
disp(['According to the Chow test there is ' CW ', (p-value = ' num2str(p3) '), at the '  num2str(round(length(Y)/2)) 'th data of the sample']);
% ----------------------------------------