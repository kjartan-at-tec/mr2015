%% PID tuning of the double tank using SIMC
% Kjartan Halvorsen
% 2020-08-27

% Plant parameters
a = (0.1)^2;
A = 1^2;
g = 9.8;

% Modeling of the first tank
uf = 0.05;
yf = 2-1.275;
K1 = yf/uf;
t1 = 33.6;

% Theoretical values from linearizing the model about
% h0=1.275, z0=0.05
h0 = 1.275; z0 = 0.05;
t1_lin = A/a/sqrt(2*g)*2*sqrt(h0)
K1_lin = t1_lin/A
G = tf([K1_lin], [t1_lin, 1]);

%% Designing inner controller for tank 1

% Control  objective:  Critically damped with poles in 
% s = -n/t1, n>4
% PI-controller F(s) = kc1 (s tau_i1 + 1)/(s tau_i1)
% 
%Assuming branches starting at 0 and -1/t1 branches off
% at -1/(2t1), forming circle with PI-zero as its center
% will intersect negative real axis at -4/t1 if zero in
% -9/(4t1).
%
n1=8;
z1 = (n1 - 0.5)/2
taui1 = t1/z1;

figure(1)
clf
rlocus(G*tf([taui1, 1], [taui1, 0]))
%kc1 = 0.226; % For n=4
kc1 = 0.406; % For n=8

Gc1 = feedback(kc1*tf([taui1, 1], [taui1,0])*G, 1);
Gc1u = feedback(kc1*tf([taui1, 1], [taui1,0]),G);
pole(Gc1)
-n1/t1
% Close enough

% Simulate linear system
[y,t] = step((2-1.275)*Gc1);
[uu,tt] = step((2-1.275)*Gc1u);

figure(2)
clf
subplot(211)
plot(t, 1.275 + y)

subplot(212)
plot(tt, uu)

%% Designing outer controller for tank 2

% The practical alternative is to fit a first-order model to 
% the response of tank 2.

% Can also make use of knowledge about system:
% Want to use flow as input variable, and since
% f12 = a*sqrt(2g)sqrt(h1) <=> h1 = 1/(2g)(f12/a)^2.

y2 = 1.275 + 0.632*(2-1.275)
t2 = 59; % Just somewhat slower than t1=51.0 and not 
         % affected by n1 (or very little)

% Controller objective: two poles in s = -2/t2;
taui2 = t2*3/4;

figure(3)
clf
rlocus(tf([1], [t2, 1])*tf([taui2, 1], [taui2, 0]))

kc2 = 3;

% Controller objective: two poles in s = -1/t2;
taui2 = t2;

figure(3)
clf
rlocus(tf([1], [t2, 1])*tf([taui2, 1], [taui2, 0]))

kc2 = 1;
pole(feedback(kc2*tf([taui2, 1],[taui2, 0])*tf([1], [t2, 1]), 1))


% For comparison, SIMC 
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

N=1e2;













