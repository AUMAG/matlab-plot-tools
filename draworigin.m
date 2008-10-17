function [h1out h2out] = draworigin(origin,hv)
%DRAWORIGIN Plots a vertical/horizontal axis through an origin
%
% DRAWORIGIN without arguments will draw an origin in the same style as the
% plot axes around the point (0,0). (Actually, only the same thickness, at
% this stage.)
%
% In the context of this function, an "origin" is a vertical and/or
% horizontal line that crosses the entire range of the axes and meet at a
% single point.
%
% The origin is drawn beneath all other objects in the plot.
%
% DRAWORIGIN(ORIGIN) allows the origin to be selected.
%
% DRAWORIGIN(ORIGIN,'h') draws the horizontal origin.
%
% DRAWORIGIN(ORIGIN,'v') draws the vertical origin.
%
% The lines drawn with DRAWORIGIN are ignored from being automatically styled
% with the COLOURPLOT function by the same author.
%

%% Input argument processing
if nargin < 1
  origin = [0 0];  
end
if nargin < 2
  drawH = 1;
  drawV = 1;
else
  if strcmp(hv,'h')
    drawH = 1;
  elseif strcmp(hv,'v')
    drawV = 1;
  else
    error('DRAWORIGIN: optional second argument must be ''h'' or ''v''.')
  end
end

%% Implementation

% this is the AXIS line width, not the LINE line width:
linewidth = get(gca,'LineWidth');

figure(gcf);
hold on

if drawH
  xlim = get(gca,'xlim');
  h1 = plot(xlim,[origin(2) origin(2)],'color',[0 0 0],...
    'linewidth',linewidth,'UserData','colourplot:ignore');
  uistack(h1,'bottom')
end

if drawV
  ylim = get(gca,'ylim');
  h2 = plot([origin(1) origin(1)],ylim,'color',[0 0 0],...
    'linewidth',linewidth,'UserData','colourplot:ignore');
  uistack(h2,'bottom')
end

%% Output argument processing
if nargout == 2
  h1out = h1;
  h2out = h2;
elseif nargout == 1
  if drawH
    h1out = h1;
  elseif drawV
    h1out = h2;
  end
end