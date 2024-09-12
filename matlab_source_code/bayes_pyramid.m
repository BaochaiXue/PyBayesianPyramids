function [filename] = bayes_pyramid(filename)

Y = readmatrix(filename);
% keyboard

% define the data tensor Y_arr from the data matrix Y
d = max(Y, [], 'all');
[n, p] = size(Y);
Y_arr = zeros(n, p, d);
for c = 1:d
    Y_arr(:, :, c) = (Y == c);
end

% MCMC setup
nrun = 15000; burn = 5000; thin = 5;

K_upper = 5; % user-specified; also can be set to p/3
B = 2; % user-specified; also can be ceil(log(K_upper/2)/log(2))
alpha0 = K_upper;

[Q_mat_arr, beta_mat_arr, beta0_arr, A_mat_arr, Bern_K_arr, tau_arr,...
    z_tau_mat_arr, sig2_beta_arr, K_star_arr, z_beta_vec_arr] ...
    = bp_csp_fun(Y_arr, K_upper, B, nrun, alpha0);

K_star = [median(K_star_arr(burn+1:thin:end)); iqr(K_star_arr(burn+1:thin:end))];
% track K_star_arr
K_star_arrs = K_star_arr;

z_beta_vec = mean(z_beta_vec_arr(:,burn+1:thin:end), 2);

% store other posterior means
% Q-matrix, permuted
Q_mat_pomean = mean(Q_mat_arr(:,:,burn+1:thin:end), 3);

% beta_mat, permuted
beta_mat_pomean = mean(beta_mat_arr(:,:,:,burn+1:thin:end), 4);

% get beta_tilde
beta_mat_tilde_arr = zeros(p, K_upper, d, nrun);
for ii=1:nrun
    beta_mat_tilde_arr(:,:,:,ii) = beta_mat_arr(:,:,:,ii) .* Q_mat_arr(:,:,ii);
end
beta_mattil_pomean = mean(beta_mat_tilde_arr(:,:,:,burn+1:thin:end), 4);

% beta0 posterior mean
beta0_pomean = mean(beta0_arr(:,:,burn+1:thin:end), 3);

% Bern_K posterior mean
Bern_K_pomean = mean(Bern_K_arr(:,:,burn+1:thin:end), 3);

% tau posterior mean
tau_pomean = mean(tau_arr(:,burn+1:thin:end), 2);

% A_mat and z posterior mean; A_mat permuted
A_mat_pomean = mean(A_mat_arr(:,:,burn+1:thin:end), 3);
z_mat_pomean = mean(z_tau_mat_arr(:,:,burn+1:thin:end), 3);
sig2_beta = mean(sig2_beta_arr(:,:,burn+1:thin:end), 3);

% output_file =

filename = strcat('simu_results.mat');
save(filename);

end