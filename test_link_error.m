function test_link_error()

    %initialize leg_params structure
    leg_params = define_leg_parameters();
    
    % link_length_error_func(vertex_coords_guess, leg_params)
    % fixed_coord_error_func(vertex_coords_guess, leg_params, 25)
    % initialize_leg_drawing(leg_params)
    compute_coords(vertex_coords_guess, leg_params, 25)
end