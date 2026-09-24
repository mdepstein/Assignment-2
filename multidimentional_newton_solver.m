%implement root finder using the Newton Method
%INPUTS:
%fun: the mathematical function we want to solve
%x0: the initial guess
%max_iter: limit of max iterations
% dxtol: termination threshold (stop when interval abs(dx) < dxtol)
% ftol: termination threshold (stop when abs(f)<ftol
% terminate when abs(-dx) > dxmax, where dxmax is a very large number
%OUTPUTS:
%x: approximate root of function
%flag: 1 is success, 0 is failure
function [X,flag] = multidimentional_newton_solver(fun,X0,max_iter,ftol,dXtol,dX_max)
for i = 1:max_iter
    [f,dfdX] = fun(X0);

    if abs(f) < ftol
        fprintf('ftol\n');
        X = X0;
        flag = 1;
        return
    end

    dx = -f/dfdX;

    if abs(dX) > dX_max
        %dx = sign(dx)*dx_max;
        flag = 0; 
        X = X0;
        return
    end

    X1=X0+dx;

    if abs(dx) <= dXtol
        fprintf('dxtol\n');
        X = X1;
        flag = 1;
        return
    end

    X0 = X1;
    hold on
end
X = X0;
flag = 0;
fprintf('max_iter\n')
end