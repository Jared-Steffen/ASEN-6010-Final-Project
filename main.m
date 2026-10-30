clc; clear; close all

% Add all folder paths
addpath("utils\")
addpath("dynamics\")
addpath("plotting\")

%% Simulation Setup

% Define initial orbital elements (Starlink-38435)
% 1 A1004U 26232A   26300.30430853 -.00706341  00000-0 -48323-2 0  9992
% 2 A1004  70.0005  62.5808 0004698 273.1810  86.8852 15.76391864  2286
a = 6703; % km
e = 0.0004698; 
raan = 62.5808;
argp = 263.1810;
inc = 70.0005;
nu = 86;

% Define initial conditions
[r0, v0] = oe2rv(a,e,inc,raan,argp,nu);
mrp0 = [0; 0; 0]; % MRPs
omega0 = [0.02;0.01;0.1]; % rad/s (body rates)
Omega0 = zeros(4,1); % rad/s (wheel speeds)
X0 = [r0; v0; mrp0; omega0; Omega0];

% Define simulation time
tspan = [0, 6000];
dt = 0.1;

%% Test 6-DOF Simulation

% Numerically integrate
odefun = @(t,X,us) posVelAttODE_RW(t,X,us);
[t, X] = rk4InegratorRW(X0,tspan,dt,odefun);

% Check angular momentum and energy
[T_rot,N_H] = calcAngMomAndEnergy(X);
plotAngMomAndEnergy(t,N_H,T_rot)

% Check attitude states
plotAttitudeStates(t,X(7:9,:),X(10:12,:))

% Check wheel states
plotRWStates(t,X(13:end,:))

%% Test WMM Implementation

%% Test Control Law

%% Test Momentum Management

%% Full Mission Simulation