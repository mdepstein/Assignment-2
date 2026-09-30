%Computes the theta derivatives of each vertex coordinate for the Jansen linkage
%INPUTS:
%vertex_coords: a column vector containing the (x,y) coordinates of every vertex
%               these are assumed to be legal values that are roots of the error funcs!
%leg_params: a struct containing the parameters that describe the linkage
%theta: the current angle of the crank
%OUTPUTS:
%dVdtheta: a column vector containing the theta derivates of each vertex coord
function dVdtheta = compute_velocities(vertex_coords, leg_params, theta)
    % calc jacobian of linkage length error func
        error_vec_fun = @(x) link_length_error_func(x, leg_params);      
        J_length_error = approximate_jacobian(error_vec_fun, vertex_coords)
      
        for i = 1:length(vertex_coords)
        approximate_derivative(J_length_error(i), theta(i))
        end

        
end