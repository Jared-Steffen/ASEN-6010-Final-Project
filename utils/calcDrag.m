function [B_tau_D, N_a_D] = calcDrag(N_r, N_v, mrp_BN)
%{
This function calculated the torque applied to the spacecraft due to drag
and the acceleration due to drag
    Inputs: inertial position and velocity vectors, attitude coordinates of
    MRPs
    Outputs: torque due to drag in the body frame, inertial acceleration
    due to drag
%}

    % Set constants
    constants = setConstants();

    % Extract constants
    A = constants.A;
    m = constants.m;
    CD = constants.CD;
    wE = constants.wE;
    B_r_Cp = constants.B_r_Cp;

    % Get relative velocity vector
    N_v_atm = cross([0;0;wE],N_r);
    N_v_rel = N_v - N_v_atm;

    % Calculate the atmospheric density
    rho_atm = calcAtmosphericDensity(norm(N_r));

    % Calculate acceleration due to drag
    N_a_D = -0.5 * rho_atm * CD * A / m * norm(N_v_rel) * N_v_rel;
    N_FD = N_a_D*m*1000;

    % Transform relative velocity to the body frame and calculate drag torque
    BN = MRPtoDCM(mrp_BN);
    B_FD = BN*N_FD;
    B_tau_D = cross(MRPtoDCM(mrp_BN) * B_r_Cp, B_FD);

end