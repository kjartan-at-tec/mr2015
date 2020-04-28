%% Solution to P and PI-design for tank-valve system

% Model parameters
a0 = 1.1;
a1 = 0.47;
p0 = 2.5;
delta_p = 5;
b_lin = a0*exp(0.47*log(delta_p-p0));

% Linearized model
s = tf('s');
G = b_lin/s;

% Spec
ts = 1.8; % Less than 2s
PO = 8; % Less than 10%

%% Proportional control

% Desired pole
% ts = 4 tau, tau=1/a, s+Kb = 0, a=Kb, 
Kp = 4/ts/b_lin
pole(feedback(Kp*G, 1))



%% Proportional-integral control

% Desired poles
realpart = -4/ts
zeta = sqrt((log(PO/100))^2/(pi^2 + (log(PO/100))^2))
theta = acos(zeta)
impart = tan(theta)*realpart


% Root locus
Ti=0.35;
Ti=0.7;

F = 1 + 1/(s*Ti);
figure(1)
clf
rlocus(G*F)
ylim(abs(impart)*1.2*[-1,1])
hold on
plot([realpart,realpart], [impart,-impart], 'x', 'linewidth', 2)
print -dpdf rlocus_PI_tank.pdf

K=2.62;
Gc = feedback(K*G*F, 1)
[num, den] = tfdata(Gc);
num = num{1}/den{1}(1)
den = den{1}/den{1}(1)

figure(2)
clf
pzmap(Gc, 1))
print -dpdf pzmap_PI_tank.pdf

