function [] = lessticks(s,h,N)

if nargin < 1
  s = 'x';
end
if nargin < 2
  h = gca;
end
if nargin < 3
  N = 2;
end

ticks = get(gca,[s,'tick']);
Nticks = length(ticks);

ticks = linspace(ticks(1),ticks(end),(Nticks-1)/N+1);

set(h,[s,'tick'],ticks);
