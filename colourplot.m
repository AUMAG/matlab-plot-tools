
function [ RGBOUT ] = colourplot( series , permute )
%COLOURPLOT Make colourful, nice-looking plots
%  This function takes the current figure and splits up the HSV colour
%  space by the number of data lines there are. These colours are then
%  converted to RGB and applied to the plot.
%
% COLOURPLOT(N)
%  An optional argument specifies the number of times to use the
%  colour space: e.g., colourplot(2) will turn, in a graph with 6 data
%  series, the first and fourth plot blue, the second and fifth
%  green, and the third and six red. The divisor of the number of
%  plots and the number of colour space repetitions must be an
%  integer.
%
% COLOURPLOT(N,PERMUTE)
%  By default the lines are coloured in the order in which they
%  were plot. This order can be changed by specifying a permutation
%  of the order in the second argument, such as in a four-plot graph:
%      colourplot(1,[1 3 2 4])
%
%  If the 'UserData' for a data line is 'colourplot:ignore', then
%  it will not be included in the COLOURPLOT colouring.
%
%  RGBOUT = colourplot( ... ) will simply return the colours that
%  would be used, but it will NOT attempt to colour the plot.
%
%
% Please report bugs and feature requests for
% this package at the development repository:
%  <http://github.com/wspr/matlabpkg/>
%
% COLOURPLOT  v0.3  2010/13/01  Will Robertson
% Licence appended.

if nargin == 0
  series = 1;
end

ch = findobj(gca,'Type','line','-not','UserData','colourplot:ignore');

Nch = length(ch);
Ncol = Nch/series;
if round(Ncol) ~= Ncol
  % Each set of data series must be the same length to avoid rounding problems!!
  disp(['There are ',num2str(Nch),' data series'])
  error('There must be an integer multiple of specified data series in the figure.')
end

hsv = ones(Ncol,3);
hsv(:,1) = ((1:Ncol)-1)'/Ncol;
hsv(:,2) = 0.5;
hsv(:,3) = 0.8;

rgb = hsv2rgb(hsv);

if nargin < 2
  permute = 1:Nch;
else
  if ~isequal(sort(permute),1:Nch)
    error('2nd argument must be a permutation of 1:N where N is the number of colours.');
  end
end

if nargout == 0
  for ii = 1:Nch
    if isequal(get(ch(ii),'type'),'line')
      set(ch(permute(ii)),'Color',rgb(mod(ii-1,Ncol)+1,:),...
        'UserData','colourplot:ignore')
    end
    if isequal(get(ch(ii),'type'),'surface')
      set(ch(permute(ii)),...
        'FaceColor',rgb(mod(ii-1,Ncol)+1,:),...
        'EdgeColor',rgb(mod(ii-1,Ncol)+1,:),...
        'UserData','colourplot:ignore')
    end
  end
else
  RGBOUT = rgb;
end

return

% Copyright (c) 2005-2010, Will Robertson, wspr 81 at gmail dot com
% All rights reserved.
%
% Distributed under the BSD licence in accordance with the wishes of the
% Matlab File Exchange.
%
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
%     * Redistributions of source code must retain the above copyright
%       notice, this list of conditions and the following disclaimer.
%     * Redistributions in binary form must reproduce the above copyright
%       notice, this list of conditions and the following disclaimer in the
%       documentation and/or other materials provided with the distribution.
%
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER ''AS IS'' AND ANY
% EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
% WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
% DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER BE LIABLE FOR ANY
% DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
% (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
% LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
% ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
% (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
% THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
