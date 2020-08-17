%% Temperature control of CSTR

% Kjartan Halvorsen 
% 2020-08-14

% Parameters
f = 1;
f0=2;
k1=1;
k2=1;
k3=4;
k4=6;
Ti = 23;
Ts = 60;

den_Th = f0*k3 + k4 - k4*k2/(f*k1+k2);
Th0 = f0*k3/den_Th*Ts + ...
    k4*f*k1/(f*k1+k2) / den_Th * Ti
T0 = f*k1/(f*k1+k2) * Ti + k2/(f*k1+k2)*Th0
f0*k3/(f0*k3 + k4)*Ts + k4/(f0*k3 + k4)*T0

%% Fitting first-order model with delay to u->y2
% Step of magnitude 1 ocurring at t=1
yfinal = 2.11;
yT1 = 0.283*yfinal;
yT2 = 0.632*yfinal;
TT1 = 0.24;
TT2 = 0.641;

% Solve eqn system
% tau+T/3 = T1
% tau + T = T2
params = [1, 1/3; 1, 1]\[TT1;TT2]
tau1  = params(1);
T1 = params(2);
K1 = yfinal/2;

A = [-(f*k1 + k2) k2; k4 -(fh*k3 + k4)];
B = [k1*Ti 0; 0 k3*Ts];
C = eye(2);
D = zeros(2,2);

sys = ss(A,B,C,D);

figure(1)
clf
pzmap(sys)
