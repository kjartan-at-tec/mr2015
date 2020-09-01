%% PID tuning of the double tank using SIMC
% Kjartan Halvorsen
% 2020-08-27


h0 = 1.275;
uf = 0.015;
yf = 0.88;
K = yf/uf;
y1 = 0.2645*yf;
tau = 9.3; % Observed from bump test starting form empty tanks

% Tuning parameters
%tauc = tau*0.5; % Aggressive
tauc = tau; % Nominal
%tauc = 2*tau; % Cautious

% Series form
Kc = tau/(tauc*K);
tauI = tau;
tauD = tau;

% Parallel form
kc = Kc * (tauI+tauD)/tauI;
taui = tauI + tauD;
taud = tauI*tauD/(tauI+tauD);

N=20;
