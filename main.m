clear all;
close all;
clc;

resolutions = [10, 20, 50, 100, 200, 500];
% resolutions = [100];

for r = 1:size(resolutions, 2)
    resolution = resolutions(r);
    fprintf("\n...Resolution is %dx%d...\n", resolution, resolution);

    %%% Generating the Mesh
    
    mesh.N_x = resolutions(r);
    mesh.N_y = resolutions(r);
    mesh.L = 1;
    mesh.H = 0.5;
    
    [mesh.grid_x, mesh.grid_y, mesh.node_x_mesh, mesh.node_y_mesh, mesh.node_x, mesh.node_y] = uniform_mesh(mesh, false);
    
    %%% Defining the boundary condition functions
    
    temperature_grid = zeros(mesh.N_x + 2, mesh.N_y + 2);
    
    temperature_grid = boundary_conditions(mesh, temperature_grid);
    
    %%% Setting up the solver
    
    mesh.dx = mesh.L / mesh.N_x;
    mesh.dy = mesh.H / mesh.N_y;
    mesh.A_e = mesh.dy;
    mesh.A_w = mesh.dy;
    mesh.A_n = mesh.dx;
    mesh.A_s = mesh.dx;
    setup.k_vector = find_k(mesh.node_y, mesh.H);
    setup.S_u = 500000 * mesh.dx * mesh.dy;
    setup.S_p = -30000 * mesh.dx * mesh.dy;
    % setup.S_u = 0 * dx * dy;
    % setup.S_p = 0 * dx * dy;
    
    %%% Solving
    
    max_iterations = 5000;
    tol = 1e-6;
    [residual_history, iterations, temperature_grid] = diffusion_solver(mesh, setup, temperature_grid, @boundary_conditions, max_iterations, tol);
    
    filename = "Data/residuals_" + mesh.N_x + "x" + mesh.N_y + ".mat";
    save(filename, 'residual_history');
    fprintf("...Saved residuals...\n");
    filename = "Data/temperature_distribution_" + mesh.N_x + "x" + mesh.N_y + ".mat";
    save(filename, 'temperature_grid');
    fprintf("...Saved temperature grid...\n");

    %%% Plots
    % Residual plot
    fig1 = figure('Visible', 'off');
    semilogy(1:iterations, residual_history, '-o');
    xlabel('Iteration');
    ylabel('Residual');
    title('Convergence History');
    filename = "Plots/residuals_" + mesh.N_x + "x" + mesh.N_y + ".svg";
    saveas(fig1, filename);
    close(fig1);  % Close the figure to free memory
    
    % Temperature distribution
    fig2 = figure('Visible', 'off');
    imagesc(mesh.node_x, mesh.node_y, temperature_grid); 
    colormap('hot')
    set(gca, 'YDir', 'normal');
    colorbar;
    axis equal tight;
    grid on;
    title('Temperature Distribution');
    xlabel('x');
    ylabel('y');
    filename = "Plots/temperature_distribution_" + mesh.N_x + "x" + mesh.N_y + ".svg";
    saveas(fig2, filename);
    close(fig2);
end