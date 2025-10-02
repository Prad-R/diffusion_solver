function out = top_face(x)
    % To define the boundary condition on the top face
    arguments
        x {mustBeVector} = ones(1, 5);
    end
    out = 10 * ones(size(x));
end