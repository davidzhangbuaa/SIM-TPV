% !Mode:: "MATLAB:UTF-8"
clc; clear all; close all;

methods = {'ZYS', 'WHL'};

flag = [0 1 2];%flag(i) ==0/1 :formation is circle/parabolic;flag == 2:consenses
for j = 1:length(flag)

for index = 1:numel(methods)
    methods{index}
    ret{index} = simulate(methods{index},flag(j));
    plotfigure;
end

 %% calculate err norm
if flag(j) < 2
 figure('units','normalized','position', [.1 .1 .4 .6]);
 hold on;
 box on;

if ret{index}.flag == 0
    axis([0 10 0 4]);
 end
 if ret{index}.flag == 1
    axis([0 10 0 1.6]);
 end

 plot(ret{1}.t,ret{1}.Ep,'k','LineWidth', 0.7);
 plot(ret{2}.t,ret{2}.Ep,'k--','LineWidth', 0.7);
 xlabel('$t [s]$', 'Interpreter', 'LaTex', 'FontSize', 12);
 ylabel('$Ep [m]$', 'Interpreter', 'LaTex', 'FontSize', 12);
 legend({'ZYS','WHL'}, 'Interpreter', 'LaTex', 'FontSize',10,'Location','northeast');

 fig = gcf;
 fig.PaperPositionMode = 'auto';
 fig_pos = fig.PaperPosition;
 fig.PaperSize = [fig_pos(3) fig_pos(4)];
 print (strcat('err_norm_',ret{index}.str),'-dpdf')
end
end
