function y = tricycle_model( u )
%TRICYCLE_MODEL
pos = u(1:3);   % pos = [x; y; theta]
v = u(4);       % longitudinal velocity
gamma = u(5);   % steering angle
noi = u(6);     % noise
gamma = gamma + noi;
theta = pos(3);
global type d

if type == 1
    x_dot = v*cos(gamma)*cos(theta);
    y_dot = v*cos(gamma)*sin(theta);
    theta_dot = v/d*sin(gamma);
else
    x_dot = v*cos(theta);
    y_dot = v*sin(theta);
    theta_dot = v/d*tan(gamma);
end
y = [x_dot; y_dot; theta_dot];
end

