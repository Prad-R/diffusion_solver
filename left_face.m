function out = left_face(x)
    % To define the boundary condition on the left face
    arguments
        x {mustBeVector} = ones(5, 1);
    end
    out = x;
    % out = 20 * ones(size(x)); % Alternate Dirichlet condition
end