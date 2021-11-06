function y = measure( u )
%MEASURE
pos = u(1:3);
L1 = u(4:5);
L2 = u(6:7);

r1 = hypot(pos(1)-L1(1), pos(2)-L1(2));
r2 = hypot(pos(1)-L2(1), pos(2)-L2(2));
b1 = atan2(L1(2)-pos(2), L1(1)-pos(1)) - pos(3);
b2 = atan2(L2(2)-pos(2), L2(1)-pos(1)) - pos(3);
y = [r1; r2; b1; b2];
end

