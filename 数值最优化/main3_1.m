x0 = [1; 1];
% [x_opt, fval] = steepest(@objective_function, @gradient_objective_function, x0);
% 
% disp(['Optimal solution: ', num2str(x_opt)]);
% disp(['Minimum value: ', num2str(fval)]);
x0 = [1; 1];
[x_opt, fval] = newton_method(@objective_function, @gradient_objective_function, @hessian_objective_function, x0);

disp(['Optimal solution: ', num2str(x_opt)]);
disp(['Minimum value: ', num2str(fval)]);