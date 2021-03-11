function plotQEEGspec(Sps,frange)
mn = mean(Sps,3); st = std(Sps,0,3);
spmn = mn;
spstd = mn + st;
sp = min(Sps,[],3);
spstd(:,:, end+1) = log(mn) - log(st);
sp(:,:, end+1) = max(Sps,[],3);

% min-max
cols = [[0,0,1]; [0,0,0]; [1,0,0]; [0,1,0]; [1,1,0]; [0,1,1]; [1,0,1]; [ 0.5 0.5 0.5]; [0.5 0 0.5]];
mycolors(1:2:size(cols,1)*2, :) = cols; mycolors(2:2:size(cols,1)*2, :) = cols;
figure(1); %maximize;
plotsignals(frange, '', [0], [4 8 12], 0, 0, log(permute(sp,[2 1 3])));
mysubplot(5,5,3); text(0.05, 0.8, ['Min and Max values of the Spectra' char(10) 'of each dataset'], 'fontsize', 6); axis off
mysubplot(5,5,25);
axis off
% mean
% figure(2);% maximize;
% plotsignals(frange, '', [0], [4 8 12], 0, 0, log(permute(spmn,[2 1 3])));
% mysubplot(5,5,3); text(0.05, 0.9, 'Mean Spectra for each dataset', 'fontsize', 6); axis off
% mysubplot(5,5,25);
% axis off
% 
% % Individual
% figure(3); %maximize;
% plotsignals(frange, '', [0], [4 8 12], 0, 0, log(permute(Sps,[2 1 3])));
% mysubplot(5,5,3); text(0.05, 0.9, 'Individual Spectra of all datasets', 'fontsize', 6); axis off
end
