%% Example of the COLOURSCALE function

%% Example of different number of plots

% number of plots to demo:
M = 3;
N = 3;

% points per graph:
p = 20;

% colour: (0-100)
HUE = 10;
CHROMA = 60;

% linewidths:
LW = [0.5 4]; % more exaggerated than default

figure(1)
for m = 1:M
  for n = 1:N
    c = N*(m-1)+n; % count from 1:N*M
    subplot(M,N,c); cla;
    xx = linspace(0,1,p);
    yy = repmat(1:c,[p 1])+rand(p,c);
    plot(xx,yy,'linewidth',5)
    colourscale('hue',HUE,'chroma',CHROMA,'linewidth',LW);
    title(['Number of lines: ',num2str(c)])
    axis tight
  end
end

%% Example across colours

% number of plots to demo:
M = 4;
N = 4;

% lines per graph:
l = 6;

% points per line:
p = 20;

hrange = linspace(0,100,M*N+1);
hrange(end) = [];

figure(2)
for m = 1:M
  for n = 1:N
    c = N*(m-1)+n; % count from 1:N*M
    subplot(M,N,c); cla;
    xx = linspace(0,1,p);
    yy = repmat(1:l,[p 1])+rand(p,l);
    plot(xx,yy,'linewidth',2)
    colourscale('hue',hrange(c),'lumin',[20 90]);
    title(['H=',num2str(hrange(c))])
    axis tight
  end
end


%% Example of different number of plots


% number of plots to demo:
M = 1;
N = 1;

% lines per graph:
l = 28;

% points per line:
p = 20;

hrange = linspace(0,100,M*N+1);
hrange(end) = [];

figure(2)
m = 1;
n = 1;

c = N*(m-1)+n; % count from 1:N*M
subplot(M,N,c); cla;
xx = linspace(0,1,p);
yy = repmat(1:l,[p 1])+rand(p,l);
plot(xx,yy,'linewidth',2)

x=[1:7;1:7;1:7;1:7];

rgb = colourscale('hue',hrange(c),'lumin',[20 90],'repeat',4);

title(['H=',num2str(hrange(c))])
axis tight

