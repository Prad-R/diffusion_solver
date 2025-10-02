function [residual_history, iterations, temperature_grid] = diffusion_solver(mesh, setup, temperature_grid, boundary_conditions, max_iterations, tol)
    % The solver for the steady-state diffusion problem 
    % Based on Gauss-Seidel iteration

    fprintf("...Starting solution for diffusion problem...\n")

    residual = 1e2; % To run at least once
    iterations = 0;
    
    residual_history = [];
    
    while (residual > tol)
    
        if (iterations >= max_iterations)
            fprintf("MAX iterations exceeded. Did not converge!");
            break;
        end
    
        residual = 0;
        temperature_grid = boundary_conditions(mesh, temperature_grid);
    
        for i = 2:mesh.N_x + 1
            for j = 2:mesh.N_y + 1
                [a_w, a_e, a_s, a_n, a_p] = find_coefs(i, j, mesh, setup);
                
                residual = max(residual, abs(temperature_grid(i, j) - (1 / a_p) * (a_w * temperature_grid(i - 1, j) ...
                                         +a_e * temperature_grid(i + 1, j) ...
                                         +a_s * temperature_grid(i, j - 1) ...
                                         +a_n * temperature_grid(i, j + 1) ...
                                         +setup.S_u)));
    
                temperature_grid(i, j) = (1 / a_p) * (a_w * temperature_grid(i - 1, j) ...
                                                     +a_e * temperature_grid(i + 1, j) ...
                                                     +a_s * temperature_grid(i, j - 1) ...
                                                     +a_n * temperature_grid(i, j + 1) ...
                                                     +setup.S_u);
            end
        end
    
        residual_history = [residual_history, residual];
        
        iterations = iterations + 1;
    end
    
    fprintf("...The simulation converged after %d iterations...\n", iterations);
end