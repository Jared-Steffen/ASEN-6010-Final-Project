function [T_rot,N_H] = calcAngMomAndEnergy(X)

    % Extract constants
    constants = setConstants();
    B_IRW = constants.B_IRW;
    B_IWs = constants.B_IWs;
    Gs = constants.Gs;

    % Extract spacecraft states
    mrp_BN = X(7:9,:);
    B_omega_BN = X(10:12,:);
    
    % Number of time steps
    N = size(X,2);
    
    % Initialize
    N_H = zeros(3,N);
    T_rot = zeros(1,N);
    
    % Wheel speeds
    cap_omega = X(13:end,:);
    
    for k = 1:N
    
        % Current attitude
        BN = MRPtoDCM(mrp_BN(:,k));
    
        % Start with spacecraft bus angular momentum
        B_H = B_IRW * B_omega_BN(:,k);
    
        % Start with spacecraft bus kinetic energy
        T = 0.5 * B_omega_BN(:,k)' ...
            * B_IRW ...
            * B_omega_BN(:,k);
    
        % Body rate projected onto each wheel spin axis
        omega_s = Gs' * B_omega_BN(:,k);
    
        % Add each RW
        for i = 1:4
    
            IWs = B_IWs(i);
    
            % Absolute wheel spin rate
            omega_wheel = omega_s(i) + cap_omega(i,k);
    
            % Wheel angular momentum
            B_H = B_H + Gs(:,i) * IWs * omega_wheel;
    
            % Wheel rotational kinetic energy
            T = T + 0.5 * IWs * omega_wheel^2;
    
        end
    
        % Transform total angular momentum to inertial frame
        N_H(:,k) = BN' * B_H;
    
        % Store energy
        T_rot(k) = T;

end