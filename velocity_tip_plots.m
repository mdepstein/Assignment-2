%runs strandbeest simulation
function velocity_tip_plots()

    leg_params = define_leg_parameters();
    
    
    
   
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
    
    %linear alg method velocities
    xtip_vel = [];
    ytip_vel = [];

    % finite diff method velocities
    xtip_vel_fdiff = [];
    ytip_vel_fdiff = [];
    

    %for j = 1:2
        for i =1:length(theta_list)
            theta = theta_list(i);

            %current linkage config
            coord_roots = compute_coords(vertex_coords_guess, leg_params, theta);
           

            % finite diff method
            coord_fdiff = @(theta) compute_coords(vertex_coords_guess, leg_params, theta);
            numdiff_vels = approximate_jacobian(coord_fdiff, theta);
           
            xtip_vel_fdiff(i) = numdiff_vels(13);
            ytip_vel_fdiff(i) = numdiff_vels(14);
            %update_leg_drawing(coord_roots, leg_drawing, leg_params);
    
            % lin alg method
            coord_vels = compute_velocities(vertex_coords_guess, leg_params, theta_list(i));
            xtip_vel(i) = coord_vels(13);
            ytip_vel(i) = coord_vels(14);
            %this code will likely involve a loop, where you call
            %compute_coords at each iteration

            %update guess
            vertex_coords_guess = coord_roots;
            
            %you likely will also need to call update_leg_drawing each iteration
            % drawnow updates the diagram as the loop keeps going instead of
            % waiting on the loop to end
            % q = 50;
            % vxtip = 1;
            % vytip = 1;
            % vxtip_plot_coords = [xtip(i),xtip(i)+q*vxtip];
            % vytip_plot_coords = [ytip(i),ytip(i)+q*vytip];
            % set(leg_drawing.tip,'xdata',vxtip_plot_coords,'ydata',vytip_plot_coords); 
            % set(leg_drawing.tip,'xdata',xtip,'ydata',ytip); 
            % 
            % hold on;
            % drawnow;
            % pause(0.05);
        end
        
        xaxis_range= linspace(0, 2*pi, length(xtip_vel));
        % plot(xaxis_range, xtip_vel);


        % plot velocity of x component of tip for both methods
        figure(1);
        
        plot(xaxis_range, xtip_vel, 'b-', 'MarkerFaceColor', 'b', 'Linewidth', 1.5,'Displayname',"Linear Algebra");
        hold on;
        plot(xaxis_range, xtip_vel_fdiff, 'r--', 'MarkerFaceColor', 'r', 'Linewidth', 1.5,'Displayname',"Finite Difference");
       
        title('Strandbeest Leg Tip Velocity - X component', 'Interpreter', 'Latex', 'FontSize',18);
        legend('Location','northwest', 'Interpreter', 'Latex','FontSize',12)
        xlabel("Theta (rad)", 'Interpreter', 'Latex','FontSize',16)
        ylabel("Velocity, X Component ()", 'Interpreter', 'Latex','FontSize',16)
        set(gca,'TickLabelInterpreter','latex')
        hold off;
        

        % plot velocity of y component of tip for both methods
        figure(2)
        plot(xaxis_range, ytip_vel, 'b-', 'MarkerFaceColor', 'b', 'Linewidth', 1.5,'Displayname',"Linear Algebra");
        hold on;
        plot(xaxis_range, ytip_vel_fdiff, 'r--', 'MarkerFaceColor', 'r', 'Linewidth', 1.5,'Displayname',"Finite Difference");
       
        title('Strandbeest Leg Tip Velocity - Y component', 'Interpreter', 'Latex', 'FontSize',18);
        legend('Location','northwest', 'Interpreter', 'Latex','FontSize',12)
        xlabel("Theta (rad)", 'Interpreter', 'Latex', 'FontSize',16)
        ylabel("Velocity, Y Component ()", 'Interpreter', 'Latex','FontSize',16)
        set(gca,'TickLabelInterpreter','latex')
        hold off;
    end
    
%end