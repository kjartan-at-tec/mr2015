%% PID tuning of the double tank using Ziegler-Nichols
% Kjartan Halvorsen
% 2020-08-27


h0 = 1.275;
uf = 0.015;
yf = 2.156-1.275;
K = yf/uf;
y1 = 0.283*yf;
h1 = y1 + h0
y2 = 0.632*yf;
h2 = y2 + h0

t1 = 62;
t2 = 130;

params = [1, 1/3;1, 1]\[t1;t2]
theta = params(1)
tau = params(2)


% ZN
kc = 1.2*tau/(K*theta);
taui = 2*theta;
taud = theta/2;

N=10;





