% Comparison between inverted (v_{s0} + d_{vs}) and true (v_{st}) model
plot (z, vst, 'b-', z, vs0 + dvs, 'r-');
xlabel('Depth (km)');
ylabel('Wave velocity (km/s)');
grid on;
legend('Measured wave velocity (km/s)', 'Estimated wave velocity (km/s)', 'location', 'southeast');
title('Comparison between inverted (v_{s0} + d_{vs}) and true (v_{st}) model')
dpi = 300;
print('vs0_vs_vst.png', ['-r', num2str(dpi)], '-dpng');

% Comparison between inverted (v_{f0} + d_{vfe}) phase velocity anomaly and ref. phase velocity (v_{f0}) model
dvfe = G * dvs;
plot (T, vf0, 'b-', T, vf0 + dvfe, 'r-');
xlabel('Period (s)');
ylabel('Phase velocity anomaly(km/s)');
grid on;
legend('Reference phase velocity anomaly (km/s)', 'Estimated phase velocity anomaly (km/s)', 'location', 'southeast');
title('Inverted (v_{f0} + d_{vfe}) and reference phase velocity (v_{f0}) model')
dpi = 300;
print('vf0_vs_vfe.png', ['-r', num2str(dpi)], '-dpng');

% Calculate the model resolution matrix
G_transpose_G_damped = G' * G + lambda^2 * eye(size(G, 2));
model_resolution_matrix = pinv(G_transpose_G_damped) * G' \ G';

% Extend the model resolution matrix to 31x31
model_resolution_extended = [model_resolution_matrix, zeros(size(model_resolution_matrix, 1), size(G, 1) - size(model_resolution_matrix, 2))];
model_resolution_matrix = [model_resolution_extended; zeros(size(G, 1) - size(model_resolution_extended, 1), size(model_resolution_extended, 2))];

% Display the model resolution matrix
disp(model_resolution_matrix);

% Plot the model resolution matrix
imagesc(model_resolution_matrix);
colorbar;  % Add a colorbar for reference

% Set axis labels and title
xlabel('Column Index');
ylabel('Row Index');
title('Model Resolution Matrix');
%grid on;
dpi = 300;
print('res_matrix.png', ['-r', num2str(dpi)], '-dpng');
