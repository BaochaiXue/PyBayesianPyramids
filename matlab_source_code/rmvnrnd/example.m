% Define the mean vector 'm' for the multivariate normal distribution
% m = [2, 0] means the first variable has a mean of 2, and the second variable has a mean of 0.
m = [2 0];

% Define the covariance matrix 'S' for the distribution
% The diagonal elements (1, 1) represent the variance of each variable.
% The off-diagonal elements (0.9, 0.9) represent the correlation between the two variables.
S = [1 0.9; 0.9 1];

% Generate 1000 random points from the multivariate normal distribution with mean 'm' and covariance 'S'.
% Constraints are applied using the matrix [-eye(2); eye(2)].
% -eye(2) creates a 2x2 identity matrix with negative signs, eye(2) creates a 2x2 identity matrix.
% These represent constraints on the variables.
% The [Inf; Inf; Inf; Inf] part represents that there are no actual limits (infinite bounds).
X = rmvnrnd(m, S, 1000, [-eye(2); eye(2)], [Inf; Inf; Inf; Inf]);

% Create a new figure (a blank plot window)
figure;

% Plot the generated points using a scatter plot.
% X(:,1) selects the first column of X (the x-axis values).
% X(:,2) selects the second column of X (the y-axis values).
% '.' specifies that each point is plotted as a dot.
plot(X(:,1), X(:,2), '.');
