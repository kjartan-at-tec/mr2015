%% MR2015, Sysid tank system Spring 2020

ps = 5; % Supply pressure
u0 = 5; % Voltage at closed valve
as = 1, bs = 0; % p = as*us + bs, model of sensor 

% Observations
us = [0,0,0]'; % Sensor voltages at which slope was measured 
p = as*us + bs; % Pressures at which slope was measured
uv = [5.5, 6, 6.5]'; % Input voltages
delta_us = [0.86, 0.84, 1.16]'; % Voltage change in sensor
delta_t = [1.51, 0.22, 0.238]'; % for time interval
us_dot = delta_us./delta_t; % Rate of change in sensor voltage
p_dot = as*us_dot + bs; % Rate of change in pressure

exponent = 0.5; % 0.5 is the same as square root
Phi = [(uv - u0).*(ps-p).^exponent]; % Regressor

a = (Phi'*Phi)^(-1)*Phi'*p_dot % Least squares estimate

% Plot result

figure(1)
clf
plot(Phi, Phi*a) % Fitted model
hold on
plot(Phi, pdot, 'ro') % Observations

