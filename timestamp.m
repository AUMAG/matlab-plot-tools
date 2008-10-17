function timestamp( str , f )
%TIMESTAMP Time/date stamp
%   Prints a time/date stamp to the screen with a separating line and an
%   optional comment. Suited for "declaring" scripts as they are executed.
%
%Examples:
%   No arguments:
%   |   >> timestamp
%   |    ____________________
%   |    16-Apr-2007 20:32:04
%
%   First argument (string):
%   |    >> timestamp('wspr')
%   |    ___________________________
%   |    16-Apr-2007 20:32:42 ~ wspr
%
%   Second argument (`datestr` specifier):
%   |    >> timestamp('wspr',31)
%   |    __________________________
%   |    2007-04-16 20:35:27 ~ wspr
%
%   (first argument can be left empty)
%   |    >> timestamp('',31)
%   |    ___________________
%   |    2007-04-16 20:35:27

if nargin < 1
  str = [];
end
if nargin < 2
  f = 0;
end

timedate_string = datestr(now,f);
if ~isempty(str)
  timedate_string = [timedate_string,' ~ ',str];
end

% Print separating line (same length as the string)
disp(repmat('_',[1 length(timedate_string)])); 

% Print datestamp:
disp(timedate_string);