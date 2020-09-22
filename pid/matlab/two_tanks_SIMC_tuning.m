%% PID tuning of the double tank using SIMC
% Kjartan Halvorsen
% 2020-08-27


h0 = 1.275;
uf = 0.015;
yf = 2.156-1.275;
K = yf/uf;
ytau = 0.2645*yf;
htau = ytau + h0
tau = 59; % Observed from bump test starting at h=1.275

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

N=10;

tau_t = sqrt(taui*taud)




