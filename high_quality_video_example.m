%Short example demonstrating how to create a MATLAB animation
%In this case, a square moving along an elliptical path
%This version also store the animation in a vide.
function high_quality_video_example()
    %define location and filename where video will be stored
    %written a bit weird to make it fit when viewed in assignment
    %you will need to change the path and file name for your own purposes
    mypath1 = 'C:\Users\ssperou\OneDrive - Olin College of Engineering\Documents\GitHub\Assignment-2\.git';
    fname='strandbeest_vid_noleg.avi';
    input_fname = [mypath1,fname];
    
    %create a videowriter, which will write frames to the animation file
    writerObj = VideoWriter(input_fname);
    
    %must call open before writing any frames
    open(writerObj);
    
    
    %initialize the current figure and save as object
    fig1 = figure(1);

    %this is the critical line that forces the video to be high quality
    %adjust the numbers to adjust the position/size of the plotting window
    set(fig1,'units','pixels','position',[0 0 1440 1080]);
    
    %set up the plotting axis
    leg_params = define_leg_parameters();
    
    leg_drawing = initialize_leg_drawing(leg_params);
    hold on; axis equal; axis square
    axis([-150 70 -120 50])

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

     for j = 1:2
        for i =1:length(theta_list)
            coord_roots = compute_coords(vertex_coords_guess, leg_params, theta_list(i));
            update_leg_drawing(coord_roots, leg_drawing, leg_params);

            xtip(end+1) = coord_roots(13);
            ytip(end+1) = coord_roots(14);

        %this code will likely involve a loop, where you call
        %compute_coords at each iteration
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
        set(leg_drawing.tip,'xdata',xtip,'ydata',ytip); 

        hold on;
        drawnow;
        %capture a frame (what is currently plotted)
        current_frame = getframe(fig1);

        %write the frame to the video
        writeVideo(writerObj,current_frame);
        pause(0.05);
        end


    end
    close(writerObj);

end