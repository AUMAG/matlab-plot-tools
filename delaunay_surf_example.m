%% 2D interpolated image of "temperature" at N points

N = 15;

rng(13);
x = randn(1,N); % X & Y coords
y = randn(1,N);
z = randn(1,N); % "temperatures" at each coordinate

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
