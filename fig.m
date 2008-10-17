function [handle] = fig(str)
%FIG Figures labelled by string name.
% HANDLE = FIG(STR)
%
% FIG(STR) will bring the figure with name STR to the front and make it the
% current figure. If there is no figure with name STR, it will also be
% created. Outputs the numerical figure handle.
%
% Examples:
%   fig('freq response');
%   handle = fig('coherence')
%
% Copyright Will Robertson 2004--2007
% Please use this code for any purpose you wish.

if nargin < 1
  str = 'newfig';
end

%background_colour  = get(0,'defaultFigureColor');
background_colour  = [1 1 1];

if isempty(findobj('name',str))
    h = figure('Name',str,...
      'NumberTitle','off',...
      'Color',background_colour,...
      'Units','centimeters'...
    );
else
    h = figure(findobj('name',str));
end

if nargout > 0
  handle = h;
end