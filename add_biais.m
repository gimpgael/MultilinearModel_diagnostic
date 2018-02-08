function X = add_biais(X, add_constant)
% Function adding (or not) a column with a biais to the independant
% variables.
%
% As Inputs:
% - X: [m n] explanatory variables
% - add_constant: 'Y' or 'N', depending if the user wants to add or not a
%   biais to the X.
%
% As Outputs:
% - X: [m n] explanatory variables

% Input checking
if sum(strcmp(add_constant, {'Y', 'N'})) ~= 1
    error('The variable add_constant shout be ''Y'' or ''N''')
end

% If required, add a biais
if strcmp(add_constant, 'Y') == 1
    X = [X ones(size(X,1), 1)];
end