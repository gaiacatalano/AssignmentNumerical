function hess = discrete_boundary_value_hess(x)
    
    n = length(x);
    h = 1/(n+1);

    x_first = 0;
    x_last = 0;
    x = [x_first; x; x_last];    

    d0 = zeros(n,1);
    dp1 = zeros(n,1);
    dp2 = zeros(n,1);

    for k=1:n

        xkm1 = x(k);
        xk = x(k+1);
        xkp1 = x(k+2);

        fk = (2*xk-xkm1-xkp1 + (h^2 * (xk + k*h + 1)^3)/2)^2;

        df_dxkm1 = -1;
        df_dxk   = 2 + 3/2 * h^2 * (xk + k*h + 1)^2;
        df_dxkp1 = -1;

        d2f_dxdk2 = 3*h^2 * (xk + k*h + 1);

        if k > 1
            d0(k) = d0(k) + df_dxkp1^2;
        end
        d0(k) = d0(k) + 2*df_dxk^2 + 2*fk*d2f_dxdk2;
        if k < n
            d0(k) = d0(k) + df_dxkm1^2;
        end
        
        if k < n
            dp1(k) = dp1(k) + 2*(df_dxk*df_dxkp1 + df_dxkm1*df_dxk);
        end
        if k < n-1
            dp2(k) = dp2(k) + 2*df_dxkp1^2;
        end

    end

    hess = spdiags([dp2 dp1 d0 dp1 dp2], [-2 -1 0 1 2], n, n);
    hess = 0.5 * (hess + hess');

end