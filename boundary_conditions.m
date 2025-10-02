function temperature_grid = boundary_conditions(mesh, temperature_grid)
    % To return a temperature grid with the appropriate boundary conditions

    temperature_grid(1,:) = bottom_face(mesh.node_x);
    temperature_grid(:,mesh.N_x + 2) = right_face(mesh.node_y);
    temperature_grid(mesh.N_y + 2,:) = top_face(mesh.node_x);
    temperature_grid(:,1) = left_face(temperature_grid(:,2)); % Neumann BC, so have to consider adjacent cells
    % temperature_grid(:,1) = left_face(temperature_grid(:,2)); % Alternate Dirichlet BC
    
    % Marking corners as NaN
    temperature_grid(1,1) = NaN;
    temperature_grid(1,mesh.N_x + 2) = NaN;
    temperature_grid(mesh.N_y + 2,1) = NaN;
    temperature_grid(mesh.N_y + 2,mesh.N_x + 2) = NaN;
end