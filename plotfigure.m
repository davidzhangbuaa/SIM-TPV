% !Mode:: "MATLAB:UTF-8"
%% position xy
%%
if ret{index}.flag ==0
     figure('units','normalized','position', [.1 .1 .4 .6]);
     hold on;
     box on;

     for i = 1:ret{index}.n
         plot(ret{index}.x(:,i),ret{index}.y(:,i),'LineWidth', 0.7);
     end
     p4 = plot(ret{index}.Formation(:,1),ret{index}.Formation(:,2),'--','LineWidth',1.2);
     xlabel('$x [m]$', 'Interpreter', 'LaTex', 'FontSize', 12);
     ylabel('$y [m]$', 'Interpreter', 'LaTex', 'FontSize', 12);

     p1 = plot(ret{index}.x(1,1),ret{index}.y(1,1),'mo');plot(ret{index}.x(end,1),ret{index}.y(end,1),'mo');
     p2 = plot(ret{index}.x(1,2),ret{index}.y(1,2),'bs');plot(ret{index}.x(end,2),ret{index}.y(end,2),'bs');
     p3 = plot(ret{index}.x(1,3),ret{index}.y(1,3),'cd');plot(ret{index}.x(end,3),ret{index}.y(end,3),'cd');

     legend([p1 p2 p3 p4],{'agent-1', 'agent-2', 'agent-3','Formation'}, 'Interpreter', 'LaTex', 'FontSize',10,'Location','best');

     line([ret{index}.x(end,1),ret{index}.x(end,2)],[ret{index}.y(end,1),ret{index}.y(end,2)],'LineStyle','-','color',[0 .8 0]);
     line([ret{index}.x(end,3),ret{index}.x(end,1)],[ret{index}.y(end,3),ret{index}.y(end,1)],'LineStyle','-','color',[0 .8 0]);
     line([ret{index}.x(end,2),ret{index}.x(end,3)],[ret{index}.y(end,2),ret{index}.y(end,3)],'LineStyle','-','color',[0 .8 0]);

     fig = gcf;
     fig.PaperPositionMode = 'auto';
     fig_pos = fig.PaperPosition;
     fig.PaperSize = [fig_pos(3) fig_pos(4)];
     print (strcat('Posi_xy_',ret{index}.str,'@',methods{index}),'-dpdf')
end
%%
if ret{index}.flag == 1
     figure('units','normalized','position', [.1 .1 .4 .6]);
     hold on;
     box on;
%      P = {p1,p2,p3};
     for i = 1:ret{index}.n
         plot(ret{index}.x(:,i),ret{index}.y(:,i),'LineWidth', 0.7);
         plot(ret{index}.Formation_x(:,i),ret{index}.Formation_y(:,i),'--','LineWidth', 1.5);
     end
     xlabel('$x [m]$', 'Interpreter', 'LaTex', 'FontSize', 12);
     ylabel('$y [m]$', 'Interpreter', 'LaTex', 'FontSize', 12);

     p4 = plot(ret{index}.x(1,1),ret{index}.y(1,1),'mo');plot(ret{index}.x(end,1),ret{index}.y(end,1),'mo');
     p5 = plot(ret{index}.x(1,2),ret{index}.y(1,2),'bs');plot(ret{index}.x(end,2),ret{index}.y(end,2),'bs');
     p6 = plot(ret{index}.x(1,3),ret{index}.y(1,3),'cd');plot(ret{index}.x(end,3),ret{index}.y(end,3),'cd');

     line([ret{index}.Formation_x(1,1),ret{index}.Formation_x(1,2)],[ret{index}.Formation_y(1,1),ret{index}.Formation_y(1,2)],'LineStyle',':','color',[.8 0 0]);
     line([ret{index}.Formation_x(1,3),ret{index}.Formation_x(1,1)],[ret{index}.Formation_y(1,3),ret{index}.Formation_y(1,1)],'LineStyle',':','color',[.8 0 0]);
     line([ret{index}.Formation_x(1,2),ret{index}.Formation_x(1,3)],[ret{index}.Formation_y(1,2),ret{index}.Formation_y(1,3)],'LineStyle',':','color',[.8 0 0]);

     a = fix(length(ret{index}.t)/3);
     line([ret{index}.x(1,1),ret{index}.x(1,2)],[ret{index}.y(1,1),ret{index}.y(1,2)],'LineStyle','-','color',[0 .8 0]);
     line([ret{index}.x(1,3),ret{index}.x(1,1)],[ret{index}.y(1,3),ret{index}.y(1,1)],'LineStyle','-','color',[0 .8 0]);
     line([ret{index}.x(1,2),ret{index}.x(1,3)],[ret{index}.y(1,2),ret{index}.y(1,3)],'LineStyle','-','color',[0 .8 0]);

     line([ret{index}.x(a,1),ret{index}.x(a,2)],[ret{index}.y(a,1),ret{index}.y(a,2)],'LineStyle','-','color',[0 .8 0]);
     line([ret{index}.x(a,3),ret{index}.x(a,1)],[ret{index}.y(a,3),ret{index}.y(a,1)],'LineStyle','-','color',[0 .8 0]);
     line([ret{index}.x(a,2),ret{index}.x(a,3)],[ret{index}.y(a,2),ret{index}.y(a,3)],'LineStyle','-','color',[0 .8 0]);

     line([ret{index}.x(2*a,1),ret{index}.x(2*a,2)],[ret{index}.y(2*a,1),ret{index}.y(2*a,2)],'LineStyle','-','color',[0 .8 0]);
     line([ret{index}.x(2*a,3),ret{index}.x(2*a,1)],[ret{index}.y(2*a,3),ret{index}.y(2*a,1)],'LineStyle','-','color',[0 .8 0]);
     line([ret{index}.x(2*a,2),ret{index}.x(2*a,3)],[ret{index}.y(2*a,2),ret{index}.y(2*a,3)],'LineStyle','-','color',[0 .8 0]);

     line([ret{index}.x(end,1),ret{index}.x(end,2)],[ret{index}.y(end,1),ret{index}.y(end,2)],'LineStyle','-','color',[0 .8 0]);
     line([ret{index}.x(end,3),ret{index}.x(end,1)],[ret{index}.y(end,3),ret{index}.y(end,1)],'LineStyle','-','color',[0 .8 0]);
     line([ret{index}.x(end,2),ret{index}.x(end,3)],[ret{index}.y(end,2),ret{index}.y(end,3)],'LineStyle','-','color',[0 .8 0]);

     line([ret{index}.Formation_x(end,1),ret{index}.Formation_x(end,2)],[ret{index}.Formation_y(end,1),ret{index}.Formation_y(end,2)],'LineStyle',':','color',[.8 0 0]);
     line([ret{index}.Formation_x(end,3),ret{index}.Formation_x(end,1)],[ret{index}.Formation_y(end,3),ret{index}.Formation_y(end,1)],'LineStyle',':','color',[.8 0 0]);
     line([ret{index}.Formation_x(end,2),ret{index}.Formation_x(end,3)],[ret{index}.Formation_y(end,2),ret{index}.Formation_y(end,3)],'LineStyle',':','color',[.8 0 0]);

     legend([p4 p5 p6],{'agent-1', 'agent-2', 'agent-3'}, 'Interpreter', 'LaTex', 'FontSize',10,'Location','best');
     fig = gcf;
     fig.PaperPositionMode = 'auto';
     fig_pos = fig.PaperPosition;
     fig.PaperSize = [fig_pos(3) fig_pos(4)];
     print (strcat('Posi_xy_',ret{index}.str,'@',methods{index}),'-dpdf')
end
%%
if ret{index}.flag == 2
     figure('units','normalized','position', [.1 .1 .4 .6]);
     hold on;
     box on;
     axis([-2 5 -6 3]);
     for i = 1:ret{index}.n
         plot(ret{index}.x(:,i),ret{index}.y(:,i),'LineWidth', 0.7);
     end
     xlabel('$x [m]$', 'Interpreter', 'LaTex', 'FontSize', 12);
     ylabel('$y [m]$', 'Interpreter', 'LaTex', 'FontSize', 12);

     p1 = plot(ret{index}.x(1,1),ret{index}.y(1,1),'mo');
     p2 = plot(ret{index}.x(1,2),ret{index}.y(1,2),'bs');
     p3 = plot(ret{index}.x(1,3),ret{index}.y(1,3),'cd');
     p4 = plot(ret{index}.x(1,4),ret{index}.y(1,4),'yp');
     p5 = plot(ret{index}.x(1,5),ret{index}.y(1,5),'g^');
     p6 = plot(ret{index}.x(1,6),ret{index}.y(1,6),'k<');
     p7 = plot(ret{index}.x(1,7),ret{index}.y(1,7),'r>');

     legend([p1 p2 p3 p4 p5 p6 p7],{'agent-1','agent-2','agent-3','agent-4','agent-5','agent-6','agent-7'}, 'Interpreter', 'LaTex', 'FontSize',10,'Location','best');
     fig = gcf;
     fig.PaperPositionMode = 'auto';
     fig_pos = fig.PaperPosition;
     fig.PaperSize = [fig_pos(3) fig_pos(4)];
     print (strcat('Posi_xy_',ret{index}.str,'@',methods{index}),'-dpdf')
end
%% position x
%%
if ret{index}.flag < 2
 figure('units','normalized','position', [.1 .1 .4 .6]);
 hold on;
 box on;

 if ret{index}.flag == 0
    axis([0 20 -2 2]);
 end
 if ret{index}.flag == 1
    axis([0 20 -0.5 1.5]);
 end

 p1 = plot(ret{index}.t,ret{index}.x,'LineWidth', 0.7);
 p2 = plot(ret{index}.t,ret{index}.Formation_x,'--','LineWidth', 0.7);
 xlabel('$t [s]$', 'Interpreter', 'LaTex', 'FontSize', 12);
 ylabel('$x [m]$', 'Interpreter', 'LaTex', 'FontSize', 12);
 legend(p1,{'agent-1', 'agent-2', 'agent-3'}, 'Interpreter', 'LaTex', 'FontSize',10,'Location','south');
 ah=axes('position',get(gca,'position'),'visible','off');
 legend(ah,p2,{'formation:agent-1','formation:agent-2','formation:agent-3'}, 'Interpreter', 'LaTex', 'FontSize',10,'Location','southeast');
 fig = gcf;
 fig.PaperPositionMode = 'auto';
 fig_pos = fig.PaperPosition;
 fig.PaperSize = [fig_pos(3) fig_pos(4)];
 print (strcat('Posi_x_',ret{index}.str,'@',methods{index}),'-dpdf')
end
%% position y
%%
if ret{index}.flag < 2
 figure('units','normalized','position', [.1 .1 .4 .6]);
 hold on;
 box on;

 if ret{index}.flag == 0
     axis([0 20 -2 1.5]);
 end
 if ret{index}.flag == 1
    axis([0 20 -0.5 2]);
 end

 p1 = plot(ret{index}.t,ret{index}.y,'LineWidth', 0.7);
 p2 = plot(ret{index}.t,ret{index}.Formation_y,'--','LineWidth', 0.7);
 xlabel('$t [s]$', 'Interpreter', 'LaTex', 'FontSize', 12);
 ylabel('$y [m]$', 'Interpreter', 'LaTex', 'FontSize', 12);
 legend(p1,{'agent-1', 'agent-2', 'agent-3'}, 'Interpreter', 'LaTex', 'FontSize',10,'Location','south');
 ah=axes('position',get(gca,'position'),'visible','off');
 legend(ah,p2,{'formation:agent-1','formation:agent-2','formation:agent-3'}, 'Interpreter', 'LaTex', 'FontSize',10,'Location','southeast');
 fig = gcf;
 fig.PaperPositionMode = 'auto';
 fig_pos = fig.PaperPosition;
 fig.PaperSize = [fig_pos(3) fig_pos(4)];
 print (strcat('Posi_y_',ret{index}.str,'@',methods{index}),'-dpdf')
end

%% position z
%%
if ret{index}.flag < 2
 figure('units','normalized','position', [.1 .1 .4 .6]);
 hold on;
 box on;

 if ret{index}.flag == 0
     axis([0 15 0.9 1.5]);
 end
 if ret{index}.flag == 1
     axis([0 15 0.7 1.2]);
 end

 p1 = plot(ret{index}.t,ret{index}.z,'LineWidth', 0.7);
 p2 = plot(ret{index}.t,ret{index}.Formation_z,'--','LineWidth', 0.7);
 xlabel('$t [s]$', 'Interpreter', 'LaTex', 'FontSize', 12);
 ylabel('$z [m]$', 'Interpreter', 'LaTex', 'FontSize', 12);
 legend(p1,{'agent-1', 'agent-2', 'agent-3'}, 'Interpreter', 'LaTex', 'FontSize',10,'Location','north');
 ah=axes('position',get(gca,'position'),'visible','off');
 legend(ah,p2,{'formation:agent-1','formation:agent-2','formation:agent-3'}, 'Interpreter', 'LaTex', 'FontSize',10,'Location','northeast');
 fig = gcf;
 fig.PaperPositionMode = 'auto';
 fig_pos = fig.PaperPosition;
 fig.PaperSize = [fig_pos(3) fig_pos(4)];
 print (strcat('Posi_z_',ret{index}.str,'@',methods{index}),'-dpdf')
end
%% velocity x
%%
 figure('units','normalized','position', [.1 .1 .4 .6]);
 hold on;
 box on;

 if ret{index}.flag == 0
    axis([0 15 -1.5 1.5]);
 end
 if ret{index}.flag == 1
    axis([0 15 -0.2 0.3]);
 end
 if ret{index}.flag == 2
    axis([0 30 -3 2]);
 end
 xlabel('$t [s]$', 'Interpreter', 'LaTex', 'FontSize', 12);
 ylabel('$v_x [m/s]$', 'Interpreter', 'LaTex', 'FontSize', 12);
 p1 = plot(ret{index}.t,ret{index}.dot_x,'LineWidth', 0.7);

if ret{index}.flag < 2
 legend(p1,{'agent-1', 'agent-2', 'agent-3'}, 'Interpreter', 'LaTex', 'FontSize',10,'Location','north');
 p2 = plot(ret{index}.t,ret{index}.Formation_vx,'--','LineWidth', 0.7);
 ah=axes('position',get(gca,'position'),'visible','off');
 legend(ah,p2,{'formation:agent-1','formation:agent-2','formation:agent-3'}, 'Interpreter', 'LaTex', 'FontSize',10,'Location','northeast');
end
if ret{index}.flag == 2
   p2 = plot(ret{index}.t,ret{index}.aver(:,1),'--','LineWidth', 0.7);
   legend({'agent-1', 'agent-2', 'agent-3', 'agent-4', 'agent-5', 'agent-6', 'agent-7','$\bar{v}_x$'}, 'Interpreter', 'LaTex', 'FontSize',10,'Location','northeast');
end

 fig = gcf;
 fig.PaperPositionMode = 'auto';
 fig_pos = fig.PaperPosition;
 fig.PaperSize = [fig_pos(3) fig_pos(4)];
 print (strcat('Velo_x_',ret{index}.str,'@',methods{index}),'-dpdf')

%% velocity y
%%
 figure('units','normalized','position', [.1 .1 .4 .6]);
 hold on;
 box on;

 if ret{index}.flag == 0
    axis([0 15 -1 1]);
 end
 if ret{index}.flag == 1
    axis([0 15 -0.2 0.3]);
 end
 if ret{index}.flag == 2
    axis([0 30 -3 3]);
 end
 xlabel('$t [s]$', 'Interpreter', 'LaTex', 'FontSize', 12);
 ylabel('$v_y [m/s]$', 'Interpreter', 'LaTex', 'FontSize', 12);
 p1 = plot(ret{index}.t,ret{index}.dot_y,'LineWidth', 0.7);

 if ret{index}.flag < 2
 p2 = plot(ret{index}.t,ret{index}.Formation_vy,'--','LineWidth', 0.7);
 legend(p1,{'agent-1', 'agent-2', 'agent-3'}, 'Interpreter', 'LaTex', 'FontSize',10,'Location','south');
 ah=axes('position',get(gca,'position'),'visible','off');
 legend(ah,p2,{'formation:agent-1','formation:agent-2','formation:agent-3'}, 'Interpreter', 'LaTex', 'FontSize',10,'Location','southeast');
 end
 if ret{index}.flag == 2
   p2 = plot(ret{index}.t,ret{index}.aver(:,2),'--','LineWidth', 0.7);
   legend({'agent-1', 'agent-2', 'agent-3', 'agent-4', 'agent-5', 'agent-6', 'agent-7','$\bar{v}_y$'}, 'Interpreter', 'LaTex', 'FontSize',10,'Location','northeast');
 end
 fig = gcf;
 fig.PaperPositionMode = 'auto';
 fig_pos = fig.PaperPosition;
 fig.PaperSize = [fig_pos(3) fig_pos(4)];
 print (strcat('Velo_y_',ret{index}.str,'@',methods{index}),'-dpdf')

 %% velocity z
%%
 figure('units','normalized','position', [.1 .1 .4 .6]);
 hold on;
 box on;

 if ret{index}.flag == 0
    axis([0 15 -0.5 1]);
 end
 if ret{index}.flag == 1
    axis([0 15 -0.2 1]);
 end
 if ret{index}.flag == 2
    axis([0 30 -1.5 3]);
 end
 xlabel('$t [s]$', 'Interpreter', 'LaTex', 'FontSize', 12);
 ylabel('$v_z [m/s]$', 'Interpreter', 'LaTex', 'FontSize', 12);
 p1 = plot(ret{index}.t,ret{index}.dot_z,'LineWidth', 0.7);

 if ret{index}.flag < 2
 p2 = plot(ret{index}.t,ret{index}.Formation_vz,'--','LineWidth', 0.7);
 legend(p1,{'agent-1', 'agent-2', 'agent-3'}, 'Interpreter', 'LaTex', 'FontSize',10,'Location','north');
 ah=axes('position',get(gca,'position'),'visible','off');
 legend(ah,p2,{'formation:agent-1','formation:agent-2','formation:agent-3'}, 'Interpreter', 'LaTex', 'FontSize',10,'Location','northeast');
 end
 if ret{index}.flag == 2
   p2 = plot(ret{index}.t,ret{index}.aver(:,3),'--','LineWidth', 0.7);
   legend({'agent-1', 'agent-2', 'agent-3', 'agent-4', 'agent-5', 'agent-6', 'agent-7','$\bar{v}_z$'}, 'Interpreter', 'LaTex', 'FontSize',10,'Location','northeast');
 end
 fig = gcf;
 fig.PaperPositionMode = 'auto';
 fig_pos = fig.PaperPosition;
 fig.PaperSize = [fig_pos(3) fig_pos(4)];
 print (strcat('Velo_z_',ret{index}.str,'@',methods{index}),'-dpdf')
