function run_multi_newton_solver
    solver_params = struct('dXmin', 1e-14, 'ftol', 1e-14, 'max_iter', 200, 'dXmax', 1e8, 'numerical_diff', 1);
    X = [10; 20; 30];
    [X_out, flag] = multi_newton_solver(@test_function01, X, solver_params)
end