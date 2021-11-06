function y = control_signal( u )
%CONTROL_SIGNAL
pe = u(1:3);
vr = u(4:5);
pr = u(6:8);

global k1 k2 k3 d

v = vr(1)*cos(pe(3)) + k1*pe(1);
w = pr(3) + vr(1)*(k2*pe(2) + k3*sin(pe(3)));
gamma = atan2(w*d, v);
y = [v;gamma];
end

