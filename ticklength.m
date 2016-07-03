function ticklength = ticklength(s)
% TICKLENGTH - doubles the tick lengths for the current axis

if nargin < 1
  s = 2;
end

tl = s*get(0,'defaultaxesticklength');
set(gca,'ticklength',tl)

if nargout > 0
  ticklength = tl;
end

end