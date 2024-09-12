function [c, r] = chebycenter(A, b, r0)
% CHEBYCENTER Compute Chebyshev center of polytope Ax <= b.
%   The Chebyshev center of a polytope is the center of the largest
%   hypersphere that can fit inside the polytope. This function solves for
%   the Chebyshev center using linear programming.
%
%   Inputs:
%       A - matrix of size [n x p], representing the linear constraints
%           of the polytope in the form Ax <= b.
%       b - column vector of size [n x 1], representing the RHS of the
%           linear constraints.
%       r0 - (optional) acceptable threshold (lower bound) for r.
%            It restricts the radius r <= r0.
%
%   Outputs:
%       c - the Chebyshev center, which is the center of the largest
%           inscribed hypersphere.
%       r - the radius of the largest hypersphere enclosed by the polytope.

% Determine the size of matrix A.
% n: number of constraints, p: dimension of the variable space.
[n, p] = size(A);

% Compute the norm of each row of A (Euclidean norm) to normalize the constraints.
% This ensures that the ball centered at c with radius r fits inside the polytope.
an = sqrt(sum(A.^2, 2));

% Form the augmented matrix A1 to include the radius variable r in the optimization.
% A1 will be of size [n x (p+1)], where the last column corresponds to r.
A1 = zeros(n, p + 1); % Initialize the augmented constraint matrix.
A1(:, 1:p) = A;       % Copy the original constraint matrix into the first p columns.
A1(:, p+1) = an;      % Assign the norms to the last column to relate to the radius r.

% Define the objective function for the linear program.
% We want to maximize the radius r, so we set the objective function as f = [0; 0; ...; -1].
% The last element corresponds to r, which we want to maximize (-1 means maximization).
f = zeros(p+1, 1);    % Initialize objective function.
f(p+1) = -1;          % Set the coefficient of r to -1 (maximize r).

% Set optimization options, disabling display for cleaner output.
options = optimset;                       % Create default options.
options = optimset(options, 'Display', 'off'); % Suppress output display.

% If a third argument r0 (threshold for r) is provided, set lower and upper bounds.
if nargin == 3
    lb = ones(p+1, 1) * -Inf;  % Lower bound for c and r (-Inf for unbounded).
    ub = ones(p+1, 1) * Inf;   % Upper bound for c and r (+Inf for unbounded).
    lb(p+1) = -Inf;            % No lower bound on r.
    ub(p+1) = r0;              % Upper bound on r is set to r0.
else
    % If r0 is not provided, leave bounds empty (no bounds).
    lb = [];
    ub = [];
end

% Solve the linear program using linprog.
% The problem is formulated as:
%   min f' * x subject to A1 * x <= b, with optional bounds lb <= x <= ub.
% x will contain the Chebyshev center c in the first p elements and the radius r in the (p+1)th element.
% Aeq and beq are empty (no equality constraints), and x0 (initial guess) is also empty.
c = linprog(f, A1, b, [], [], lb, ub, [], options);

% Extract the radius from the solution (last element).
r = c(p+1);

% Extract the Chebyshev center from the solution (first p elements).
c = c(1:p);

end
