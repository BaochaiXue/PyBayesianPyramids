% This script draws figures for the splice junction data

addpath('./from_cluster')
load splice_CSPbeta_n3175p60_Kini7_d4;
% load splice1_overfitmix_n3175p60_Kini7_B5_d4;
% load splice_alpha2_overfitmix_n3175p60_Kini7_B5_d4;

% do not permute
tau_arr_permu = tau_arr;
Bern_K_arr_permu = Bern_K_arr;


% --- traceplots --- %
figure; 
for b = 1:B
plot(tau_arr_permu(b,1:nrun))
hold on
end
% legend({'1', '2', '3'})
legend({'1', '2', '3', '4', '5'})
xlabel('Gibbs iterations');
% title('tau traceplot');
title('traceplot for deep tensor core $(\tau_{b})$', 'Interpreter', 'Latex'); 
set(gca, 'FontSize', 18)
% print('-r300', 'splice_trace_tau_overfitmix', '-dpng')


figure
for k=2:6
    plot(squeeze(Bern_K_arr_permu(k,1,:)))
    hold on
    plot(squeeze(Bern_K_arr_permu(k,2,:)))
    hold on
    plot(squeeze(Bern_K_arr_permu(k,3,:)))
    hold on
end
xlabel('Gibbs iterations');
title('traceplot for deep tensor arms $(\eta_{kb})$', 'Interpreter', 'Latex'); 
set(gca, 'FontSize', 18)
% print('-r300', 'splice_trace_deep_arm3', '-dpng')



beta0_pomean = mean(beta0_arr(:,:,burn+1:thin:nrun), 3);
beta0_pomean

% Bern_K posterior mean
Bern_K_pomean = mean(Bern_K_arr_permu(1:K,:,burn+1:thin:nrun), 3);
Bern_K_pomean

figure; imagesc(Bern_K_pomean); colorbar

% tau posterior mean
tau_pomean = mean(tau_arr(:,burn+1:thin:nrun), 2);
fprintf('\ntau posterior mean is:\n')
tau_pomean



% % Q post. mean
Q_mat_pomean_binary = (mean(Q_mat_arr(:,1:K-1,burn+1:thin:nrun), 3) > 0.5);

% fprintf('\nlocation loading structure:\n')
% [(1:p)', Q_mat_pomean_binary]


% z_tau_mat post. mean
z_mat_pomean = mean(z_tau_mat_arr(:,:,burn+1:thin:nrun), 3);

[~, z_tau_mat_int] = max(z_mat_pomean, [], 2);

% option 1: if B = 3
% % calculates the best permutation
% [z_tau_perm, best_perm] = get_best_permute(z_tau_mat_int, gene_type);
% option 2: if B>3
z_tau_perm = z_tau_mat_int;



% heatmap
x = repmat(1:B,B,1); % generate x-coordinates
y = x'; % generate y-coordinates


% % A_mat post. mean
% A_post_mean_prob = mean(A_mat_arr(:,1:K,burn+1:end), 3);
A_post_mean_prob = A_mat_pomean(:,1:K-1);
A_mat_pomean_bin = (A_post_mean_prob > 0.5);
% 
% [gene_type, (1:n)', A_mat_pomean];


% ------- Rule List preparation begins here ------- %
% conver z_tau_perm and A_mat_pomean to multivariate binary rule lists
z_tau_binmat = zeros(n, B);
rows = (1:n)';
cols = z_tau_perm;
lin_idx = sub2ind([n, B],rows,cols);
z_tau_binmat(lin_idx) = 1;

ZA = [z_tau_binmat, A_mat_pomean_bin];

% % % % -- write to csv file -- %
% csvwrite('Y1_splice_K_upper7_alpha3.csv', [ZA, gene_type==1])
% csvwrite('Y2_splice_K_upper7_alpha3.csv', [ZA, gene_type==2])
% csvwrite('Y3_splice_K_upper7_alpha3.csv', [ZA, gene_type==3])


K_star_arrmat = zeros(K, nrun);
K_star_arrmat(K_star_arr, :) = 1;
% figure; imagesc(K_star_arrmat); colorbar
tabulate(K_star_arr)
tabulate(K_star_arr(burn+1:thin:nrun))

K_select = mode(K_star_arr(burn+1:thin:nrun));
traits_select = find(z_beta_vec > (1:K)');


% --- only retain those effective latent traits --- %
ZA_eff = [z_tau_binmat, A_mat_pomean_bin(:, traits_select)];
csvwrite('Y1_splice_K_upper7.csv', [ZA_eff, gene_type==1])
csvwrite('Y2_splice_K_upper7.csv', [ZA_eff, gene_type==2])
csvwrite('Y3_splice_K_upper7.csv', [ZA_eff, gene_type==3])
% % --- only retain those effective latent traits --- %

pink3 = pink(3);
% reversepink = [pink3(3,:); pink3(1,:)];
reversepink = [pink3(1,:); pink3(3,:)];


figure
ax1 = subplot(131);
imagesc(Q_mat_pomean_binary(:,traits_select));
xticks(1:length(traits_select))
xlabel('binary latent vars'); ylabel('p=60 locations'); pbaspect([1 1.5 1])
set(gca, 'FontSize', 12)
old1 = colormap(ax1,reversepink); 
bar1 = colorbar; bar1.Ticks = [0.25 0.75]; bar1.TickLabels = {'0' '1'};
title('loci loading')
% second plot
ax2 = subplot(132);
imagesc(A_mat_pomean_bin(:,traits_select));
xticks(1:length(traits_select))
xlabel('binary latent vars'); ylabel('n=3175 sequences'); pbaspect([1 1.5 1])
set(gca, 'FontSize', 12)
old2 = colormap(ax2,reversepink); colormap( flipud(old2) ); 
bar2 = colorbar; bar2.Ticks = [0.25 0.75]; bar2.TickLabels = {'0' '1'};
title('1st layer traits')
% third plot
ax3 = subplot(133);
imagesc(z_tau_binmat);
xticks(1:B)
xlabel('z membership'); ylabel('n=3175 sequences'); pbaspect([1 1.5 1])
set(gca, 'FontSize', 12); 
old3 = colormap(ax3,reversepink); colormap( flipud(old3) );
bar3 = colorbar; bar3.Ticks = [0.25 0.75]; bar3.TickLabels = {'0' '1'};
title('2nd layer membership')

% print('-r300', 'splice_csp_Kupper_7_Kfinal_5', '-dpng')
% print('-r300', 'splice_csp_overfit_B', '-dpng')

% -- plot the held-out sequence types -- %
figure
imagesc(gene_type); 
colormap(parula(3)); 
% cbh3 = colorbar; set(cbh3,'YTick', 1:3)
title('type'); set(gca, 'FontSize', 12)
xticks(''); xticklabels({''}); xlabel('held out')
ylabel('n=3175 sequences');
print('-r400', 'splice_type', '-dpng')



% -- look at the the Q_pomean -- %
[(1:p)', Q_mat_pomean(:,traits_select)]

p_set1 = 1:27;
p_set2 = 28:37;
p_set3 = 38:p;

figure
subplot(1,3,1)
imagesc(Q_mat_pomean(p_set1,traits_select));
subplot(1,3,2)
imagesc(Q_mat_pomean(p_set2,traits_select));
subplot(1,3,3)
imagesc(Q_mat_pomean(p_set3,traits_select));



