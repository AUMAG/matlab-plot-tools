function epscombine( eps1 , eps2 , writefile )
% epscombine( eps1 , eps2 , epsout )
%   Reads EPS files EPS1 and EPS2 and combines them into a
%   single EPS file that is saved as EPSOUT.
%
% epscombine( eps1 , eps2 )
%   Default output filename is 'combined.eps'.
%
% This function is useful when generating 3D or transparent figures that
% require Matlab's OpenGL renderer and high-quality results are desired.
% This renderer will not output vector axes or text labels.
%
% The EXPORTFIG function can be used to output separate EPS files of the
% graphic and the axes which can subsequently be combined with this
% package.
%
%
% Please report bugs and feature requests for
% this package at the development repository:
%  <http://github.com/wspr/matlabpkg/>
%
% EPSCOMBINE  v0.2  2009/22/06  Will Robertson
% Licence appended.

%% Input parsing
if nargin == 2
  writefile = 'combined.eps';
elseif nargin ~= 3
  error('Wrong number of inputs! You need, e.g., epscombine( ''axes.eps'' , ''graph.eps'' , ''write.eps'' )')
end

%% First EPS file analysis
% Find the location in the first EPS file that is just before the
% beginning of the first object. Save the line number for later.

fid = fopen(eps1);
text1 = textscan(fid,'%s','delimiter','\n');
fclose(fid);

for line = 1:length(text1{:})
  tmp = [char(text1{1}(line)),'              '];
  if isequal(tmp(1:14),'%%EndPageSetup')
    inserthere = line;
    break
  end
end

%% Second EPS file analysis
% Find where the object is defined in the second EPS file. Save
% the line numbers where it begins and ends. Assume that the
% commenting delimiters occur only once in the file...

fid = fopen(eps2);
text2 = textscan(fid,'%s','delimiter','\n');
fclose(fid);

for line = 1:length(text2{:})
  tmp = [char(text2{1}(line)),'             '];
  if isequal(tmp(1:13),'%%BeginObject')
    beginobject = line;
    break
  end
end

for line = beginobject:length(text2{:})
  tmp = [char(text2{1}(line)),'             '];
  if isequal(tmp(1:11),'%%EndObject')
    endobject = line;
    break
  end
end

%% Creation of the third EPS file
% Create a new file by slotting in the object data from the second file
% into the location found in the first file. Save this to the
% output file line by line.
%
% Note the manual 'gr' insertion is required to unrotate the coordinate
% system due to a small bug in Matlab's EPS output driver.

newfile = [text1{1}(1:inserthere);...
           {''};...
           text2{1}(beginobject:endobject);...
           {'gr'};...
           {''};...
           text1{1}(inserthere+1:end)];

writefid = fopen(writefile,'wt');
for line = 1:length(newfile)
  fprintf(writefid,'%s\n',char(newfile{line}));
end
fclose(writefid);

return

% Copyright (c) 2005-2009, Will Robertson, wspr 81 at gmail dot com
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
