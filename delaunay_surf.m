function [p, xi, yi, zi] = delaunay_surf(x,y,z,varargin)
%% DELAUNAY_SURF  Plot (x,y,z) surface from scattered points with interpolation
%
% delaunay_surf(X,Y,X) - draws a surface plot of scattered (X,Y,Z) points.
%                        X,Y,Z must each be column or row vectors of equal
%                        size.
%
% Full syntax: [H, Xi, Yi, Zi] = delaunay_surf(X,Y,Z, <opt> )
%
% OUTPUTS:
%           H - handle of surface plot drawn
%  Xi, Yi, Zi - vectors of interpolated points
%
% OPTIONAL INPUTS:
%              'N',<integer> - the number of interpolation iterations
%                              Default: 4
%           'plot',<bool>    - whether to plot the result
%                              (in case iteration only is desired)
%                              Default: true
%      'maxpoints',<integer> - if the interpolation generates more plots points
%                              than this, a warning is produced and the
%                              interpolation halts.
%                              Default: 5000
%
% --
% Will Robertson, 2015.
% Copyright and license appended.

%% Input parsing

p = inputParser;
addRequired(p,'x');
addRequired(p,'y');
addRequired(p,'z');
addOptional(p,'N',4);
addOptional(p,'plot',true);
addOptional(p,'maxpoints',5000); %% don't generate more than this many points for one plot
parse(p,x,y,z,varargin{:})

%% Iteration loop

xi = x; yi = y; zi = z;

for ii = 1:p.Results.N

 DT = delaunay(xi,yi);
 x2 = mean(xi(DT),2);
 y2 = mean(yi(DT),2);
 z2 = mean(zi(DT),2);

 if numel(xi)+numel(x2) > p.Results.maxpoints
   warning('Too many points; reducing interpolation to N=%i.',ii-1)
   break
 end

 xi = [xi(:); x2(:)];
 yi = [yi(:); y2(:)];
 zi = [zi(:); z2(:)];

end

%% Plotting

if p.Results.plot
  p = trisurf(delaunay(xi,yi),xi,yi,zi);
else
  p = -1;
end

%% The end
%
% Copyright (c) 2015 Will Robertson, wspr 81 at gmail dot com
% All rights reserved.
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