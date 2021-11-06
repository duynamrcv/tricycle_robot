function y = ref_vel( u )
%REF_VEL
vr = hypot(u(1), u(2));
y = [vr; u(3)];
end

