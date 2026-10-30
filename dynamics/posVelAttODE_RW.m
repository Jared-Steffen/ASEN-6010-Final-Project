function Xdot = posVelAttODE_RW(~,X,us)
%{
This function is used within a numerical integrator to integrate the 6DOF
EOMs. Translational motion includes drag and J2 effects.
    Inputs: state vector X, control torque vector us
%}
    % Set constants
    constants = setConstants();

    % Extract position and velocity
    N_r = X(1:3);
    N_v = X(4:6);

    % Extract MRPs and get norm
    mrp_BN = X(7:9);
    mrp_norm = norm(mrp_BN);

    % Extract body rates
    B_omega_BN = X(10:12);

    % Extract RW states
    n_rw = length(X(13:end));
    cap_omega = X(13:end);
    
    %% Translational

    % Extract constants for translational equations
    mu = constants.mu;
    J2 = constants.J2;
    RE = constants.RE;

    % Calculate drag terms
    [B_tau_D, N_a_D] = calcDrag(N_r, N_v, mrp_BN);

    % 2-body acceleration
    r = norm(N_r);
    N_a_mu = -mu/r^3*N_r;

    % J2 Acceleration
    x = N_r(1); y = N_r(2); z = N_r(3);
    J2_term = 1.5*J2*mu*RE^2/r^5;
    N_a_J2 = J2_term*[x*(5*z^2/r^2-1); y*(5*z^2/r^2-1); z*(5*z^2/r^2-3)];

    % Total acceleration
    N_a = N_a_mu + N_a_J2 + N_a_D;

    % Assemble state derivative
    Xdot_trans = [N_v; N_a];

    %% Rotational

    % Extract constants for rotational equations
    Gs = constants.Gs;
    B_IRW = constants.B_IRW;
    B_IWs = constants.B_IWs;
    
    % Put body rates in G frame
    omega_s = Gs'*B_omega_BN;
    
    % Initialize mass matrix and function vector for solving ODEs
    M = zeros(n_rw+6,n_rw+6);
    f = zeros(n_rw+6,1);
    
    % Populate mass matrix
    M(1:3,1:3) = eye(3);
    
    M(4:6,4:6) = B_IRW;
    M(4:6,7:end) = Gs.*B_IWs';
    
    M(7:end,4:6) = B_IWs.*Gs';
    M(7:end,7:end) = diag(B_IWs);
    
    % Populate the f vector
    mrp_Bmat = (1-mrp_norm^2)*eye(3) + 2*skewSym(mrp_BN) + 2*(mrp_BN*mrp_BN');
    f(1:3) = 1/4 * mrp_Bmat * B_omega_BN;
    
    hs = B_IWs.*(omega_s+cap_omega);
    f(4:6) = -skewSym(B_omega_BN)*(B_IRW*B_omega_BN + Gs*hs) + B_tau_D;
    
    f(7:end) = us;
    
    % Solve ODEs w/ inversion
    Xdot_att = M\f;

    %% Full State
    Xdot = [Xdot_trans;Xdot_att];
end