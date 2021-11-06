function y = pos_err( u )
%POS_ERR
pos = u(1:3);
tar = u(4:6);
theta = pos(3);

Hinv = [cos(theta)  sin(theta)  0;...
        -sin(theta) cos(theta)  0;...
        0           0           1];
y = Hinv*(tar-pos);
end

