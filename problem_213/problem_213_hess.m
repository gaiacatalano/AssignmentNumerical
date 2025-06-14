function hess = problem_213_hess(x)
    
    n = length(x);
    h = 1/(n+1);

    x_first = 0;
    x_last = 1;
    x = [x_first; x; x_last];   

    d0 = zeros(n,1);
    dp1 = zeros(n,1);
    dp2 = zeros(n,1);
    dm1 = zeros(n,1);
    dm2 = zeros(n,1);

    % for k=1:n
    % 
    %     xkm1 = x(k);
    %     xk = x(k+1);
    %     xkp1 = x(k+2);
    % 
    %     fk = 2*xk + (h^2)*(xk + sin(xk))-xkm1-xkp1;
    % 
    %     df_dxkm1 = -1;
    %     df_dxk   = 2 + h^2 * (1+cos(xk));
    %     df_dxkp1 = -1;
    % 
    %     d2f_dxdk2 = -h^2 * sin(xk);
    % 
    %     d0(k) = df_dxk^2 + fk*d2f_dxdk2;
    % 
    %     if k > 1
    %         d0(k) = d0(k) + df_dxkp1^2;
    %     end
    % 
    %     if k < n
    %         d0(k) = d0(k) + df_dxkm1^2;
    %     end
    % 
    %     if k < n
    %         dm1(k) = dm1(k) + df_dxk*df_dxkp1 + df_dxkm1*df_dxk;  % riguarda
    %         dp1(k+1) = dp1(k+1) + df_dxk*df_dxkp1 + df_dxkm1*df_dxk;
    %     end
    %     if k < n-1
    %         dm2(k) = dm2(k) + df_dxkp1^2;
    %         dp2(k+2) = dp2(k+2) + df_dxkp1^2;
    %     end
    % 
    % end

    for i = 1:n
        % xkm1 = x(i);
        % xk = x(i+1);
        % xkp1 = x(k+2);
        fk = 2*x(i+1) + (h^2)*(x(i+1) + sin(x(i+1)))-x(i)-x(i+2);
        d0(i) = (2 + (1 + cos(x(i+1))*h^2))^2 - sin(x(i+1))*h^2*fk;
    
        if i ~= 1
            d0(i) = d0(i) + 1;
        end
            
        if i ~= n
            d0(i) = d0(i) + 1;
            dm1(i) = - 4 - (2 + cos(x(i+1)) + cos(x(i+2)))*h^2;
        end
    
        if i < n-1
            dm2(i) = 1;
        end
        
    end

    hess = spdiags([dm2 dm1 d0 [0; dp1(1:end-1)] [0; 0; dp2(1:end-2)]], [-2 -1 0 1 2], n, n);
    hess = 0.5 * (hess + hess');
    
end