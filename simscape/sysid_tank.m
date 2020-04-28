%% Sysid experiment on the pneumatic tank model MR2015 2020
% Kjartan Halvorsen
% 2020-03-24

modelname = 'pneumatic_tank_sysid'
tank_volume = 0.4;
delta_p = 5; % Pressure difference of pressure source
p_atm = 101325 * 1e-5; % Atmospheric pressure
p_init = p_atm; % Initial pressure in the tank
A_pipe = pi*(1.5e-3)^2; % 3mm inner diameter pipes
A_valve_max = 0.99*A_pipe;

% Generate input signal
N = 300;
T_end = 60;
u = 0.7*sum(idinput([N, 6]), 2);
u(1:10) = -1.5;
u = repmat(u', [3,1]);
u = u(:);
t = linspace(0,T_end,3*N)';
offset = 0.0;
u_in = cat(2, t, u+offset);

figure(1)
clf
plot(t, u)

simOut = sim(modelname,'SimulationMode','normal','AbsTol','1e-5',...
            'SaveState','on','StateSaveName','xout',...
            'SaveOutput','on','OutputSaveName','yout',...
 'SaveFormat', 'Dataset');

Pbar = simOut.get('P');
Pbar.Data = Pbar.Data/1e5;
V_in = simOut.get('V_in');
V_in.Data = V_in.Data - 5;
figure(2)
subplot(211)
plot(Pbar.Time, Pbar.Data)
subplot(212)
plot(V_in.Time, V_in.Data)

%% System identification

% Skip first data points, due to initial response.
startind = find(Pbar.Time > t(12));

% Skip also any part where the pressure is negative. This
% happens only in the beginning due to problems finding
% the initial conditions.
startind = intersect(startind, find(Pbar.Data > 0));
startind = startind(1);

Pdot = ( Pbar.Data(startind+3:end) - Pbar.Data(startind+1:end-2) ) ./ ...
    (Pbar.Time(startind+3:end) - Pbar.Time(startind+1:end-2));

Pb = Pbar.Data(startind+2:end-1);
uout = V_in.Data(startind+2:end-1);
tvec = V_in.Time(startind+2:end-1);

posind = intersect(find(Pdot>0), find(uout>0));
negind = intersect(find(Pdot<0), find(uout<0));
upos = uout(posind);
uneg = uout(negind);
ppos = Pb(posind);
pneg = Pb(negind);

Pdotpos = Pdot(posind);
Pdotneg = Pdot(negind);

dPpos = delta_p - ppos;
dPneg = pneg;

% 1) Nonlinear model
% When u is positive, the model is 
%  \dot{p} = a_0u(p_s - p)^a_1, or 
%  \log \dot{p} = \log a_0 + \log u + a_1\log(p_s-p)
% When u is negative, the model is 
%  \dot{p} = a_0u(p-0)^a_1, or 
%  \log (-\dot{p}) = \log a_0 + \log (-u) + a_1\log p

bpos = log(Pdotpos) - log(upos);
Apos = cat(2, ones(size(bpos)), log(dPpos));
bneg = log(-Pdotneg) - log(-uneg);
Aneg = cat(2, ones(size(bneg)), log(dPneg));

% Least squares solution
theta_LS = cat(1, Apos, Aneg) \ cat(1, bpos, bneg)
a01 = exp(theta_LS(1))
a11 = theta_LS(2)

a02 = cat(1, upos.*sqrt(dPpos), uneg.*sqrt(dPneg)) \ ...
    cat(1, Pdotpos, Pdotneg)

figure(3)
clf
plot(log(dPpos), bpos, 'b.')
hold on
plot(log(dPneg), bneg, 'r.')
xl = get(gca, 'XLim');
plot(xl, xl*a11 + theta_LS(1), 'g', ...
    'LineWidth', 1.5)

legend('Flow into tank', 'Flow out of tank', ...
    sprintf('a_0=%0.2f, a_1=%0.2f', [a01, a11]), ...
    'location', 'best')
xlabel('$\log|\Delta p|$', 'Interpreter', 'latex', ...
    'FontSize', 16)
ylabel('$\log |\dot{p}|-\log |u|$', 'Interpreter', 'latex',...
    'FontSize', 16)
title('Fitting model $\log|\dot{p}| -\log |u| = \log a_0 + a_1\log|\Delta p|$', ...
    'Interpreter', 'latex', 'FontSize', 16)
print -dpdf tank-sysid-log.pdf

figure(4)
clf
plot(upos.*sqrt(dPpos), Pdotpos, 'b.')
hold on
plot(uneg.*sqrt(dPneg), Pdotneg, 'r.')
xl = get(gca, 'XLim');
plot(xl, xl*a02, 'g', ...
    'LineWidth', 1.5)
legend('Flow into tank', 'Flow out of tank', ...
    sprintf('a_0=%0.2f', a02), ...
    'location', 'best')
xlabel('$u\sqrt{\Delta p}$', 'Interpreter', 'latex')
ylabel('$\dot{p}$', 'Interpreter', 'latex')
title('Fitting model $\dot{p}= a_0 u \sqrt{|\Delta p|}$', ...
    'Interpreter', 'latex', 'FontSize', 16)
print -dpdf tank-sysid-sqrt-deltaP.pdf


%% Linear model
% The linear model of first order, with operating point at
% p_0 = 0.5*p_s, u_0=0 is 
% d/dt y = -ay + ku, with p = p_0 + y
delta_p = 5; % bar
p0 = 0.5*delta_p;
b_lin = Pdot;
A_lin = cat(2, -(Pb-p0), uout);

theta_lin_LS = A_lin \ b_lin;
a_lin = theta_lin_LS(1)
k_lin = theta_lin_LS(2)

% Simulate the fitted model and compare to pressure data
G = ss([-a_lin], [k_lin], [1], [0]);
ysim = lsim(G, u, t, [-p0]);

figure(5)
clf
plot(tvec, Pb, 'b', 'linewidth', 1.5)
hold on
plot(t, ysim+p0, 'g', 'linewidth', 1.5)
legend('Tank pressure', ...
    sprintf('Linear model output, a=%0.2f, k=%0.2f', ...
    [a_lin, k_lin]),...
    'location', 'best')
xlabel('Time [s]')
ylabel('Pressure [bar]')
title ('Fitting the model $\dot{y} = ay + ku$', ...
    'Interpreter', 'latex', 'FontSize', 16)
print -dpdf tank-sysid-linear-model.pdf




%% Validation
a0 = a01;
a1 = a11;

modelname = 'pneumatic_tank_sysid_validation'
tank_volume = 0.4;
% Generate input signal
N = 200;
T_end = 60;
uv = 0.5*sum(idinput([N, 6]), 2);
uv = repmat(uv', [3,1]);
uv = uv(:);
tv = linspace(0,T_end,3*N)';
offset = 0.0;
u_in = cat(2, tv, uv+offset);


simOut = sim(modelname,'SimulationMode','normal','AbsTol','1e-5',...
            'SaveState','on','StateSaveName','xout',...
            'SaveOutput','on','OutputSaveName','yout',...
 'SaveFormat', 'Dataset');

