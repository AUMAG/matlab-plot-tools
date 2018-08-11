function draw_coord_frame(origin,varargin)
%% draw_coord_frame( origin , <opts> )
%
% Plots a 3D coordinate system origin.
% By default is aligned with the right-handed XYZ global coordinate system.
% Use optional arguments to customise:
%
% ------------------------------------------------------------------------
% KEY           VALUE    DESCRIPTION
% ------------------------------------------------------------------------
% 'rotate'      [u v w]  Rotate coordinates 'u' degrees around the X-axis,
%                                           'v' degrees around the Y-axis,
%                                           'w' degrees around the Z-axis.
% 'axes'        ['x' and/or 'y' and/or 'z']
%                        Only plot axes listed
% 'labels'      [true/false]
%                        Whether to print coordinate system labels
% 'index'       str      String index on labels (default str='1')
% ------------------------------------------------------------------------
% 'length'      L        Length of axes lines
% 'headlength'  R        Length of arrow head
% 'arrowangle'  a        Angle of arrowhead "quills"
% 'linecolour'  [R G B]  Red-Green-Blue colour of axis lines
% 'headcolour'  [R G B]  Red-Green-Blue colour of arrowhead faces
% 'headopacity' C        Opacity of arrowhead faces
% ------------------------------------------------------------------------

%% Parse inputs:

p = inputParser;
p.addRequired('origin');
p.addOptional('rotate',[0 0 0]);
p.addOptional('length',0.05);
p.addOptional('headlength',0.02);
p.addOptional('arrowangle',25);
p.addOptional('index','1');
p.addOptional('labels',true);
p.addOptional('axes','xyz');
p.addParameter('linecolour',[0 0 0]);
p.addParameter('headcolour',0.5*[1 1 1]);
p.addParameter('headopacity',0.9);
p.parse(origin,varargin{:})

O      = p.Results.origin;
al     = p.Results.length;
hl     = p.Results.headlength;
ang    = p.Results.arrowangle;

r    = p.Results.rotate;
ni   = p.Results.index;
ecol = p.Results.linecolour;
col  = p.Results.headcolour;
opac = p.Results.headopacity;
labels_bool = p.Results.labels;
plot_axes = p.Results.axes;

% Constant that should actually be optional input
nameshift = 0.01;

%% Definition of a single axis (X)
%
% This is rotated to plot the other two in Y and Z.

ax = [al; 0; 0]; % axis end point
pxy = ax - hl*[cosd(ang);  sind(ang); 0]; % one point of the arrowhead
pxz = ax - hl*[cosd(ang); 0;  sind(ang)]; % one point of the other arrowhead
head1 = [ax pxy pxy.*[1; -1; 1]]; % arrowhead points in XY plane
head2 = [ax pxz pxz.*[1; 1; -1]]; % arrowhead points in XZ plane

% Rotation matrix (note inverse order of application)
if numel(r) == 3
  R = Rz(r(3))*Ry(r(2))*Rx(r(1));
elseif all(size(r)==[3,3])
  R = r;
else
  error('Rotation must be 3 cardan angles or a 3x3 rotation matrix.')
end

%% Plot

hold on

if strcmp(plot_axes,'xyz')
  if labels_bool
    text(-nameshift+O(1),-nameshift+O(2),O(3),['O_{',ni,'}']);
  end
end

for s = plot_axes
  switch s
    case 'x'
      plot_one_coord(O,R*ax,        R*head1,        R*head2,        ['x_{',ni,'}'],[2*nameshift; 0; 0])
    case 'y'
      plot_one_coord(O,R*Rz(+90)*ax,R*Rz(+90)*head1,R*Rz(+90)*head2,['y_{',ni,'}'],[0; nameshift; 0])
    case 'z'
      plot_one_coord(O,R*Ry(-90)*ax,R*Ry(-90)*head1,R*Ry(-90)*head2,['z_{',ni,'}'],[0; 0; nameshift])
  end
end

%% Nested functions

  function plot_one_coord(O,a,head1,head2,name,ns)
    if labels_bool
      text(ns(1)+O(1)+a(1),ns(2)+O(2)+a(2),ns(3)+O(3)+a(3),name);
    end
    
    plot3(O(1)+[0 a(1)],O(2)+[0 a(2)],O(3)+[0 a(3)],'color',ecol);
    patch(O(1)+head1(1,:),O(2)+head1(2,:),O(3)+head1(3,:),ecol,'facealpha',opac,'facecolor',col);
    patch(O(1)+head2(1,:),O(2)+head2(2,:),O(3)+head2(3,:),ecol,'facealpha',opac,'facecolor',col);
  end

end

%% Rotation matrices
%
% These could all be anonymous functions if we wanted.

function R = Rz(t)
R = [cosd(t) -sind(t) 0;
     sind(t)  cosd(t) 0;
     0        0       1];
end

function R = Ry(t)
R = [ cosd(t) 0  sind(t);
      0       1  0;
     -sind(t) 0  cosd(t)];
end

function R = Rx(t)
R = [1 0        0      ;
     0 cosd(t) -sind(t);
     0 sind(t)  cosd(t)];
end

% assert( all( Rx(90)*[0;1;0]==[ 0; 0; 1]) )
% assert( all( Rz(90)*[0;1;0]==[-1; 0; 0]) )
% assert( all( Ry(90)*[1;0;0]==[ 0; 0;-1]) )
% assert( all( Rz(90)*[1;0;0]==[ 0; 1; 0]) )
% assert( all( Rx(90)*[0;0;1]==[ 0;-1; 0]) )
% assert( all( Ry(90)*[0;0;1]==[ 1; 0; 0]) )