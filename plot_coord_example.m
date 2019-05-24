%% plot_coord example

figure(1); clf; hold on

plot_coord([0;0;0])

axis equal
view(3)

%% Using Euler angles

plot_coord(0.1*[-1;1;1],'rotate',[10 20 30],...
  'headcolour','green','labelaxes',true)

%% Using rotation matrix

AX = [ 1;1;0];
AY = [-1;1;0];
AZ = [ 0;0;1];

plot_coord(0.1*[1;1;1],'rotate',[AX,AY,AZ],...
  'headlength',0.03,...
  'headcolour','red',...
  'arrowangle',45,...
  'linewidth',2)


%% Labels

AX = [ 1;1;0];
AY = [-1;1;0];
AZ = [ 0;0;1];

plot_coord(-0.1*[1;1;1],'rotate',[AX,AY,AZ],...
  'headcolour','blue','labels',true,'index','B')
