function nicholscurves(varargin)
%%NICHOLSCURVES
% Add M-circles and N-circles to the current figure (assumed to be a nichols chart)
%
% Parameters:
% 'phasecyc'  = [-a b] corresponds to [-360a 360b] on phase axis. Default is [-1 0].
% 'phaseinc'  = CL phase increment for N-circles. Default is 30.
% 'labelsize' = Text size of M- and N-circle labels. Default is 10.
% 'gainarray' = Row vector containing the values of gain for which to plot
%               M-circles. An entry of 0 is ignored as this causes Inf to
%               appear. Default is [12 6 3 1 0.5 -0.5 -1 -3 -6 -10 -20 -40 -60].
% 'linewidth' = Thickness of the lines on the plot. Default is 1.
% 'frag'      = true or false; whether to use matlabfrab to print labels.
% 'mlabels'   = true or false; whether to label the M circles.
% 'nlabels'   = true or false; whether to label the N circles.
% 'msat'      = "saturation" of M-circles, 0 (grey) to 1 (bright).

% Copyright 2011 Will Robertson
% Copyright 2011 Philipp Allgeuer

%% Process input arguments

% Parse input arguments
p=inputParser;
p.addParameter('phasecyc',[-1 0],@(x)(isnumeric(x)&&(numel(x)==2)&&(round(x(1))<round(x(2)))));
p.addParameter('phaseinc',30,@(x)(isnumeric(x)&&(x>0)));
p.addParameter('labelsize',10,@(x)(isnumeric(x)&&(x>=4)));
p.addParameter('gainarray',[12 6 3 1 0.5 -0.5 -1 -3 -6 -10 -20 -40 -60],@(x)(isnumeric(x)));
p.addParameter('linewidth',1,@(x)(isnumeric(x)&&(x>=0.1)&&(x<=5)));
p.addParameter('frag',false);
p.addParameter('nlabels',true);
p.addParameter('mlabels',true);
p.addParameter('mlabelangle',[210 210]);
p.addParameter('axislabels',true);
p.addParameter('msat',0.5);
p.parse(varargin{:});

% Save parsed arguments
PCyc=round(p.Results.phasecyc);
PInc=p.Results.phaseinc;
LSize=p.Results.labelsize;
Gains=p.Results.gainarray;
LWidth=p.Results.linewidth;
frag_bool = p.Results.frag;
nlabels_bool = p.Results.nlabels;
mlabels_bool = p.Results.mlabels;
mlabelangle  = p.Results.mlabelangle;
circles_sat  = p.Results.msat;

if numel(mlabelangle) == 2
  mlabelangle = nan(size(Gains));
  mlabelangle(Gains>0) = p.Results.mlabelangle(1);
  mlabelangle(Gains<0) = p.Results.mlabelangle(2);
else
  assert(numel(mlabelangle)==numel(Gains));
end
  
% Freeze current plot
hold_bool = false;
if ishold
  hold_bool = true;
else
  hold on;
end

if p.Results.axislabels
   xlabel('Phase, deg.')
   ylabel('Amplitude, dB')
end

%% Draw M-circles

% Define equations that determine the M-circles
RadM=@(m) abs(m/(m^2-1));
CentreM=@(m) m^2/(1-m^2);
Ny=@(mdb,t) CentreM(10^(mdb/20))+RadM(10^(mdb/20)).*(cosd(t)+1i.*sind(t));
Ni_Ph=@(mdb,t) rad2deg(unwrap(angle(Ny(mdb,t))));
Ni_Ga=@(mdb,t) 20.*log10(abs(Ny(mdb,t)));

% Generate the colour space
CalcRgb=@(mdb) hsv2rgb([((mdb-min(Gains))/(max(Gains)-min(Gains)))^1.5 circles_sat 0.8]);

if frag_bool
  user_data = @(nn) ['matlabfrag:',...
                     '\fboxsep=1pt\colorbox{white}{$\,',...
                     num2str(nn),...
                     '$\,dB}'];
else
  user_data = @(nn) '';
end



% Apply M-circle equations and plot the result
c = 0;
for i=Gains
  c = c+1;
    PVals=Ni_Ph(i,0:0.1:360);
    GVals=Ni_Ga(i,0:0.1:360);
    for j=PCyc(1):PCyc(2)-1
      plot(PVals+j*360,GVals,'color',CalcRgb(i),'linewidth',LWidth);
      if mlabels_bool
        mla = mlabelangle(c);
        if mla > 180
          offset = (j+1)*360;
        else
          offset = j*360;
        end
        TextX=Ni_Ph(i,mla)+offset;
        TextY=Ni_Ga(i,mla);
        text(TextX,TextY,[num2str(i) 'dB'],...
          'FontSize',LSize,..., ...
          'horizontalalignment','center',...
          'UserData',user_data(i));
      end
    end
end

%% Draw N-circles

% Define equations that determine the N-circles
RadN=@(phi) 1./(2.*abs(sind(phi)));
Ny_Re=@(phi,t) -0.5+RadN(phi).*cosd(t+mod(phi,180)-90);
Ny_Im=@(phi,t) 1./(2.*tand(phi))+RadN(phi).*sind(t+mod(phi,180)-90);
Ni_Ph=@(phi,t) rad2deg(unwrap(angle(Ny_Re(phi,t)+1i*Ny_Im(phi,t))))+360*floor(phi/360);
Ni_Ga=@(phi,t) 20.*log10(abs(Ny_Re(phi,t)+1i*Ny_Im(phi,t)));
Ni_La=@(phase) 0.090*10^(phase/60);

% Create input vectors
Phi=PCyc(1)*360:PInc:PCyc(2)*360;
T1=logspace(-4,log10(180),300);
T2=[T1 360-fliplr(T1)];

if frag_bool
  user_data = @(nn) ['matlabfrag:',...
                     '\fboxsep=0pt\colorbox{white}{$\,',...
                     num2str(nn),...
                     '$\textdegree}'];
else
  user_data = @(nn) '';
end

% Apply N-circle equations and plot the result
for i=Phi
    if abs(sind(i))<1e-3
        plot([i i],[-110,25],'color',0.75*[1 1 1],'linewidth',LWidth);
        if cosd(i)>0
            TextX=i;
            TextY=1;
        else
            TextX=i;
            TextY=-46.5;
        end
    else
        plot(Ni_Ph(i,T2),Ni_Ga(i,T2),'color',0.75*[1 1 1],'linewidth',LWidth);
        Offset=i-180*floor(i/180);
        if(sign(sind(i))==1)
            TextX=Ni_Ph(i,Ni_La(180-Offset));
            TextY=Ni_Ga(i,Ni_La(180-Offset));
        else
            TextX=Ni_Ph(i,-Ni_La(Offset))+360;
            TextY=Ni_Ga(i,-Ni_La(Offset));
        end
    end
    if nlabels_bool
      text(TextX,TextY,[num2str(i),'°'],...
        'FontSize',LSize,...
        'horizontalalignment','center',...
        'UserData',user_data(i));
    end
end

%% Finish up

% Want a box:
set(gca,'box','on')

% Modify ticks to nicely cover the required range of phases
set(gca,'xtick',PCyc(1)*360:30:PCyc(2)*360);
axis([PCyc(1)*360-15 PCyc(2)*360+15 -80 30]);

% Unfreeze current plot
if ~hold_bool, hold off; end

end
