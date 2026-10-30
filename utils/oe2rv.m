function [N_r,N_v] = oe2rv(a,e,inc,raan,argp,nu)
%{
This function is used to determine the position and velocity vectors for a
given set of classical orbital elements (angles in degrees)
  Inputs = classical orbital elements, gravitational parameter
  Output = position and velocity vectors in inertial frame
%}

    % Set constants
    constants = setConstants();
    mu = constants.mu;
    
    % Form the 313 rotation matrix
    NP = rotationMatrix313(raan,inc,argp);
    
    % Get the semi-latus rectum
    p = a*(1-e^2);
    
    % Position and velocity scalars
    r = p/(1+e*cosd(nu));
    v = sqrt(mu/p);
    
    % Get the perifocal frame vectors
    P_r = r * [cosd(nu); sind(nu); 0];
    P_v = v * [-sind(nu); e + cosd(nu); 0];
    
    % Rotate into ECI
    N_r = NP*P_r;
    N_v = NP*P_v;

end