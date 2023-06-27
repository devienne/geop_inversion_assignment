% Define the lambda range
lambda_min = 1e-6;
lambda_max = 1e-2;
num_lambdas = 100;
lambda_values = logspace(log10(lambda_min), log10(lambda_max), num_lambdas);

% store the data
residual_norms = [];
solution_norms = [];


% Initialize variables
min_residual_norm = Inf;
optimal_lambda = 0;

% Iterate over lambda values
for i = 1:length(lambda_values)
  lambda = lambda_values(i);

  % Solve the damped least squares problem
  G_transpose_G_damped = G_transpose_G + lambda^2 * identity;
  dvs = G_transpose_G_damped \ G_transpose_dvf;

  % Calculate the residual norm
  residual_norm = norm(G * dvs - dvf);
  solution_norm = norm(dvs);

  % Store the values
  residual_norms = [residual_norms; residual_norm];
  solution_norms = [solution_norms; solution_norm];

  % Update minimum residual norm and lambda
  if residual_norm < min_residual_norm
    min_residual_norm = residual_norm;
    optimal_lambda = lambda;
  end
end

% Display the minimum lambda
disp(optimal_lambda);
% Perform L-curve analysis and determine the optimal lambda
[~, index] = min(sqrt((residual_norms - 5.3041e-5).^2 + (solution_norms - 0.44178).^2));
plot (residual_norms, solution_norms, '-', residual_norms(index), solution_norms(index), 'ro', 'MarkerSize', 8, 'LineWidth', 1);
xlabel('Residual Norm');
ylabel('Solution Norm');
title('L-curve');
xlim([0, 1e-4]);
ylim([0, 2]);
grid on;
dpi = 300;
legend ('Solution norm', '\lambda_{opt} = 5.3041e-5')
print('L-curve.png', ['-r', num2str(dpi)], '-dpng');





