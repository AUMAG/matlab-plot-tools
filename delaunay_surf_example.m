%% 2D interpolated image of "temperature" at N points

%% Gridded data:

[x,y,z] = peaks(5);
figure(98);
subplot(3,3,1); cla; hold on
surf(x,y,z);
axis tight
view(3)

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

subplot(3,3,8); cla; hold on
surf(x2,y2,F(x2,y2))
view(2);

subplot(3,3,9); cla; hold on
p = surf(x2,y2,F(x2,y2));
view(2);
set(p,'edgecolor','none')

%% Scattered data:

N = 15;

rng(13);
x = randn(1,N); % X & Y coords
y = randn(1,N);
z = randn(1,N); % "temperatures" at each coordinate

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

%%

figure(100);
nx = 3; ny = 2;
for ii = 1:nx*ny
  
  subplot(ny,nx,ii); cla; hold on
  p = delaunay_surf(x,y,z,'N',ii-1);
  title(['Interp N = ',num2str(ii-1)])
  shading interp
  set(p,'EdgeColor','black','linewidth',0.1)% delete this line to remove the lines
  view(3)

end

figure(101);
nx = 3; ny = 2;
for ii = 1:nx*ny
  
  subplot(ny,nx,ii); cla; hold on
  delaunay_surf(x,y,z,'N',ii-1);
  title(['Interp N = ',num2str(ii-1)])
  shading interp
  view(2)

end

figure(102);
nx = 2; ny = 2;
for ii = 1:nx*ny
  
  subplot(ny,nx,ii); cla; hold on
  delaunay_surf(x,y,z,'N',ii-1);
  title(['Interp N = ',num2str(ii-1)])
  view(2)

end
