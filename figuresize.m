function figuresize( varargin )
%FIGURESIZE Set a figure to a specific size
%
% When saving a figure as a PDF, it is necessary to set the
% figure size appropriately. This function sets the "paper size"
% sufficient that the figure is saved with a tight bounding box.
% (10% extra white space surrounding the figure on each side.)
% It will also set the figure size on screen correspondingly.
%
% figuresize()
%  - sets the figure size to 12cm width by 10cm height
%
% figuresize(N)
%  - SPECIAL CASE = figure(N); clf; hold on; figuresize()
%
% figuresize(width,height)
%  - sets the figure <width> and <height> in centimeters
%
% figuresize(width,height,units)
%  - sets the figure size in <units>
%  - <units> can be any of the standard Matlab length names,
%    as well as 'mm', 'cm', 'in', or 'pt'. Default 'cm'.
%
% figuresize(w,h,u,padscale)
%  - Use <padscale> to adjust (can be given as a single element or
%    two-element vector for width/height separately). Default 0.01.


if numel(varargin) == 0
  figuresize(12,10,'cm')
  return
end

if numel(varargin) == 1
  figure(varargin{:}); clf; hold on
  figuresize();
  return
end

allowed_units = {'normalized','centimeters','inches','points','cm','in','pt','mm'};

p = inputParser;
p.addRequired('width', @(x) isnumeric(x) && all(size(x)==1) );
p.addRequired('height',@(x) isnumeric(x) && all(size(x)==1) );
p.addOptional('units','centimeters',...
  @(x) any(strcmpi(x,allowed_units)) );
p.addOptional('padscale',0.01, @(x) isnumeric(x) )

p.parse( varargin{:} );
w = p.Results.width;
h = p.Results.height;
u = p.Results.units;
s = p.Results.padscale;

if numel(s) == 1
  s = [s s];
end

switch u
  case 'cm', u = 'centimeters';
  case 'in', u = 'inches';
  case 'pt', u = 'points';
  case 'mm', u = 'centimeters'; w = w/10; h = h/10;
end

set(gcf,'Units',u);
screenpos = get(gcf,'Position');

set(gcf,...
  'Position',[screenpos(1:2) w h],...
  'PaperUnits',u,...
  'PaperPosition',[s(1)*w s(2)*h w h],...
  'PaperSize',[w*(1+2*s(1)) h*(1+2*s(2))]);

end


% Copyright (c) 2010-2019 Will Robertson, wspr 81 at gmail dot com
% All rights reserved.
%
% Distributed under the BSD licence in accordance with the wishes of the
% Matlab File Exchange. (Usually I'd pick the Apache License.)
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