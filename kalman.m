clc;
close all;

%% Load the truth control signal
contrlsig = load('contrlsig.mat');
vel = contrlsig.inp;

%% Load the measurement data
measda = load('MeasurementFile/measdat6.mat');
z = measda.me;

%% Initial consition of robot
global d
% Robot position
pos_tru = zeros(3,length(vel)+1);   % The truth
pos_pre = zeros(3,length(vel)+1);   % The prediction
pos_kal = zeros(3,length(vel)+1);   % The kalman

dt = 0.05;  % Time step [s]
con = [0.1; 0.2];
t = 0:dt:40;
%% Compute the truth poses
for i = 2:length(t)
    pos_tru(:,i) = pos_tru(:,i-1) + tricycle_model([pos_tru(:,i-1);vel(:,i-1);0])*dt;
end

%% Compute the predict poses
for i = 2:length(t)
    pos_pre(:,i) = pos_pre(:,i-1) + tricycle_model([pos_pre(:,i-1);con;0])*dt;
end

%% Compute the Kalman filter 
L1 = [3;4]; L2 = [4;4];
% Parameter
sigma_v = 2.5*10^-3;
sigma_gamma = 3.6*10^-3;
sigma_r = 10^-6;
sigma_beta = 7.62*10^-5;

Q = diag([sigma_v sigma_gamma]);
R = diag([sigma_r sigma_r sigma_beta sigma_beta]);
P = zeros(3);
for i = 2:length(t)
    % Predict
    x = pos_kal(:,i-1);
    A = [1  0   -con(1)*sin(x(3))*dt;...
         0  1   con(1)*cos(x(3))*dt;...
         0  0   1];
    W = [cos(x(3))*dt       0;...
         sin(x(3))*dt       0;...
         tan(con(2))*dt/d   con(1)*dt/(d*cos(con(2))^2)];
    x_ = x + tricycle_model([x;con;0])*dt;
    P_ = A*P*A' + W*Q*W';
   
    % Update
    mes = measure([x;L1;L2]);
    H = [(x(1)-L1(1))/mes(1)       (x(2)-L1(2))/mes(1)    0;...
         (x(1)-L2(1))/mes(2)       (x(2)-L2(2))/mes(2)    0;...
         -(x(2)-L1(2))/mes(1)^2    (x(1)-L1(1))/mes(1)^2  -1;...
         -(x(2)-L2(2))/mes(2)^2    (x(1)-L2(1))/mes(2)^2  -1];
    K = P_*H'*(H*P_*H' + R)^(-1);
    pos_kal(:,i) = x_ + K*(z(:,i) - measure([x_;L1;L2]));
    P = (eye(3) - K*H)*P_;
end

%% Plot the results
% Path
figure();
grid on;
hold on;
plot(pos_tru(1,:), pos_tru(2,:), '-k', 'LineWidth', 2);
plot(pos_pre(1,:), pos_pre(2,:), '--r', 'LineWidth', 2);
plot(pos_kal(1,:), pos_kal(2,:), '-.b', 'LineWidth', 2);
lgd = legend('Actual', 'Predict', 'Kalman');
lgd.Location = 'southeast';
xlabel('x [m]')
ylabel('y [m]');
title('Kalman');

% creating the zoom-in inset
ax=axes;
set(ax,'units','normalized','position',[0.2,0.6,0.3,0.3])
box(ax,'on')
hold on
plot(pos_tru(1,:), pos_tru(2,:), '-k', 'LineWidth', 2, 'parent',ax);
plot(pos_pre(1,:), pos_pre(2,:), '--r', 'LineWidth', 2, 'parent',ax);
plot(pos_kal(1,:), pos_kal(2,:), '*b', 'LineWidth', 2, 'parent',ax);
set(ax,'xlim',[3.3,3.32],'ylim',[0.645,0.665])

%% Error
err_pre = pos_tru - pos_pre;
err_kal = pos_tru - pos_kal;
figure();
subplot(311)
grid on;
hold on;
plot(t, err_pre(1,:), '-r', 'LineWidth', 2);
plot(t, err_kal(1,:), '-b', 'LineWidth', 2);
lgd = legend('Predict Error', 'Kalman Error');
lgd.Location = 'southwest';
xlabel('time [s]')
ylabel('value [m]');
title('Error X');
subplot(312)
grid on;
hold on;
plot(t, err_pre(2,:), '-r', 'LineWidth', 2);
plot(t, err_kal(2,:), '-b', 'LineWidth', 2);
lgd = legend('Predict Error', 'Kalman Error');
lgd.Location = 'southwest';
xlabel('time [s]')
ylabel('value [m]');
title('Error Y');
subplot(313)
grid on;
hold on;
plot(t, err_pre(3,:), '-r', 'LineWidth', 2);
plot(t, err_kal(3,:), '-b', 'LineWidth', 2);
lgd = legend('Predict Error', 'Kalman Error');
lgd.Location = 'southwest';
xlabel('time [s]')
ylabel('value [rad]');
title('Error Theta');