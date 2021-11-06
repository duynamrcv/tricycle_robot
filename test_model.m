close all;

pose_mat = load('pose.mat');
control_mat = load('control.mat');
t = pose_mat.ans.Time;
pos = pose_mat.ans.Data;
con = control_mat.ans.Data;
for i = 1:length(pos)
    if pos(i,3) > pi
        pos(i,3) = pos(i,3)- 2*pi;
    end
end

% The control inputs
figure();
grid on;
plot(pos(:,1),pos(:,2),'LineWidth',2);
axis([-3 3 -1 4]);
xlabel('x [m]')
ylabel('y [m]');
legend('Robot path');
title('Robot Path');

figure();
grid on;
hold on;
plot(t,pos(:,1),'LineWidth',2);
plot(t,pos(:,2),'LineWidth',2);
plot(t,pos(:,3),'LineWidth',2);
lgd = legend('x [m]', 'y [m]', '\theta [rad]');
lgd.Location = 'southeast';
xlabel('time [s]')
ylabel('value');
title('Robot Position');

figure();
grid on;
hold on;
plot(t,con(:,1),'LineWidth',2);
plot(t,con(:,2),'LineWidth',2);
axis([0 10 0 2]);
lgd = legend('v [m/s]', '\gamma [rad/s]');
lgd.Location = 'southeast';
xlabel('time [s]')
ylabel('value');
title('Control Input');