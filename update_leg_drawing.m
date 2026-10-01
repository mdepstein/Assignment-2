%Updates the plot objects that visualize the leg linkage
%for the current leg configuration
%INPUTS:
%complete_vertex_coords: a column vector containing the (x,y) coordinates of every vertex
%leg_drawing: a struct containing all the plotting objects for the linkage
%       leg_drawing.linkages is a cell array, where each element corresponds
%       to a plot of a single link (excluding the crank)
%       leg_drawing.crank is a plot of the crank link
%       leg_drawing.vertices is a cell array, where each element corresponds
%       to a plot of one of the vertices in the linkage
function update_leg_drawing(complete_vertex_coords, leg_drawing, leg_params)
    %iterate through each link, and update corresponding link plot
    %complete_vertex_coords = column_to_matrix(complete_vertex_coords)
    
    for linkage_index = 1:leg_params.num_linkages
        % vert = leg_params.link_to_vertex_list(linkage_index,:)
        %line_x and line_y should both be two element arrays containing
        %the x and y coordinates of the line segment describing the current link
        %linkage_index is the label of the current link

        % Get the verticies of the link
        vert1 = leg_params.link_to_vertex_list(linkage_index,1);
        vert2 = leg_params.link_to_vertex_list(linkage_index,2);
        % 
        % 
        % line_x = [complete_vertex_coords(vert1, 1), complete_vertex_coords(vert1,2)]
        % line_y = [complete_vertex_coords(vert2, 1), complete_vertex_coords(vert2,2)]
        % set(leg_drawing.linkages{linkage_index},'xdata',line_x(:,1),'ydata',line_y(:,2)); 
        
        %get the coordinates of the verticies
        line_x = [complete_vertex_coords(2*vert1 -1), complete_vertex_coords(2*vert2 -1)];
        line_y = [complete_vertex_coords(2*vert1   ), complete_vertex_coords(2*vert2   )];
        set(leg_drawing.linkages{linkage_index},'xdata',line_x,'ydata',line_y);
    end

    % xtip = zeros(leg_params.num_vertices,1);
    % ytip = zeros(leg_params.num_vertices,1);
    % i_tip=0;
    % xtip=[];
    % ytip=[];
    %iterate through each vertex, and update corresponding vertex plot
    for vertex_index = 1:leg_params.num_vertices

        %vertex_index is the label of the current vertex       

        %dot_x and dot_y should both be scalars
        %specifically the x and y coordinates of the corresponding vertex
        dot_x = complete_vertex_coords(2*vertex_index-1);
        dot_y = complete_vertex_coords(2*vertex_index);
        
        set(leg_drawing.vertices{vertex_index},'xdata',dot_x,'ydata',dot_y); 

        % if vertex_index == leg_params.num_vertices
        %     i_tip=i_tip+1
        %     xtip(i_tip) = dot_x;
        %     ytip(i_tip) = dot_y;
        %     fprintf('vertex=7')
        % end
        
    end
        %  xtip
        % ytip
    %your code here
    %crank_x and crank_y should both be two element arrays
    %containing the x and y coordinates of the line segment describing the crank
    


    crank_x =  [leg_params.vertex_pos0(1), complete_vertex_coords(1)];
    crank_y =  [leg_params.vertex_pos0(2), complete_vertex_coords(2)];
    
    set(leg_drawing.crank,'xdata',crank_x,'ydata',crank_y);
    
    
end