% please first execute "simu_post_process.m" before running this script

beta_tilde_ave = mean(beta_mattil_active, 4);

%% plot the first category for beta
figure;
imagesc(beta_tilde_ave(:, :, 1))  
oldcmap = colormap(pink); colormap( flipud(oldcmap) );
caxis([-0.01 3.01]);
cb1 = colorbar; set(cb1, 'ylim', [-0.01 3.01])
xticks(1:7)
% title(strcat('rep. ', num2str(g),',n=',num2str(n)))
xlabel('binary latent traits in the 1st layer'); 
ylabel('observed variables')
title('$(\beta_{j,k,1})$ for $n=2000$', 'interpreter','latex')
set(gca, 'FontSize', 18)
pbaspect([3 4 1])
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
% print('-r300', 'beta_ave_n1750', '-dpng')



% true
%% plot the first category for beta
fig = figure;
imagesc(beta_mat_true(:, :, 1))  
oldcmap = colormap(pink); colormap( flipud(oldcmap) );
lim = caxis; caxis([-0.01 3.01]);
cb1 = colorbar; set(cb1, 'ylim', [-0.01 3.01])
xticks(1:7)
% title(strcat('rep. ', num2str(g),',n=',num2str(n)))
xlabel('binary latent traits in the 1st layer'); 
ylabel('observed variables')
title('True $(\beta_{j,k,1})$', 'interpreter','latex')
set(gca, 'FontSize', 18)
pbaspect([2 4 1])
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
% print('-r300', 'beta_true', '-dpng')


%% eta
Bern_K_ave = mean(Bern_K_permute2(1:K0, :, :), 3);

figure; imagesc(Bern_K_ave)
oldcmap = colormap(pink); colormap( flipud(oldcmap) );



%% look at K_star
K_mean_perrep = mean(K_star_arrs(:, burn+1:thin:nrun), 2);
median(K_mean_perrep)

K_median_perrep = [median(K_star_arrs(:, burn+1:thin:nrun), 2), iqr(K_star_arrs(:, burn+1:thin:nrun), 2)];

median(K_median_perrep, 1)


