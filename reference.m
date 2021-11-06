function y = reference( u )
%REFERENCE
t = u;
if t < 20
    xr = -20 + t;
    yr = 4;
    qr = 0;
elseif t < 30
    xr = 4*sin(2*pi/20*(t-20));
    yr = 4*cos(2*pi/20*(t-20));
    qr = -2*pi/20*(t-20);
else
    xr = 30-t;
    yr = -4;
    qr = -pi;
end
y = [xr; yr; qr];
end

