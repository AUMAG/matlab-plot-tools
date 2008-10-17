function [handle] = fig(str,size)
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

if strcmp(size,'small')
  height = 6;
  aratio = 0.8;
elseif strcmp(size,'large')
  height = 8;
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
      'Units','centimeters'...
    );
    hPos = get(figH,'Position');
    set(figH,'Position',[hPos(1:2) width height]);
else
  figure(figH);
end

clf
hold on

if nargout > 0
  handle = figH;
end