function rho_atm = calcAtmosphericDensity(r)
%{
This function calculates the atmospheric density using the exponential
atmospheric model 

www.mathworks.com/matlabcentral/discussions/uploaded_files/
11985/Special%20Perturbation%20Techniques.pdf

    Inputs: magnitude of position vector
    Output: atmospheric density
%}

    % Get constants
    constants = setConstants();

    % Extract Constants
    rho0 = constants.rho0; 
    r0 = constants.r0;
    H = constants.H;
    
    rho_atm = rho0*exp(-(r-r0)/H);

end