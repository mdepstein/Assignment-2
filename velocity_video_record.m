%Short example demonstrating how to create a MATLAB animation
%In this case, a square moving along an elliptical path
%This version also store the animation in a video.
function velocity_video_record()
    %define location and filename where video will be stored
    %written a bit weird to make it fit when viewed in assignment
    %you will need to change the path and file name for your own purposes
    mypath1 = 'C:\Users\mepstein\OneDrive - Olin College of Engineering\Desktop\Applied Math\Assignment-2\.git';
    fname='strandbeest_vid_vel.avi';
    input_fname = [mypath1,fname];
    
    %create a videowriter, which will write frames to the animation file
    writerObj = VideoWriter(input_fname);
    
    %must call open before writing any frames
    open(writerObj);
    
    
    %initialize the current figure and save as object
    fig1 = figure(1);
    
    %this is the critical line that forces the video to be high quality
    %adjust the numbers to adjust the position/size of the plotting window
    set(fig1,'units','pixels','position',[0 0 1440 1440]);
    
    %set up the plotting axis
    leg_params = define_leg_parameters();
    
    leg_drawing = initialize_leg_drawing(leg_params);
    hold on; 
    axis equal; 
    axis square
    axis([-150 80 -150 80])
    title('Strandbeest Linkage with Velocity Vector', 'Interpreter', 'latex', FontSize=20)
    
    % %initialize the plot of the square
    % square_plot = plot(0,0,'k');
    
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
    
                
                h3 = quiver(vxtip_plot_coords(1), vytip_plot_coords(1), ...
                    h*vxtip_plot_coords(2)/norm_v, h*vytip_plot_coords(2)/norm_v, 'g');
                
                set(leg_drawing.tip,'xdata',xtip,'ydata',ytip); 
           
                drawnow
                hold off
                pause(0.05);
    
                delete(h3)
                legend('', '','','','','','','','','','', 'Leg Tip Path','','', ...
                    '','','','','', 'Velocity Vector')
    
            end
            
    
            axis equal
            axis([-150 80 -150 80])
    
            
        end
    
    
    close(writerObj);

end