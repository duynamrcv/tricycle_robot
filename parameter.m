clear;
close all;
clc;

global type d v_max a_max gamma_max phi_max
global k1 k2 k3
g = 6;      % group_id
type = 2;   % type of model

%% Robot parameters
d = sqrt(2.5+0.1*g);    % robot's wheelbase [m]
v_max = 1.5 + 0.03*g;   % velocity max [m/s]
a_max = 0.2 + 0.01*g;   % acceleation max [m/s2]
gamma_max = pi/4;       % steering angle max [rad]
phi_max = pi/3;         % steering angle rate max [rad/s2]

%% Control parameters
k1 = 0.5;
k2 = 0.5;
k3 = 0.5;