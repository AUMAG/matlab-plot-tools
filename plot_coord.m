function plot_coord(origin,varargin)
%% plot_coord( origin , <opts> )
%
% Plots a 3D coordinate system origin.
% By default is aligned with the right-handed XYZ global coordinate system.
% Use optional arguments to customise:
%
% ------------------------------------------------------------------------
% KEY           VALUE    DESCRIPTION
% ------------------------------------------------------------------------
% 'rotate'      [AX AY AZ] 3x3 rotation matrix where AX,AY,AZ are the
%                        vectors of each axis
%            OR 
% 'rotate'      [u v w]  Rotate coordinates 'u' degrees around the 1st axis
%                                           'v' degrees around the 2nd axis
% &                                         'w' degrees around the 3rd axis
% 'order'       [r1 r2 r3] Order of rotation, default [3 2 1] for [Z Y X]
% ------------------------------------------------------------------------
% 'length'      L        Length of axes lines (default 0.05)
% 'headlength'  R        Length of arrow head (default (0.02)
% 'arrowangle'  a        Angle of arrowhead "quills" in degrees (default 25)
% 'linewidth'   w        Linewidth of axes lines and arrow outline (default 0.4)
% ------------------------------------------------------------------------
% 'linecolour'  [R G B]  Red-Green-Blue colour of axis lines
% 'headcolour'  [R G B]  Red-Green-Blue colour of arrowhead faces
% 'headopacity' C        Opacity of arrowhead faces
% ------------------------------------------------------------------------
% 'axes'        ['x' and/or 'y' and/or 'z']
%                        Only plot axes listed (default 'xyz')
% 'labels'      [true/false]
%                        Whether to print coordinate system labels (default false)
% 'labelframe'  [true/false]
%                        Whether to print a "frame" label (default false)
% 'labelaxes'   [true/false]
%                        Whether to print coordinate system labels (default false)
% 'labelshift'  l        Shift label away from end of axis/frame (default 0.01)
% 'index'       str      String index on labels; omit if empty (default '')
% ------------------------------------------------------------------------
% 'fontsize'    Font size for labels (default same as Matlab)
% ------------------------------------------------------------------------

%% Parse inputs:

p = inputParser;
p.addRequired('origin');
p.addOptional('rotate',[0 0 0]);
p.addOptional('order',[1 2 3]);
p.addOptional('length',0.05);
p.addOptional('headlength',0.02);
p.addOptional('arrowangle',25);
p.addOptional('index','');
p.addOptional('labels',false);
p.addOptional('labelframe',false);
p.addOptional('labelaxes',false);
p.addOptional('axes','xyz');
p.addParameter('linecolour',[0 0 0]);
p.addParameter('linewidth',0.4);
p.addParameter('headcolour',0.5*[1 1 1]);
p.addParameter('headopacity',0.9);
p.addParameter('labelshift',0.01);
p.addParameter('fontsize',get(0,'defaulttextfontsize'));
p.parse(origin,varargin{:})

O      = p.Results.origin;
al     = p.Results.length;
hl     = p.Results.headlength;
ang    = p.Results.arrowangle;

r    = p.Results.rotate;
ro   = p.Results.order;
plot_axes = p.Results.axes;

ecol = p.Results.linecolour;
lw   = p.Results.linewidth;

col  = p.Results.headcolour;
opac = p.Results.headopacity;

labels_bool = p.Results.labels;
labelframe_bool = p.Results.labelframe;
labelaxes_bool  = p.Results.labelaxes;
labelshift = p.Results.labelshift;

fontsize = p.Results.fontsize;

%%

if isempty(p.Results.index)
  index_label = '';
else
  index_label = ['_{',p.Results.index,'}'];
end

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
  c = cosd(r);
  s = sind(r);
  RxRyRz(:,:,1) = [1 0 0; 0 c(1) -s(1); 0 s(1) c(1)];
  RxRyRz(:,:,2) = [c(2) 0 s(2); 0 1 0; -s(2) 0 c(2)];
  RxRyRz(:,:,3) = [c(3) -s(3) 0; s(3) c(3) 0; 0 0 1];

  R = RxRyRz(:,:,ro(1))*RxRyRz(:,:,ro(2))*RxRyRz(:,:,ro(3));
elseif all(size(r)==[3,3])
  R = r;
else
  error('Rotation must be 3 cardan angles or a 3x3 rotation matrix.')
end

%% Plot

hold on

if strcmp(plot_axes,'xyz')
  if labels_bool || labelframe_bool
    text(-labelshift+O(1),-labelshift+O(2),-labelshift+O(3),['O',index_label],'fontsize',fontsize);
  end
end

RX = R;
RY = R*[0 -1 0;1 0 0;0 0 1]; % Rz(+90);
RZ = R*[0 0 -1;0 1 0;1 0 0]; % Ry(-90);

for s = plot_axes
  switch s
    case 'x'
      plot_one_coord(O,RX*ax,RX*head1,RX*head2,['x',index_label],[labelshift; 0; 0])
    case 'y'
      plot_one_coord(O,RY*ax,RY*head1,RY*head2,['y',index_label],[0; labelshift; 0])
    case 'z'
      plot_one_coord(O,RZ*ax,RZ*head1,RZ*head2,['z',index_label],[0; 0; labelshift])
  end
end

%% Nested functions

  function plot_one_coord(O,a,head1,head2,name,ns)
    if labels_bool || labelaxes_bool
      text(ns(1)+O(1)+a(1),ns(2)+O(2)+a(2),ns(3)+O(3)+a(3),name,'fontsize',fontsize);
    end

    plot3(O(1)+[0 a(1)],O(2)+[0 a(2)],O(3)+[0 a(3)],'color',ecol,'linewidth',lw);
    patch(O(1)+head1(1,:),O(2)+head1(2,:),O(3)+head1(3,:),ecol,'facealpha',opac,'facecolor',col,'linewidth',lw);
    patch(O(1)+head2(1,:),O(2)+head2(2,:),O(3)+head2(3,:),ecol,'facealpha',opac,'facecolor',col,'linewidth',lw);
  end

end

