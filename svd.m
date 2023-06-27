%%% Plot the model values vs0
k = 1
%%% Truncated SVD
[U, S, V] = svd(G);
U_truncated = U(:, 1:k);
S_truncated = S(1:k, 1:k);
V_truncated = V(:, 1:k);
S_inverse_truncated = pinv(S_truncated);
G_inv_truncated = V_truncated * S_inverse_truncated' * U_truncated';

%%% Inverted vector
dvs_inv_truncated = G_inv_truncated * dvf;

%%% Plot the inverted vector
figure;
plot(z, vs0, 'b-', 'LineWidth', 1, z, vs0 + dvs_inv_truncated, 'color', 'red', 'LineStyle', '-');
xlabel('Depth (z)');
ylabel('Model Value (v_{s_0}) vs. Inverted Model (v_{s_0} + d_{v_s})');
title('Inversion with Truncated SVD Method');
legend ('Level of truncation parameter k = 1', 'location', 'southeast')
grid on;
dpi = 300;
print('TSVD_inversion_results.png', ['-r', num2str(dpi)], '-dpng');

%%% Comparison between inverted (v_{f0} + d_{vfe}) phase velocity anomaly and ref. phase velocity (v_{f0}) model
dvfe_svd = G * dvs_inv_truncated;
figure;
plot (T, vf0, 'b-', T, vf0 + dvfe_svd, 'r-');
xlabel('Period (s)');
ylabel('Phase velocity anomaly(km/s)');
legend('Reference phase velocity anomaly (km/s)', 'Estimated phase velocity anomaly (km/s)', 'location', 'southeast');
title('Inverted (v_{f0} + d_{vfe}) and reference phase velocity (v_{f0}) model with TSVD')
grid on;
dpi = 300;
print('TSVD_dvfe_results.png', ['-r', num2str(dpi)], '-dpng');

%%% Calculate the unit covariance matrix
cov_matrix_svd = V_truncated * V_truncated';
imagesc(cov_matrix_svd);
colorbar;
xlabel('Column Index');
ylabel('Row Index');
title('Unit covariance matrix with TSVD method');
%grid on;
dpi = 300;
print('unit_cov_matrix_svd.png', ['-r', num2str(dpi)], '-dpng');


