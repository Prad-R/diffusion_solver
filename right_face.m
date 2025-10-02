function out = right_face(y, H)
    % To define the boundary condition on the right face
    arguments
        y {mustBeVector} = ones(5, 1);
        H (1,1) {mustBeFloat} = 0.5;
    end

    out = 5 * (1 - y ./ H) + 15 * sin(pi * y ./ H);
end