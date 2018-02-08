function graphs_box_plots(X)
% Function used as diagnostic tool.
% It produces the box plots graphs for all Xi variables (the explanatory
% variables).
%
% As Inputs;
% - X: [m n] explanatory variable
%
% As Outputs:
% - Subplot graph with the box plots

% Determine the dimension of the plot
[~, n] = size(X);
nbre = ceil(sqrt(n));
figure;

% Loop to plot all graphics showing boxes
for i = 1:n
    subplot(nbre, nbre, i);
    boxplot(X(:,i));
    title(['Variable X(' num2str(i) ') box plot']);
end