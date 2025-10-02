function out = find_k(y, H)
    % To compute the coefficient of conductivity
    arguments
        y {mustBeVector} = ones(5, 1);
        H (1,1) {mustBeFloat} = 0.5;
    end

    out = 16 * (y ./ H + 1);
end