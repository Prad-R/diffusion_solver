function [grid_x, grid_y, node_x_mesh, node_y_mesh, node_x, node_y] = uniform_mesh(mesh, show_grid)
    % To create a uniform mesh
    
    line_step_x = mesh.L / mesh.N_x;
    line_step_y = mesh.H / mesh.N_y;

    grid_line_x = [0:line_step_x:mesh.L];
    grid_line_y = [0:line_step_y:mesh.H];
    node_x_interior = zeros(mesh.N_x, 1);
    node_y_interior = zeros(mesh.N_y, 1);

    for i = 1:mesh.N_x
        node_x_interior(i) = 0.5 * (grid_line_x(i) + grid_line_x(i+1));
    end

    for i = 1:mesh.N_y
        node_y_interior(i) = 0.5 * (grid_line_y(i) + grid_line_y(i+1));
    end

    node_x_boundary_left = 0;
    node_x_boundary_right = mesh.L;
    node_y_boundary_bottom = 0;
    node_y_boundary_top = mesh.H;

    node_x = [node_x_boundary_left', node_x_interior', node_x_boundary_right'];
    node_y = [node_y_boundary_bottom', node_y_interior', node_y_boundary_top'];

    [grid_x, grid_y] = meshgrid(grid_line_x, grid_line_y);
    [node_x_mesh, node_y_mesh] = meshgrid(node_x, node_y);

    corner_mask = ((node_x_mesh == 0 | node_x_mesh == mesh.L) & (node_y_mesh == 0 | node_y_mesh == mesh.H));
    
    % Mark corners as NaN (or Inf) so they’re easy to ignore later
    node_x_mesh(corner_mask) = NaN;
    node_y_mesh(corner_mask) = NaN;
    
    if show_grid
        figure(1);
        hold on;
        plot(grid_x, grid_y, 'k', grid_x', grid_y', 'k');
        scatter(node_x_mesh, node_y_mesh, MarkerFaceColor='red', MarkerEdgeColor='red');
        axis equal;
        title('Grid')
    end
end