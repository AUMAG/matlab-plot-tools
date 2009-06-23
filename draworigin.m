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
%
% Please report bugs and feature requests for
% this package at the development repository:
%  <http://github.com/wspr/matlabpkg/>
%
% DRAWORIGIN  v0.1  2009/22/06  Will Robertson
% Licence appended.

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


% Copyright (c) 2009, Will Robertson, wspr 81 at gmail dot com
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
