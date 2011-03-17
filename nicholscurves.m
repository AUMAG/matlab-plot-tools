function nicholscurves(varargin)
%% plots M and N circles on a nichols plot

p = inputParser;
p.addOptional('labelsize',10);
p.parse(varargin{:});

MN_fontsize = p.Results.labelsize;

%% N circles

nichols_N_u = @(r,T) -0.5 + sqrt((r.^2+1)./(4*r.^2)).*cos(T);
nichols_N_v = @(r,T) 1./(2*r) + sqrt((r.^2+1)./(4*r.^2)).*sin(T);

nichols_n_u = @(N,T) nichols_N_u(tan(N),T);
nichols_n_v = @(N,T) nichols_N_v(tan(N),T);

nichols_n_p = @(N,T) ...
  180/pi*unwrap(angle( ...
    nichols_n_u(pi/180*N,T) +1i*nichols_n_v(pi/180*N,T) ...
  ));

nichols_n_m = @(N,T) ...
  20*log10(abs( ...
    nichols_n_u(pi/180*N,T) +1i*nichols_n_v(pi/180*N,T) ...
  ));

Ncircles = [-90:20:90];

Npoint = @(r) -sign(r).*acos(1./sqrt(1+ 1./tan(r).^2));

Nbranch_angles = Npoint(Ncircles*pi/180);

ll = 0.5;

for ii = 1:length(Ncircles)
  TT = [
    fliplr(...
      logspace(...
        log10(pi+Nbranch_angles(ii)),...
        log10(2*pi+Nbranch_angles(ii)-1e-10),...
        1000 ...
      )...
    ) ...
    logspace(...
      log10(3*pi+Nbranch_angles(ii)),...
      log10(2*pi+Nbranch_angles(ii)+1e-10),...
      1000 ...
    )...
    ];
  plot( nichols_n_p(Ncircles(ii),TT), nichols_n_m(Ncircles(ii),TT) ,...
    'color', 0.9*[1 1 1],...
    'linewidth',ll)
end

% labels

LL = 1.99*pi;
for nn = Ncircles(Ncircles < 0 & Ncircles > -90)
  text( nichols_n_p(nn,LL), nichols_n_m(nn,LL) , ...
    [num2str(nn),'°'],...
    'UserData',['matlabfrag:','\fboxsep=0pt\colorbox{white}{$\,',num2str(nn),'$\textdegree}'], ...
    'FontSize', MN_fontsize,...
    'horizontalalignment','center',...
    'Interpreter','none')
end

LL = 1.99*pi;
for nn = Ncircles(Ncircles >= 0 & Ncircles < 90)
  text( nichols_n_p(nn,LL)-360, nichols_n_m(nn,LL) , ...
    [num2str(nn),'°'],...
    'UserData',['matlabfrag:','\fboxsep=0pt\colorbox{white}{$\,',num2str(nn),'$\textdegree}'], ...
    'FontSize', MN_fontsize,...
    'horizontalalignment','center',...
    'Interpreter','none')
end

LL = [-85.3 -76 -64 -55 -35 -20 -13]*pi/180;
ii = 0;
for nn = Ncircles
  ii = ii+1;
  text( nn-180, -30 , ...
    [num2str(nn),'°'],...
    'UserData',['matlabfrag:','\fboxsep=0pt\colorbox{white}{$\,',num2str(nn),'$\textdegree}'], ...
    'FontSize', MN_fontsize,...
    'horizontalalignment','center',...
    'Interpreter','none')
end

%% M circles

nichols_u = @(r,T) -(r.^2./(-1 + r.^2)) + (r.*cos(T))./(-1 + r.^2);
nichols_v = @(r,T) (r.*sin(T))./(-1 + r.^2);

nichols_p = @(N,T) 180/pi*unwrap(angle( nichols_u(N,T) +1i*nichols_v(N,T) ));
nichols_pn = @(N,T) 180/pi*(angle( nichols_u(N,T) +1i*nichols_v(N,T) ));
nichols_m = @(N,T) 20*log10( abs(nichols_u(N,T) +1i*nichols_v(N,T)) );

Mcircles_n = [-0.5 -1 -3 -6 -10 -20 -40 -60];
Mcircles_p = [12 6 3 1 0.5];

Ncol = length(Mcircles_n)+length(Mcircles_p);
hsv = ones(Ncol,3);
hsv(:,1) = ((1:Ncol)-1)'/Ncol;
hsv(:,2) = 0.5;
hsv(:,3) = 0.8;
rgb = hsv2rgb(hsv);

TT = linspace(-pi,pi,500);
NN = 10.^(Mcircles_p/20);
ii = 0;
for nn = NN
  ii = ii+1;
  plot( nichols_p(nn,TT), nichols_m(nn,TT) , 'color', rgb(ii,:),'linewidth',ll)
  plot( 360+nichols_p(nn,TT), nichols_m(nn,TT) , 'color', rgb(ii,:),'linewidth',ll)
  plot( -360+nichols_p(nn,TT), nichols_m(nn,TT) , 'color', rgb(ii,:),'linewidth',ll)
  LL = -pi;
  text( nichols_p(nn,LL), nichols_m(nn,LL) , ...
    [num2str(20*log10(nn)),'dB'],...
    'UserData',['matlabfrag:','\fboxsep=0pt\colorbox{white}{$',num2str(20*log10(nn)),'$\,dB}'],...
    'FontSize', MN_fontsize,...
    'horizontalalignment','center',...
    'Interpreter','none')
end

ll = 0.5;
TT = linspace(0.0001,2*pi,500);
NN = 10.^(Mcircles_n/20);
jj = ii;
for nn = NN
  ii = ii+1;
  plot( nichols_pn(nn,TT), nichols_m(nn,TT) , 'color', rgb(ii,:),'linewidth',ll)
  plot( -360+nichols_pn(nn,TT), nichols_m(nn,TT) , 'color', rgb(ii,:),'linewidth',ll)
  plot( 360+nichols_pn(nn,TT), nichols_m(nn,TT) , 'color', rgb(ii,:),'linewidth',ll)
  plot( -720+nichols_pn(nn,TT), nichols_m(nn,TT) , 'color', rgb(ii,:),'linewidth',ll)
  LL = 165*pi/180;
  text( nichols_pn(nn,LL), nichols_m(nn,LL) , ...
    [num2str(20*log10(nn)),'dB'],...
    'UserData',['matlabfrag:','\fboxsep=0pt\colorbox{white}{$\,',num2str(20*log10(nn)),'$\,dB}'], ...
    'FontSize', MN_fontsize,...
    'Interpreter','none')
end

%% rescale axis

xticks = get(gca,'xtick');
xticks_rounded = round(xticks/180)*180; 
set(gca,'xtick',xticks_rounded(1):45:xticks_rounded(end))

end