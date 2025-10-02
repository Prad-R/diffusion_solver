function out = bottom_face(x)
    % To define the boundary condition on the bottom face
    arguments
        x {mustBeVector} = ones(1, 5);
    end
    out = 15 * ones(size(x));
end