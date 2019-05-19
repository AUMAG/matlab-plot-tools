function savepdf(s)

s = erase(s,'.pdf');
saveas(gcf,[s,'.pdf']);
