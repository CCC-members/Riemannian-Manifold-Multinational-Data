
% restoredefaultpath
% addpath(genpath('./external/manopt-master/'));
addpath(genpath('./external/mmtoolbox2.3/'));

addpath(genpath('./function/'));


% % Ask user if the path should be saved or not
% fprintf('Manopt was added to Matlab''s path./n');
% response = input('Save path for future Matlab sessions? [Y/N] ', 's');
% if strcmpi(response, 'Y')
%     failed = savepath();
%     if ~failed
%         fprintf('Path saved: no need to call importmanopt next time./n');
%     else
%         fprintf(['Something went wrong.. Perhaps missing permission ' ...
%                  'to write on pathdef.m?/nPath not saved: ' ...
%                  'please re-call importmanopt next time./n']);
%     end
% else
%     fprintf('Path not saved: please re-call importmanopt next time./n');
% end
