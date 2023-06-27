lambda_values = [1.0e-3, 1.0e-2, 1.0e-1, 1.0, 10, 1.0e2, 1.0e3];
colors = {'red', 'blue', 'green', 'yellow', 'cyan', 'magenta', 'black'};

figure;
hold on;

for i = 1:length(lambda_values)
    lambda = lambda_values(i);
    color = colors{i};
    regularization = lambda^2 * (L' * L);
    model_operator = inv(A' * A + regularization) * (A' * dvf);
    m_reg = A * model_operator;
    % Display the inverted regularized model
    disp(m_reg);
    plot(z, vs0 + m_reg, 'color', color);
end

hold off;

% Add legend
legend(strsplit(num2str(lambda_values), ' '), 'Location', 'best');
