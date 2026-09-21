%the function name and input/output variable names
%are just what I chose, you can use whatever names you'd like
%This function should take in a column vector X as input, and should return both f(X) and J(X) as output:
function [f_val,J] = test_function01(X)
    f_val = [X(1).^2+X(2).^2-6-X(3).^5; ...
           X(1).*X(3)+X(2)-12; ...
           sin(X(1)+X(2)+X(3))];
    J = jacobian(f_val, X);
end