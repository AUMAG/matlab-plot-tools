%% Examples of ticksfit

figure(1); clf
plot([1 2 3 4 5],[-0.15 0.9 1.1 0.5 1.5])
ticksfit


figure(2); clf
plot([1 2 3 4 5],[-0.15 0.9 1.1 0.5 1.5])
ticksfit(0.2)


figure(3); clf
plot([1 2 3 4 5],[0 0.9 1.1 0.5 1.5])
ticksfit


figure(4); clf
plot([1 2 3 4 5],[0 0.9 1.1 0.5 1.5])
ticksfit(0.5)


figure(5); clf
plot([1 2 3 4 5],[0 0.9 1.1 0.5 1.5])
ticksfit(0.5,'x','y')



figure(6); clf
plot([1 2 3 4 5],[0 0.9 1.1 0.5 1.5])
ticksfit(0.5,'+x','+y')
