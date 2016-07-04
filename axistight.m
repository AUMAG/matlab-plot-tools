function  axistight( H, P, varargin )
%AXISTIGHT Makes a plot axis tight but not too tight
%
% Matlab's command `axis tight` sets the axis limits until they are just
% touching the plot extrema. This can be sometimes unsightly and in such
% cases one would prefer the axes to be tight but not quite touch the graph
% itself.
%
% This command does such a thing, using a certain percentage of the total
% plot range as padding. By default only the 'y' axis is affected.
%
% AXISTIGHT - extends the 'y' axis to 5% past `axis tight`.
%
% AXISTIGHT(H) - as above for plot with handle H.
%
% AXISTIGHT(H,P) - adjust the ratio used to extend the axis.
%
% AXISTIGHT(H,P,'x') - as above but for the 'x' axis.
% AXISTIGHT(H,P,'+x') - as above but for the positive 'x' axis.
% AXISTIGHT(H,P,'-x') - as above but for the negative 'x' axis.
%
% AXISTIGHT(H,P,'x','y') - as above but for the 'x' and 'y' axes.
%                           Similarly for 'z'.
%
% Any combination of 'x', 'y', and/or 'z' in any order is permissible.
% Defaults for the first two options can be specified with "[]".
%
% Will Robertson
% 2010-2011
%
% Copyright and licence information appended.

if nargin < 1 || isempty(H), H = gca; end
if nargin < 2 || isempty(P), P = 0.05; end
if isempty(varargin), varargin = {'y'}; end

axis(H,'tight');

for ii = 1:length(varargin)
  switch varargin{ii}
    case 'x'
      set_tight_axis('xlim');
    case 'y'
      set_tight_axis('ylim');
    case 'z'
      set_tight_axis('zlim');
    case '+x'
      set_tight_positive('xlim');
    case '+y'
      set_tight_positive('ylim');
    case '+z'
      set_tight_positive('zlim');
    case '-x'
      set_tight_negative('xlim');
    case '-y'
      set_tight_negative('ylim');
    case '-z'
      set_tight_negative('zlim');
    otherwise
      error('Only ''x'' or ''y'' or ''z'' axes allowed.')
  end
end

  function set_tight_axis(limname)

    lim = get(H,limname);
    lim_range = lim(2)-lim(1);
    lim = [lim(1)-P*lim_range lim(2)+P*lim_range];
    set(H,limname,lim);

  end

  function set_tight_positive(limname)

    lim = get(H,limname);
    lim_range = lim(2)-lim(1);
    lim = [lim(1) lim(2)+P*lim_range];
    set(H,limname,lim);

  end

  function set_tight_negative(limname)

    lim = get(H,limname);
    lim_range = lim(2)-lim(1);
    lim = [lim(1)-P*lim_range lim(2)];
    set(H,limname,lim);

  end

end

% Copyright (c) 2010-2011 Will Robertson, wspr 81 at gmail dot com
% All rights reserved.
%
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
