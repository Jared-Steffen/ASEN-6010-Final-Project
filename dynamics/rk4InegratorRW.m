function [t,X] = rk4InegratorRW(X0, tspan, dt, odefun)

    % Get the time vector
    t0 = tspan(1);
    tf = tspan(2);
    t = t0:dt:tf;
    
    % Setup
    n = length(X0);
    X = zeros(n,length(t));
    X(:,1) = X0;
    
    % Iterate over the time steps
    us = zeros(4,1);
    for k = 1:length(t)-1
        hk = t(k+1) - t(k);
        tk = t(k);
        Xk = X(:,k);
    
        % RK4
        k1 = odefun(tk, Xk, us);
        k2 = odefun(tk+hk/2, Xk+k1*hk/2, us);
        k3 = odefun(tk+hk/2, Xk+k2*hk/2, us);
        k4 = odefun(tk+hk, Xk+k3*hk, us);
    
        Xkp1 = Xk + (hk/6)*(k1 + 2*k2 + 2*k3 + k4);
    
        % MRP Switching
        if norm(Xkp1(7:9)) >= 1
            X(7:9,k+1) = -Xkp1(7:9)./norm(Xkp1(7:9))^2;
        else
            X(7:9,k+1) = Xkp1(7:9);
        end
        X(1:6,k+1) = Xkp1(1:6);
        X(10:end,k+1) = Xkp1(10:end);
    
    end

end