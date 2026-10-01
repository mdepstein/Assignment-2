%runs strandbeest simulation
function strandbeest_simulation()

    leg_params = define_leg_parameters();
    
    leg_drawing = initialize_leg_drawing(leg_params);
    
    axis equal
    axis([-150 70 -120 50])
    %column vector of initial guesses
    %for each vertex location.
    %in form: [x1;y1;x2;y2;...;xn;yn]
    vertex_coords_guess = [...
    [   0;   50];... %vertex 1 guess
    [ -50;    0];... %vertex 2 guess
    [ -50;   50];... %vertex 3 guess 
    [-100;    0];... %vertex 4 guess
    [-100;  -50];... %vertex 5 guess
    [ -50;  -50];... %vertex 6 guess
    [ -50; -100]...  %vertex 7 guess  
    ];   
    

    theta_iter = 100;
    theta_list = linspace(0, 2*pi, theta_iter);
    %your code here
    xtip = [];
    ytip = [];

    for j = 1:5
        for i =1:length(theta_list)
            coord_roots = compute_coords(vertex_coords_guess, leg_params, theta_list(i));
            update_leg_drawing(coord_roots, leg_drawing, leg_params);
    
            xtip(end+1) = coord_roots(13);
            ytip(end+1) = coord_roots(14);

            coord_vels = compute_velocities(coord_roots, leg_params, theta_list(i));
            norm_factor = norm(coord_vels);
            xtip_vel(i) = coord_vels(13);
            ytip_vel(i) = coord_vels(14);
            %this code will likely involve a loop, where you call
            %compute_coords at each iteration
            vertex_coords_guess = coord_roots;
            
            %you likely will also need to call update_leg_drawing each iteration
            % drawnow updates the diagram as the loop keeps going instead of
            % waiting on the loop to end

            
            vxtip_plot_coords = [xtip(i),xtip_vel(i)+xtip_vel];
            vytip_plot_coords = [ytip(i),ytip_vel(i)+ytip_vel];
            norm_v = norm(vytip_plot_coords);
            h=200;
            
            q = quiver(vxtip_plot_coords(1), vytip_plot_coords(1), h*vxtip_plot_coords(2)/norm_v, h*vytip_plot_coords(2)/norm_v)
            
            % set(leg_drawing.tip,'xdata',vxtip_plot_coords,'ydata',vytip_plot_coords); 
            % set(leg_drawing.tip,'xdata',xtip,'ydata',ytip); 

            % vx_tip_prev = vxtip_plot_coords(1,1)
            % vy_tip_prev = vytip_plot_coords(1,1)

            % if i == 1
            %     q = quiver(vxtip_plot_coords(1,1), vytip_plot_coords(1,1), vxtip_plot_coords(1,1), vytip_plot_coords(1,1));
            % else
            %     q = quiver(vx_tip_prev, vy_tip_prev, q*vxtip_plot_coords(1, 1), -q*vytip_plot_coords(1, 1));
            % end


            set(leg_drawing.tip,'xdata',xtip,'ydata',ytip); 
       
            drawnow
            hold off
            pause(0.05);

            delete(q)

        end
        
        % ploty= linspace(0, 2*pi, length(xtip_vel));
        % plot(ploty, ytip_vel);
        axis equal
        axis([-150 70 -120 50])
    end
    
end