function constants = setConstants()
%{
This function sets ALL constants used within this project. If a function
needs a constant from this list, it must be called within that function.
%}

    % Define Earth Gravity Model
    constants.mu = 3.986004415e5; % km^3/s^2
    constants.J2 = 1.0826269e-3;
    constants.RE = 6378.1363; % km
    constants.wE = 7.2921158553e-5; % rad/s
    
    % Define Atmospheric Drag Model
    constants.rho0 = 2.418e-2; % kg/km^3
    constants.r0 = 300.0 + constants.RE; % km
    constants.H = 53.628; % km
    
    % Define Satellite Properties
    constants.A = 3e-6; % km^2 - cross sectional area
    constants.m = 1000;  % kg - mass
    constants.CD = 2.0; % coefficient of drag
    constants.B_r_Cp = [1;1;1]; % m - center of pressure
    constants.B_IRW = diag([86,85,113]); % kg*m^2 - inertia w/ RW C.O.M
    constants.B_IWs = 0.1*ones(4,1); % kg*m^2 - inertial of RW spin axes
    gs1 = [1, 0, 0]';
    gs2 = [0, 1, 0]';
    gs3 = [0, 0, 1]';
    gs4 = [1, 1, 1]'./sqrt(3);
    constants.Gs = [gs1, gs2, gs3, gs4]; 

return