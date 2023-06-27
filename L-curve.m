%% L - curve
lambda_values = linspace(-20, 2, 1000);
residual_norms = [];
solution_norms = [];
for i = 1:length(lambda_values)
  lambda = lambda_values(i);

  % Solve the damped least squares problem
  G_transpose_G_damped = G_transpose_G + lambda^2 * identity;
  dvs = G_transpose_G_damped \ G_transpose_dvf;

  % Calculate the residual norm and solution norm
  residual_norm = norm(G * dvs - dvf);
  solution_norm = norm(dvs);

  % Store the values
  residual_norms = [residual_norms; residual_norm];
  solution_norms = [solution_norms; solution_norm];
end

plot (residual_norms, solution_norms, '-');
xlabel('Residual Norm');
ylabel('Solution Norm');
title('L-curve');
xlim([0, 0.1]);
%ylim([0., 1]);
