function [p, xi, yi, zi, DT] = delaunay_surf(x,y,z,varargin)

p = inputParser;
addRequired(p,'x');
addRequired(p,'y');
addRequired(p,'z');
addOptional(p,'N',4);
addOptional(p,'plot',true);
addOptional(p,'maxpoints',5000); %% don't generate more than this many points for one plot
parse(p,x,y,z,varargin{:})

xi = x; yi = y; zi = z;

for ii = 1:p.Results.N

 DT = delaunayTriangulation([xi(:), yi(:)]);
 x2 = mean(xi(DT.ConnectivityList),2);
 y2 = mean(yi(DT.ConnectivityList),2);

 if numel(xi)+numel(x2) > p.Results.maxpoints
   warning('Too many points; reducing interpolation to N=%i.',ii-1)
   break
 end

 [ti,bc] = pointLocation(DT,[x2(:) y2(:)]);
 triVals = zi(DT(ti,:));
 z2 = dot(bc',triVals')';

 xi = [xi(:); x2(:)];
 yi = [yi(:); y2(:)];
 zi = [zi(:); z2(:)];

end

DT = delaunayTriangulation([xi(:), yi(:)]);

if p.Results.plot
  p = trisurf(DT.ConnectivityList,xi,yi,zi);
end