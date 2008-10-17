function legendshrink(s,align,lg)
% LEGENDSHRINK Shrink the legend lines
%
%   This is important for small plots because the size of the lines is
%   constant irrespective of the physical size of the figure. Only works
%   for vertical legends, for now.
%
%   LEGENDSHRINK(S): adjusts the length of the lines in the legend by
%   scaling factor S < 1. (S = 0.6 if omitted.) All legends in the current
%   figure are affected.
%
%   LEGENDSHRING(S,ALIGN): as above aligning the legend text as specified:
%      ALIGN = 'left' | 'right' | 'centre' | 'best' (default)
%   Default ('best') aligning adapts the alignment based on the 'location'
%   of the legend. The first letter can be used as a shorthand for each.
%
%   LEGENDSHRINK(S,ALIGN,LG): as above for legend handle(s) LG.
%
%   If S or ALIGN are [] then default values are used.
%
% EXAMPLE
%   figure; hold on
%   plot(1:10,'.-'); 
%   plot(10:-1:1,'o-'); 
%   legend({'one' 'two'},'location','north')
%   legendshrink
%
% v0.2 18 Dec 2007
%      labelplot's legend title is now supported
%      Multiple legends possible
%      User-specified aligning if desired
%
% v0.1 18 Dec 2007
%      Initial version
%
% License appended to the source.

%% Input parsing
if nargin < 1 || isempty(s),     s = 0.6;        end
if nargin < 2 || isempty(align), align = 'best'; end
if nargin < 3
  % all legends in the current figure:
  lg = findobj(gcf,'Tag','legend');
end

if isempty(lg)
  warning('LEGENDSHRINK:nolegend',...
    'There is no legend to shrink. Exiting gracefully.');
  return
elseif length(lg) > 1
  % If there are multiple legends then re-call the function for each
  % individual legend handle:
  for ii = 1:length(lg)
    legendshrink(s,align,lg(ii))
  end
  return
end

%% Get parameters
% Will break if children are added to the legend axis. Damn.

lch = get(lg,'Children');
% this allows interaction with labelplot.m:
cch = findobj(lch,'-not','Tag','legendlabel');
cll = findobj(lch,'Tag','legendlabel');

orientation = get(lg,'Orientation');
legendloc = get(lg,'Location'); 
orientvertical = strcmp(orientation,'vertical');

%% Resizing and aligning

if orientvertical
  if align(1)=='l'
    legendtrim = @legendtrimleft;
  elseif align(1)=='r'
    legendtrim = @legendtrimright;
  elseif align(1)=='c'
    legendtrim = @legendtrimcentre;
  else
% Want to ensure that the legend is trimmed away from the side that's being
% aligned to the figure; e.g., if the legend is inside the figure on the
% right, then the left side needs to be trimmed. And vice versa. Centre it
% if unsure. (Perhaps there should be an option to always do this.)
    if ~isempty(regexpi(legendloc,'WestOutside$')) || ...
        ~isempty(regexpi(legendloc,'East$'))
      legendtrim = @legendtrimleft;
    elseif ~isempty(regexpi(legendloc,'EastOutside$')) || ...
        ~isempty(regexpi(legendloc,'West$'))
      legendtrim = @legendtrimright;
    else
      legendtrim = @legendtrimcentre;
    end
  end
else
  warning('LEGENDSHRINK:horizontal',...
    'There is yet no implemented method for shrinking horizontal legends. Exiting gracefully.');
  legendtrim = @legendtrimabort;
end

%% Loop through and adjust the legend children

% hack to get things working for now:
cch_lines = findobj(cch,'Type','Line');
cch_min = find(cch==cch_lines(1));
cch = cch(cch_min:end);
cch_max = 3*floor(length(cch)/3);
cch = cch(1:cch_max);

for ii = 2:3:length(cch)
  %  ii-1  ==  marker handle (line handle)
  %  ii    ==    line handle
  %  ii+1  ==    text handle
  linepos = get(cch(ii),'XData');
  textpos = get(cch(ii+1),'Position');
  linewidth = linepos(2)-linepos(1);
  
  [newlinepos newtextpos] = legendtrim(linepos,textpos);
  
  set(cch(ii-1),'XData',   mean(newlinepos));
  set(cch(ii),  'XData',   newlinepos);
  set(cch(ii+1),'Position',newtextpos);
end

%% Adjust the legend title, if any
% This is provided by labelplot.m (same author)

if ~isempty(cll)
  llpos = get(cll,'Position');
  if isequal(legendtrim,@legendtrimleft)
    llpos(1) = llpos(1)+s*linewidth/2;
  elseif isequal(legendtrim,@legendtrimright)
    llpos(1) = llpos(1)-s*linewidth/2;
  end
  set(cll,'Position',llpos);
end

%% subfunctions

  function [newlinepos newtextpos] = legendtrimleft(linepos,textpos)
    newlinepos = linepos;
    newtextpos = textpos;
    newlinepos(1) = linepos(2)-s*linewidth;
  end
  function [newlinepos newtextpos] = legendtrimright(linepos,textpos)
    newlinepos = linepos;
    newtextpos = textpos;
    newlinepos(2) = linepos(1)+s*linewidth;
    newtextpos(1) = textpos(1)-(linepos(2)-newlinepos(2));
  end
  function [newlinepos newtextpos] = legendtrimcentre(linepos,textpos)
    newlinepos = linepos;
    newtextpos = textpos;
    newtextpos(1) = textpos(1)-(1-s)*linewidth/2;
    newlinepos(1) = linepos(1)+(1-s)*linewidth/2;
    newlinepos(2) = newlinepos(1)+s*linewidth;
  end
  function [newlinepos newtextpos] = legendtrimabort(linepos,textpos)
    newlinepos = linepos;
    newtextpos = textpos;
  end

end

% Copyright 2007 Will Robertson
%
% This MATLAB function, legendshrink, may distributed and/or 
% modified under the conditions of the LaTeX Project Public License, 
% version 1.3c or higher: <http://www.latex-project.org/lppl.txt>
% This package consists of the file legendshrink.m and is currently
% maintained by Will Robertson.
