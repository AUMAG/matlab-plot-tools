

M = 3;
N = 3;
c = 0;
p = 10;

H = 0.41;

for m = 1:N
  for n = 1:M
    c = c+1
    subplot(M,N,c); cla;
    xx = linspace(0,1,p)
    yy = repmat(1:c,[p 1])+rand(p,c)
    plot(xx,yy,'linewidth',2)
    colourscaleplot(H);
    title([num2str(c)])
  end
end
