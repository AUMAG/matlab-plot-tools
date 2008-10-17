function savefig(filename,fontname,fontsize,width,height)
% SAVEFIG Saves the current figure easily.
% Options are self-explanatory, I think.
%
% Edit the defaults to your liking.
%
% Creates directories ./fig/ and ./eps/ to save
% the current figure in both formats.

if nargin < 1
  disp('No figure saved: SAVEFIG needs at least a filename argument. Syntax:')
  disp('savefig( ''filename'' , ''fontname'' , ''fontsize'' , ''width'' , ''height'' )')
  return
end

if get(get(gcf,'CurrentAxes'),'View') == [ 0 90 ]
  % 2D plot; needs less space
  savefig_default_geom = [9 7];
else
  % 3D plot: gimme more room
  savefig_default_geom = [10 8];
end

if nargin < 5 || isempty(height)
  height = savefig_default_geom(2);
end
if nargin < 4 || isempty(width)
  width = savefig_default_geom(1);
end
if nargin < 3 || isempty(fontsize)
  fontsize = 10;
end
if nargin < 2 || isempty(fontname)
  fontname = 'Palatino';
end

%% set paper size
set(gcf,...
  'PaperUnits','centimeters',...
  'PaperPosition',[2 2 width height],...
  'PaperPositionMode','manual'...
  );

%% change fonts
fontobjs = findobj(gcf,'-regexp','FontName','.*');
for ii = fontobjs
  set(ii,'FontName',fontname,'FontSize',fontsize)
end

figureAxes = findobj(get(gcf,'Children'),'type','axes');
for aa = 1:length(figureAxes)
  thisAxis = figureAxes(aa);
  set(thisAxis,...
    'FontName',fontname,...
    'FontSize',fontsize);
  textProperties = get(thisAxis,{'XLabel','YLabel','ZLabel','Title'});
  set([textProperties{:}],'FontName',fontname,'FontSize',fontsize);
end

%% adjust xlabel

% set(get(get(gcf,'children'),'xlabel'),'VerticalAlignment','bottom');

%% save plots

if ~(exist('./eps','dir') == 7)
  mkdir eps
end
if ~(exist('./fig','dir') == 7)
  mkdir fig
end
if ~(exist('./latex','dir') == 7)
  mkdir latex
end

%% save using laprint

%laprint(gcf,['./latex/',filename],'options','laprint.mat','width',width)
matlabfrag(['./latex/',filename])

%% save eps
print('-depsc2',['./eps/',filename]);

%% save fig
saveas(gcf,['./fig/',filename],'fig');



% Copyright 2006 Will Robertson
%
% This MATLAB function may distributed and/or modified
% under the conditions of the LaTeX Project Public License, 
% version 1.3c or higher (at your discretion). 
%   <http://www.latex-project.org/lppl.txt>
% It consists of the file labelplot.m and is currently
% maintained by Will Robertson.