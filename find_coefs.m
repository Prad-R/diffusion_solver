function [a_w, a_e, a_s, a_n, a_p] = find_coefs(x_index, y_index, mesh, setup)
    % To compute the coefficients of the neighbour of each cell

    k = setup.k_vector(y_index);

    if (x_index == 2)
        a_w = 2 * k * mesh.A_w / mesh.dx;
        a_e = k * mesh.A_e / mesh.dx;
    elseif (x_index == mesh.N_x + 1)
        a_w = k * mesh.A_w / mesh.dx;
        a_e = 2 * k * mesh.A_e / mesh.dx;
    else
        a_w = k * mesh.A_w / mesh.dx;
        a_e = k * mesh.A_e / mesh.dx;
    end

    if (y_index == 2)
        a_s = 2 * k * mesh.A_s / mesh.dy;
        a_n= k * mesh.A_n / mesh.dy;
    elseif (y_index == mesh.N_y + 1)
        a_s = k * mesh.A_s / mesh.dy;
        a_n = 2 * k * mesh.A_n / mesh.dy;
    else
        a_s = k * mesh.A_s / mesh.dy;
        a_n = k * mesh.A_n / mesh.dy;
    end

    a_p = a_w + a_e + a_s + a_n - setup.S_p;
end