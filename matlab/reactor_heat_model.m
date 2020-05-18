%% Continuous reactor and heat jacket model

% Model
s = tf('s');
Gt = 1/(2*s+1);
Gh = 1/(s+1);
G = Gt*Gh;
Gv = Gt;

% PI-controller
Ti = 4/3;
F = (1 + 1/(s*Ti));

figure(1)
clf
rlocus(G*F)
set(findall(gca, 'Type', 'Line'), 'MarkerSize', 14)
set(gcf, 'position', [100,100,800,500])
%xlabel('')
set(gca,'Fontsize', 14);
set(gca,'TickLabelInterpreter', 'latex');
set(gca, 'Xtick', [-1,-3/4,-0.5,0,0.5])
set(gca,'XTickLabel', {'$-1$', ...
    '$-\frac{3}{4}$', '$-\frac{1}{2}$', ...
    '0', '$\frac{1}{2}$'});
set(gca, 'Ytick', [-2,-1,0,1,2])

print -dpdf rlocus-reacter-heat.pdf

