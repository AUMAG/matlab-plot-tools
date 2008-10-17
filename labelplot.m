function legend_handle = labelplot( p , o , str , i)
%LABELPLOT Creates an automatic legend based on 'Tag'
%
%  For every plotted data run, set the 'Tag' string to the label of the data.
%  E.g.:     p1 = plot(x,y);
%            p2 = plot(a,b,'Tag','A vs. B');
%            p3 = plot(c,d,'Tag','C vs. D');
%  Calling LABELPLOT will create a legend equivalent to:
%            legend([p2 p3],'A vs. B','C vs. D')
%
%  Optional additional arguments 1 & 2 specify legend attributes: 
%  (see `help legend' for more information)
%    labelplot( <location> )
%    labelplot([], <orientation> )
%
%  <location> defaults to 'northoutside' and <orientation> defaults to 
%  'vertical' except when <location> is 'northoutside' or 'southoutside'.
%
%  Optional argument 3 specifies a legend label:
%    labelplot([],[], <label string> )
%  with a default of the empty string.
%
%  Optional argument 4 specifies a text interpreter:
%    labelplot([],[],[], <interpreter> )
%  where <interpreter> can be 'none' (default), 'tex', or 'latex'.
%
%
% v0.5 19 Dec 2007
% License appended to the source.

%% Set up default legend placement
% These can/should be adjusted to suit.
if nargin < 1 || isempty(p), p = 'northoutside'; end
if nargin < 2 || isempty(o)
  if isequal(p,'northoutside') || isequal(p,'southoutside')
    o = 'horizontal';
  else
    o = 'vertical';
  end
end
if nargin < 3 || isempty(str), str = ''; end
if nargin < 4 || isempty(i), i = 'none'; end

%% Grab the data plots and their 'Tag' strings, make the legend
% For empty 'Tag's, delete the corresponding data plot from the
% legend index.
ch = findobj(gca,'Type','line','-not','UserData','colourplot:ignore');
strings = get(ch,'Tag');
if length(ch) > 1
  % Remove empty tags:
  legend_index = cellfun('isempty',strings);
  ch = ch(~legend_index);
  strings = strings(~legend_index);
  % Turns out that legends are created first in, last out with
  % respect to the ordering of the respective axes children vector.
  % So we reverse the order to get it back to normal.
  legend_h = legend(ch(end:-1:1),strings(end:-1:1),'location',p,'orientation',o);
  set(legend_h,'interpreter',i);
end

%% Place the legend label
%
% The font and fontsize is the same as the legend, which is inherited from
% the figure. This can be altered by something like
%    set(findobj('Tag','legendtitle'),'FontSize',14)
% but note that savefig.m (same author) will overwrite this kind of thing.

if exist('legend_h','var')==1 && ~isequal(str,'')
  fontname = get(legend_h,'FontName');
  fontsize = get(legend_h,'FontSize');
  text(0.5,1,str,...
    'Parent',legend_h,...
    'HorizontalAlignment','center',...
    'VerticalAlignment','bottom',...
    'Tag','legendlabel',...
    {'FontName','FontSize'},{fontname,fontsize},...
    'Interpreter',i);
end

%% Outputs

% Don't put a box around the legend:
legend boxoff

if nargout==1
  legend_handle = legend_h;
end

% Copyright 2006 Will Robertson
%
% This MATLAB function may distributed and/or modified
% under the conditions of the LaTeX Project Public License, 
% version 1.3c or higher (at your discretion). 
%   <http://www.latex-project.org/lppl.txt>
% It consists of the file labelplot.m and is currently
% maintained by Will Robertson.
