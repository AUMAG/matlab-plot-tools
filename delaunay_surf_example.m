%% 2D interpolated image of scattered data
%
% This example file first looks at regular interpolation using "gridded"
% data. The second section shows how to plot regular scattered data using
% triplot and Delaunay Triangulation. Finally, interpolation using
% delaunay_surf shows what the code is all about.

%% Some random data to plot
%
% This code assumes that you're trying to plot a 3D surface of values over
% a set of non-uniform (x,y) data points.

N = 15;
rng(13);
x = randn(1,N); % X & Y coords
y = randn(1,N);
z = randn(1,N); % "value" at each (x,y) coordinate


%% Plotting scattered data
%
% This section shows how to plot scattered data using default Matlab commands.
% The unshaded colourmapping is very poor at representing coarse grids, and
% the interpolated shading shows edge artifacts where the surface changes quickly.

N = 15;
rng(13);
x = randn(1,N); % X & Y coords
y = randn(1,N);
z = randn(1,N); % "value" at each (x,y) coordinate

figure(99);
subplot(2,2,1); cla; hold on
trisurf(delaunay(x,y),x,y,z)
view(3)

subplot(2,2,2); cla; hold on
p = trisurf(delaunay(x,y),x,y,z);
view(2)
set(p,'edgecolor','black')

subplot(2,2,3); cla; hold on
p = trisurf(delaunay(x,y),x,y,z);
shading interp
view(3)
set(p,'EdgeColor','black','linewidth',0.1)% delete this line to remove the lines

subplot(2,2,4); cla; hold on
p = trisurf(delaunay(x,y),x,y,z);
shading interp
view(2)


%% Delaunay Interpolation
%
% This shows the basics of the interpolation. The midpoint of each Delaunay
% triangle is used to calculate a new interpolated point.

figure(102); clf; hold on

p1 = delaunay_surf(x,y,z,'N',1);
p2 = delaunay_surf(x,y,z,'N',0);
set(p1,'facecolor','none','edgecolor','red')
set(p2,'facecolor','none','linewidth',2)
view(2)


%% Three examples of interpolation.
%
% * The first shows the 3D surface with black edges to demonstrate the
%   effect of the interpolation.
%
% * The second shows the same view from the top and without the edge lines;
%   generally a better way to visualise such data.
%
% * The third shows the 2D view with interpolated shading, which
%   demonstrates the improvements over the default interpolated shading.

nx = 2; ny = 2;

figure(100);
for ii = 1:nx*ny
  
  subplot(ny,nx,ii); cla; hold on
  p = delaunay_surf(x,y,z,'N',ii-1);
  title(['Interp N = ',num2str(ii-1)])
  set(p,'EdgeColor','black','linewidth',0.1)% delete this line to remove the lines
  view(3)

end

figure(101);
for ii = 1:nx*ny
  
  subplot(ny,nx,ii); cla; hold on
  p = delaunay_surf(x,y,z,'N',ii-1);
  title(['Interp N = ',num2str(ii-1)])
  set(p,'edgecolor','none')
  view(2)

end

figure(102);
for ii = 1:nx*ny
  
  subplot(ny,nx,ii); cla; hold on
  p = delaunay_surf(x,y,z,'N',ii-1);
  title(['Interp N = ',num2str(ii-1)])
  shading interp
  view(2)

end


%% Examples of plotting gridded data, with and without interpolation
%
% This section is just to make some nice examples for comparison purposes.

[x,y,z] = peaks(5);
figure(98);
subplot(3,3,1); cla; hold on
surf(x,y,z);
axis tight
view(3)
zlabel('Original data')

subplot(3,3,2); cla; hold on
surf(x,y,z);
view(2)

subplot(3,3,3); cla; hold on
p = surf(x,y,z);
view(2)
set(p,'edgecolor','none')

subplot(3,3,4); cla; hold on
p = surf(x,y,z);
axis tight
shading interp
view(3)
set(p,'EdgeColor','black','linewidth',0.1)% delete this line to remove the lines
zlabel('Interpolated shading')

subplot(3,3,5); cla; hold on
p = surf(x,y,z);
shading interp
view(2)
set(p,'EdgeColor','black','linewidth',0.1)% delete this line to remove the lines

subplot(3,3,6); cla; hold on
p = surf(x,y,z);
shading interp
view(2)

F = griddedInterpolant(x',y',z');
[x2,y2] = ndgrid(linspace(-3,3,20));

subplot(3,3,7); cla; hold on
surf(x2,y2,F(x2,y2))
view(3); axis tight
zlabel('Interpolated data')

subplot(3,3,8); cla; hold on
surf(x2,y2,F(x2,y2))
view(2);

subplot(3,3,9); cla; hold on
p = surf(x2,y2,F(x2,y2));
view(2);
set(p,'edgecolor','none')

