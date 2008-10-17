function combinefig(names)
% COMBINEFIG Extract plots from different figures and put them in the
% current one.

new = gcf;

for ff = length(names):-1:1
  
  thisfig = findobj('name',names{ff});
  chaxis = get(get(thisfig,'children'),'children');

  for cc = length(chaxis):-1:1
    fig(get(new,'name'));
    plot(get(chaxis(cc),'xdata'),get(chaxis(cc),'ydata'));
  end

end
