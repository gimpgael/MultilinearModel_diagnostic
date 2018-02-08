function check_size(x,y)
% Function checking the number of observations of x and y, that should
% match
%
% As Inputs:
% x: [m n] explanatory variables
% y: [m 1] dependent variables
%
% As Outputs:
% error if the two variables do not have a size of m

% Size check
if size(x,1) ~= size(y,1)
    
    % List sizes - easier to debug
    disp(['Variables ' inputname(1) ' has ' num2str(size(x,1)) ' observations.'])        
    disp(['Variables ' inputname(2) ' has ' num2str(size(y,1)) ' observations.']) 
    
    % Error message
    error('The variables should have the same number of observations')
end