function y = open_control( u )
%OPEN_CONTROL
global d
v = hypot(u(1), u(2));
gamma = atan2(d*u(3), v);
y = [v; gamma];

end

