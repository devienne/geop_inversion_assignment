A = G;
L = eye(size(G, 2));
D2 = diff(eye(size(G, 2)), 2);

lambda_values = [1.0e-3, 1.0e-2, 1.0e-1, 1.0, 10, 1.0e2, 1.0e3];
colors = {'red', 'blue', 'green', 'yellow', 'cyan', 'magenta', 'black'};

figure;
hold on;

for i = 1:length(lambda_values)
    lambda = lambda_values(i);
    color = colors{i};
    objective = @(m) norm(dvf - A * m)^2 + lambda^2 * norm(L * m)^2;
    m = fminunc(objective, zeros(size(G, 2), 1));
    % Display the flattest model
    disp(m);
    plot(z, vs0 + m, 'color', color, 'LineStyle', '-');
end

hold off;

% Add legend
legend(strsplit(num2str(lambda_values), ' '), 'Location', 'best');
title ('Flattest model for different values of \lambda')
xlabel ('Depth (km)')
ylabel ('Wave velocity (km/s)')
grid on;
% Set the desired DPI value
dpi = 300;
% Export the figure with the specified DPI
print('Flattest_model_results.png', ['-r', num2str(dpi)], '-dpng');
