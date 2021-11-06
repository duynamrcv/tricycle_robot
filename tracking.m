close all;

pose_mat = load('pose.mat');
ref_mat = load('ref.mat');
control_mat = load('control.mat');
ref_vel_mat = load('ref_vel.mat');

t = pose_mat.ans.Time;
pos = pose_mat.ans.Data;
ref = ref_mat.ans.Data;
con = control_mat.ans.Data;
ref_vel = ref_vel_mat.ans.Data;

%% Desired path
% figure();
% grid on;
% plot(ref(:,1), ref(:,2),'LineWidth',2);
% axis([-21 5 -5 5]);
% xlabel('x [m]')
% ylabel('y [m]');
% title('Reference Path');

%% Reference Velocity
% figure();
% subplot(211);
% grid on;
% plot(t, ref_vel(:,1),'LineWidth',2);
% xlabel('time [s]')
% ylabel('velocity [m/s]');
% subplot(212);
% grid on;
% plot(t, ref_vel(:,2),'LineWidth',2);
% xlabel('time [s]')
% ylabel('steering angle [rad]');

%% Tracked path
figure();
grid on;
hold on;
plot(ref(:,1), ref(:,2),'LineWidth',2);
plot(pos(:,1), pos(:,2),'LineWidth',2);
lgd = legend('Reference', 'Tracked path');
lgd.Location = 'West';
% axis([-21 5 -5 5]);
xlabel('x [m]')
ylabel('y [m]');
title('Robot Tracking');

%% Control
global v_max gamma_max
figure();
subplot(211);
hold on;
plot(t,v_max*ones(size(t)), '--b');
plot(t,-v_max*ones(size(t)), '--b');
plot(t,con(:,1),'LineWidth',2);
xlabel('time [s]');
ylabel('velocity [m/s]');
subplot(212)
hold on;
plot(t,gamma_max*ones(size(t)), '--b');
plot(t,-gamma_max*ones(size(t)), '--b');
plot(t,con(:,2),'LineWidth',2);
xlabel('time [s]');
ylabel('gamma [rad]');

%% Tracked position
figure();
subplot(311)
grid on;
hold on;
plot(t, ref(:,1),'LineWidth',2);
plot(t, pos(:,1),'LineWidth',2);
xlabel('time [s]');
ylabel('x [m]');
subplot(312)
grid on;
hold on;
plot(t, ref(:,2),'LineWidth',2);
plot(t, pos(:,2),'LineWidth',2);
xlabel('time [s]');
ylabel('y [m]');
subplot(313)
grid on;
hold on;
plot(t, ref(:,3),'LineWidth',2);
plot(t, pos(:,3),'LineWidth',2);
xlabel('time [s]');
ylabel('theta [rad]');

%% Error state
figure();
err = ref - pos;
subplot(311)
plot(t,err(:,1),'LineWidth',2);
xlabel('time [s]');
ylabel('error x [m]');
subplot(312)
plot(t,err(:,2),'LineWidth',2);
xlabel('time [s]');
ylabel('error y [m]');
subplot(313)
plot(t,err(:,3),'LineWidth',2);
xlabel('time [s]');
ylabel('error theta [rad]');