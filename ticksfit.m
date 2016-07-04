function  ticksfit( P, varargin )
%TICKSFIT Rescales axes so ticks are well-spaced
%
% Matlab's command `axis tight` sets the axis limits until they are just
% touching the plot extrema. This can be sometimes unsightly and in such
% cases one would prefer the axes to be tight but not quite touch the graph
% itself.
%
% However, doing this automatically (say by increasing the range by 10%)
% can give unbalanced placement of ticks with respect to the edges of the
% plot.
%
% This command first calls `axis tight`, then adds sufficient padding so
% that ticks are well-spaced. By default only the 'y'-axis is affected.
%
% TICKSFIT
%   Adds just enough to the axis as for `axis tight` but on both ends. For
%   example, if there are ticks at 0:5:10 and min/max data points are {-1,
%   12}, the axis is first "tightened" to [-1, 12] and then extended to
%   [-2,12] to have a spacing of 2 beyond the ticks at each end of the axis.
%
% TICKSFIT(P)
%   As above but change the axis limit space past the max tick to P ratio 
%   of the space between tick points.
%   E.g., with numbers as above, P = 0.2 will put the axis limits to
%   [-1, 11].
%
% TICKSFIT(P, AXIS1 [, AXIS2 [, AXIS3 [,...]]])
%   As above but for the AXIS specified. AXISn can be any of the
%   following strings:
%     'x','+x','-x','y','+y','-y','z','+z','-z'
%
% Copyright (c) 2016 Will Robertson, will at wspr dot io.
% All rights reserved.
% Licence information appended.

H = gca;
TICK_GAP_RATIO = 0.2;

if nargin < 1 || isempty(P), P = 0; end
if isempty(varargin), varargin = {'y'}; end

axis(H,'tight');

for ii = 1:length(varargin)
  switch varargin{ii}
    case 'x'
      set_tight_axis('x',[-1 1]);
    case 'y'
      set_tight_axis('y',[-1 1]);
    case 'z'
      set_tight_axis('z',[-1 1]);
    case '+x'
      set_tight_axis('x',[0 1]);
    case '+y'
      set_tight_axis('y',[0 1]);
    case '+z'
      set_tight_axis('z',[0 1]);
    case '-x'
      set_tight_axis('x',[-1 0]);
    case '-y'
      set_tight_axis('y',[-1 0]);
    case '-z'
      set_tight_axis('z',[-1 0]);
    otherwise
      error('Only ''x'' or ''y'' or ''z'' axes allowed.')
  end
end

  function set_tight_axis(axisdir,tickscale)
    
    limname  = [axisdir,'lim'];
    tickname = [axisdir,'tick'];
    allticks = get(H,tickname);

    if P == 0
      
      lim = get(H,limname);

      tickgap1 = -lim(1)   + allticks(1);
      tickgap2 =  lim(end) - allticks(end);
    
      tickgap = max(tickgap1,tickgap2);

      if tickgap == 0
        tickgap = TICK_GAP_RATIO*( allticks(2) - allticks(1) );
      end
      
    else
      
      tickgap = P*( allticks(2) - allticks(1) );
      
    end
    
    lim = allticks([1 end]) + tickgap*tickscale;
    set(H,limname,lim,tickname,allticks);
    
  end

end


% Distributed under the BSD licence in accordance with the wishes of the
% Matlab File Exchange. (Usually I'd pick the Apache License, but I'm easy.)
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
