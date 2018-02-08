function graphs_variables(X)
% Function used as diagnostic tool.
% It produces time series graphs for all Xi variables (the explanatory
% variables).
%
% As Inputs;
% - X: [m n] explanatory variable
%
% As Outputs:
% - Subplot graph with the graphs in a time series format

% Determine the dimension of the plot
[~, n] = size(X);
nbre = ceil(sqrt(n));
figure;

% Individual graphs
for i = 1:n
    subplot(nbre, nbre, i);
    plot(X(:,i),'.b');
    title(['Variable X(' num2str(i) ')']);
end
