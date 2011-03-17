function [handle] = willfig(str,size)
%WILLFIG Figures labelled by string name and sized consistently.
% HANDLE = WILLFIG(STR)
%
% WILLFIG(STR) will bring the figure with name STR to the front and make it the
% current figure. If there is no figure with name STR, it will also be
% created. Outputs the numerical figure handle.
%
% Examples:
%   willfig('freq response')
%   handle = willfig('coherence')
%
% Copyright Will Robertson 2008
% Distributed under the LaTeX Project Public Licence

if nargin < 1
  str = 'newfig';
end
if nargin < 2
  size = 'large';
end

cm_to_pt = @(x) x*72/2.54;

if strcmp(size,'small')
  height = 7;
  aratio = 0.8;
elseif strcmp(size,'large')
  height = 8;
  aratio = 0.8;
elseif strcmp(size,'3x2')
  height = 12;
  aratio = 0.7;
elseif strcmp(size,'tiny')
  height = 6;
  aratio = 0.8;
elseif strcmp(size,'small-legend')
  height = 6;
  aratio = 0.4;
elseif strcmp(size,'large-legend')
  height = 8;
  aratio = 0.5;
end

width = height/aratio;

figH = findobj('name',str);

if isempty(figH)
    figH = figure('Name',str,...
      'NumberTitle','off',...
      'color',[1 1 1],...
      'DefaultAxesBox','on',...
      'DefaultLineLineWidth',1,...
      'DefaultAxesTickLength',[0.02 0.05],...
      'DefaultAxesLayer','top'...
    );
    hPos = get(figH,'Position');
    set(figH,'Position',[hPos(1) hPos(2) cm_to_pt([width height])]);
else
  figure(figH);
end

clf
hold on

if nargout > 0
  handle = figH;
end