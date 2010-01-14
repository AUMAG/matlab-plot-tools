function [h1out h2out] = draworigin(origin,varargin)
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
% DRAWORIGIN(ORIGIN,OPTS) allows a variable number of options to be passed
%
%    'h' - draws the horizontal origin only.
%    'v' - draws the vertical origin only.
%    anything else - the linestyle for the origin lines
%
% E.g., to draw dashed lines write:
%
%    draworigin([0 0],'--')
%
% The lines drawn with DRAWORIGIN are ignored from being automatically styled
% with the COLOURPLOT function by the same author.
%
%
% Please report bugs and feature requests for
% this package at the development repository:
%  <http://github.com/wspr/matlabpkg/>
%
% DRAWORIGIN  v0.2  2010/13/01  Will Robertson
% Licence appended.

%% Input argument processing

if nargin < 1
  origin = [0 0];  
end

drawH = 1;
drawV = 1;
linestyle = '-';

for ii = 1:length(varargin)
  switch varargin{ii}
    case 'h', drawV = 0;
    case 'v', drawH = 0;
    otherwise
      linestyle = varargin{ii};
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
    'linewidth',linewidth,'linestyle',linestyle,'UserData','colourplot:ignore');
  uistack(h1,'bottom')
end

if drawV
  ylim = get(gca,'ylim');
  h2 = plot([origin(1) origin(1)],ylim,'color',[0 0 0],...
    'linewidth',linewidth,'linestyle',linestyle,'UserData','colourplot:ignore');
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


% Copyright (c) 2009-2010, Will Robertson, wspr 81 at gmail dot com
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
