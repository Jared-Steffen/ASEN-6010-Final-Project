function [R313] = rotationMatrix313(raan, inc, argp)
%{
This function is used to determine the euler 
3-1-3 rotation matrix given a set of inputted euler angles (in degrees)
  Inputs = Orbit geometry angles of RAAN, inclination, argument of
  periapsis
  Output = Euler 3-1-3 Rotation Matrix %}
%}
    
    % Create rotation matrix from periforcal frame to inerital
    R313 = [cosd(argp).*cosd(raan) - sind(argp).*sind(raan).*cosd(inc), ...
            -sind(argp).*cosd(raan) - cosd(argp).*sind(raan).*cosd(inc),...
            sind(inc).*sind(raan);
            cosd(argp).*sind(raan) + sind(argp).*cosd(inc).*cosd(raan),...
            -sind(argp).*sind(raan) + cosd(argp).* cosd(inc).*cosd(raan),...
            -sind(inc).*cosd(raan);
            sind(argp).*sind(inc),...
            cosd(argp).*sind(inc),...
            cosd(inc)];
    
end

