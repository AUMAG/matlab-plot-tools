function printsimulink(mdl,filename,varargin)
% it's ridiculous the syntax in here is so clumsy

open(mdl)
saveas(get_param(gcs,'Handle'),filename,varargin{:})


