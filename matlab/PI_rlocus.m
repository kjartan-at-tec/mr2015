G = tf([1],[1,0])
F = tf([2,1], [1, 0])
figure(4)
clf
rlocus(G*F)
set(gcf, 'position', [100,100,800,500])
%xlabel('')
set(gca,'Fontsize', 14);
set(gca,'TickLabelInterpreter', 'latex');
set(gca, 'Xtick', [-2,-1,-0.5,0,0.5])
set(gca,'XTickLabel', {'$-\frac{4}{T_i}$', ...
    '$-\frac{2}{T_i}$', '$-\frac{1}{T_i}$', ...
    '0', '$\frac{1}{T_i}$'});
set(gca, 'Ytick', [-0.5,0,0.5])
set(gca,'YTickLabel', {'$-\frac{1}{T_i}$', ...
    '0', '$\frac{1}{T_i}$'});

print -dpdf rlocus-integrator-PI.pdf