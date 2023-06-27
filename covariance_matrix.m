% Calculate the unit covariance matrix
covariance_matrix = inv(G_transpose_G_damped);

% Plot the unit covariance matrix
figure;
imagesc(covariance_matrix);
colorbar;
% Set axis labels and title
xlabel('Column Index');
ylabel('Row Index');
title('Unit Covariance Matrix');
% Set the desired DPI value
dpi = 300;
% Export the figure with the specified DPI
print('cov_matrix.png', ['-r', num2str(dpi)], '-dpng');
