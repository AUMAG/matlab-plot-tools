
%% create the figure
figure('Name','test fig','NumberTitle','off','color',[1 1 1])
p = surf(peaks);
%legend('peaks');
set(p,'facealpha',0.5)
axis tight

%% export graph
% with no axes
axis off
print -depsc2 -zbuffer data.eps

%% export the axes
% with transparent background
axis on
set(gca,'color','none')
set(gcf,'color','none','inverthardcopy','off')
set(p,'visible','off') % hide the data
grid off
print -depsc2 -painters axes.eps

epscombine('axes.eps','data.eps','test.eps')
