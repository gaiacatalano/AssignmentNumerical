function hess = chained_rosenbrock_hess(x)

    n = length(x);

    d0 = zeros(n,1);
    dm1 = zeros(n,1);

    for i = 1:n

        if i ~= 1
            d0(i) = d0(i) + 200;
            dm1(i) = -400*x(i-1);
        end

        if i ~= n
            d0(i) = d0(i) + 400*(3*x(i)^2 - x(i+1)) + 2;
        end

        % xim1 = x(i-1);
        % xi = x(i);
        % 
        % d2f_dxim12 = 400*(3*xim1^2 - xi) + 2;
        % d2f_dxim1xi = -400*xim1;
        % d2f_dxi2 = 200;

        % d0(i-1) = d0(i-1) + d2f_dxim12;
        % d0(i)   = d0(i)   + d2f_dxi2;
        % dp1(i) = d2f_dxim1xi;
        % dm1(i-1) = d2f_dxim1xi;
        

    end

    hess = spdiags([dm1, d0, [0; dm1(1:end-1)]], [-1 0 1], n, n);
    hess = 0.5*(hess + hess');
end