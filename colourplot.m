
function [ RGBOUT ] = colourplot( series )
%COLOURPLOT Make colourful, nice-looking plots
%  This function takes the current figure and splits up the HSV colour
%  space by the number of data lines there are. These colours are then
%  converted to RGB and applied to the plot.
%
%  An optional argument specifies the number of times to use the
%  colour space: e.g., colourplot(2) will turn, in a graph with 6 data
%  series, the first and fourth plot blue, the second and fifth
%  green, and the third and six red. The divisor of the number of
%  plots and the number of colour space repetitions must be an
%  integer.
%
%  RGBOUT = colourplot( ... ) will simply return the colours that
%  would be used, but it will NOT attempt to colour the plot.
%

if nargin == 0
  series = 1;
end

ch = findobj(gca,'Type','line','-not','UserData','colourplot:ignore');

Nch = length(ch);
Ncol = Nch/series;
if round(Ncol) ~= Ncol
  % Each set of data series must be the same length to avoid rounding problems!!
  disp(['There are ',num2str(Nch),' data series'])
  error('There must be an integer multiple of specified data series in the figure.')
end

hsv = ones(Ncol,3);
hsv(:,1) = ([1:Ncol]-1)'/Ncol;
hsv(:,2) = 0.5;
hsv(:,3) = 0.8;

rgb = hsv2rgb(hsv);

if nargout == 0
  for ii = 1:Nch
    if isequal(get(ch(ii),'type'),'line')
      set(ch(ii),'color',rgb(mod(ii-1,Ncol)+1,:))
    end
    if isequal(get(ch(ii),'type'),'surface')
      set(ch(ii),'FaceColor',rgb(mod(ii-1,Ncol)+1,:),'EdgeColor',rgb(mod(ii-1,Ncol)+1,:))
    end
  end
else
  RGBOUT = rgb;
end
