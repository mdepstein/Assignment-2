function test_link_error()

    %initialize leg_params structure
    leg_params = define_leg_parameters();
    
    % link_length_error_func(vertex_coords_guess, leg_params)
    % fixed_coord_error_func(vertex_coords_guess, leg_params, 25)
    % initialize_leg_drawing(leg_params)
    %compute_coords(vertex_coords_guess, leg_params, 25)
    vertex_coords = [...
    [   0;   50];... %vertex 1 guess
    [ -50;    0];... %vertex 2 guess
    [ -50;   50];... %vertex 3 guess 
    [-100;    0];... %vertex 4 guess
    [-100;  -50];... %vertex 5 guess
    [ -50;  -50];... %vertex 6 guess
    [ -50; -100]...  %vertex 7 guess  
    ];

    theta_iter = 100;
    %theta_list = linspace(0, 2*pi, theta_iter);

    velocities = compute_velocities(vertex_coords, leg_params, 260);
    xtip_vel = zeros(length(velocities)/2, 1);
    ytip_vel = zeros(length(velocities)/2, 1);


    for vel_index = 1:length(velocities)
        if mod(vel_index, 2) == 0
            ytip_vel = velocities(vel_index);
        else
            xtip_vel = velocities(vel_index);
        end
    end
end