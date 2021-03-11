clear; close all
% addpath('H:\_VIP\Work\BVA\qeeg_tools')

% pathd = 'H:\Datos\DBThomas\2021\';
pathd='H:\PROCESSED_DATA\QMEEG\MultiData8Country994\China\';
x = dir([pathd '*']);
ii = find(ismember({x.name}, {'.', '..'}));
x(ii) = [];
files = {};
for k=1:length(x)
    y = dir([pathd x(k).name '\*.mat']);
    files = vertcat(files, strcat([pathd x(k).name '\'], {y.name})');
end

% pathd = 'H:\Datos\DBThomas\2021\CUMCH_0.39Hz\';
% y = dir([pathd '\*.mat']);
% files = strcat(pathd, {y.name})';


apply_gsf = 0;
avr_apply = 0;

Sps = []; paises = {}; sexes = [];
for k=1:length(files)
    clear data_struct
    load(files{k});
    if mod(k,20) == 1, fprintf('%d  ', k);disp(files{k}); end
    ages(k) = data_struct.age;
    paises{k} = data_struct.pais;
    sexes(k) = char(data_struct.sex);
    if (data_struct.sex == 'm' || data_struct.sex == 'w')
        if data_struct.sex == 'm', data_struct.sex = 'M';
        else data_struct.sex = 'F'; end
        save(files{k}, 'data_struct');
    end
    if isempty(paises{k}), paises{k} = 'None'; end
    ii = find(data_struct.Spec_freqrange <= 19.15);
    Sp = data_struct.Spec(:,1:length(ii));
    
    if apply_gsf
        pg = gsf(Sp);
        Sp = Sp ./ pg;
    end
    if isempty(Sps)
        Sps = Sp;
    else
        Sps(:,1:length(ii),size(Sps,3)+1) = Sp;
    end
end
fprintf('\n');
usex = unique(sexes);
disp(usex);
% mx = squeeze(max(max(Sps(:,35:end,:))));
% hl = min(mx)+3*std(mx);
% figure; plot(1:length(mx),mx, [1 length(mx)], [hl hl]);
% ii = find(mx == max(mx));
% files(ii)

ii = find(ismember(paises, {'BE'}));
paises(ii) = {'SwissTh'};
ii = find(ismember(paises, {'Switzerland'}));
paises(ii) = {'SwissNic'};
ii = find(ismember(paises, {'NY_1'    'NY_2'    'NY_3'}));
paises(ii) = {'NY'};
ii = find(ismember(paises, {'CHBMP'    'CU'    'CU90'}));
paises(ii) = {'CUBA'};
up = unique(paises); st = {}; ipaises = [];
for k=1:length(up),
    ii = find(ismember(paises, up{k}));
    st{k} = [up{k} ':(' num2str(length(ii)) ')'];
    ipaises(ii) = k;
end
figure; plot(ages, ipaises, '*'); set(gcf, 'color', 'w');
title(['Age Distribution by Datasets (' num2str(length(ipaises)) ') subjects'], 'Fontsize', 16);
set(gca, 'fontsize', 14, 'ytick', 1:length(up), 'yticklabel', st);
xlabel('Age (years)', 'fontsize', 14);
ylim([0 length(up)+1])
xlim([min(ages)-1 max(ages)+1])

ii = find(ages == 1);
if ~isempty(ii), ah = [-1]; na = ages; na(ii) = [];
else
    ah = []; na = ages;
end
ah = [ah round(min(na)):round(max(na))];
% figure; hist(ages(:), ah);
% set(gca, 'ytick', [ 5 10 20 30 40 50], 'ygrid', 'on', 'xtick', [-1 5 10 15 20 30 40 50 60 70 80], 'fontsize', 14);
% xlim([-2 100])
% xlabel('Age (Years)', 'fontsize', 16)
% ylabel('Number of Subjects', 'fontsize', 16)
% title('Age Distribution of the whole sample', 'fontsize', 16)

clear X N
for k=1:length(up)
    ii = find(ismember(paises, up(k)));
    [N(k,:), X(k,:)] = hist(ages(ii), ah);
end
 figure; %maximize;
cols = [[0,0,1]; [0.3,0.3,0.3]; [1,0,0]; [0,1,0]; [1,1,0]; [0,1,1]; [1,0,1]; [ 0.5 0.5 0.5]; [0.5 0 0.5]];
hh = bar(X(1,:), N', 0.9, 'stacked', 'LineWidth', 0.8, 'Edgecolor', [0 0 0])
for k=1:length(hh), set(hh(k), 'Edgecolor', [0 0 0], 'facecolor', cols(k,:)); end
set(gca, 'ytick', [ 5 10 20 30 40 50], 'ygrid', 'on', 'xtick', [-1 5 10 15 20 30 40 50 60 70 80], 'fontsize', 14);
xlim([-2 100])
xlabel('Age (Years)', 'fontsize', 16)
ylabel('Number of Subjects', 'fontsize', 16)
title('Age Distribution of the whole sample by countries', 'fontsize', 16)
legend(up)

clear NS
for k=1:length(up)
    for h=1:length(usex)
        ii = find(ismember(paises, up(k)) & ismember(sexes, usex(h)));
        NS(k,h) = length(ii);
    end
end
figure; %maximize;
bar(NS)
legend({'Female' 'Male' 'Unknown'})
xlabel('Countries', 'fontsize', 16)
ylabel('Number of Subjects', 'fontsize', 16)
title('Number of Subjects by Sex by Countries', 'fontsize', 16)
set(gca, 'xtick', 1:length(up), 'xticklabel', up, 'fontsize', 14);

% figure; maximize;
% hh = histogram2(ages, ipaises, ah, 1:5, 'EdgeColor','none', 'FaceColor','flat','DisplayStyle','tile','ShowEmptyBins','off'); colormap(pink); view(2); colorbar

% ii = find(ages > 20 & ages < 25);
% paises = paises(ii);
% Sps = Sps(:,:,ii);

frange = data_struct.Spec_freqrange(1:size(Sps,2));
for k=1:length(up)
    ii = find(ismember(paises, up{k}));
    mn = mean(Sps(:,:,ii),3); st = std(Sps(:,:,ii),0,3);
    if k == 1
        spmn = mn;
        spstd = mn + st;
        sp = min(Sps(:,:,ii),[],3);
        spstd(:,:, end+1) = log(mn) - log(st);
        sp(:,:, end+1) = max(Sps(:,:,ii),[],3);
    else
        spmn(:,:, end+1) = mn;
        spstd(:,:, end+1) = log(mn) + log(st);
        sp(:,:, end+1) = min(Sps(:,:,ii),[],3);
        spstd(:,:, end+1) = mn - st;
        sp(:,:, end+1) = max(Sps(:,:,ii),[],3);
    end
end

global mycolors
cols = [[0,0,1]; [0,0,0]; [1,0,0]; [0,1,0]; [1,1,0]; [0,1,1]; [1,0,1]; [ 0.5 0.5 0.5]; [0.5 0 0.5]];
mycolors(1:2:size(cols,1)*2, :) = cols; mycolors(2:2:size(cols,1)*2, :) = cols;
figure; %maximize;
plotsignals(frange, '', [0], [4 8 12], 0, 0, log(permute(sp,[2 1 3])));
mysubplot(5,5,3); text(0.05, 0.8, ['Min and Max values of the Spectra' char(10) 'of each dataset'], 'fontsize', 8); axis off
mysubplot(5,5,25);
for k=1:length(up)
    y = (k-1)*0.2+0.1;
    plot([0.3 0.5], [y y], 'color', mycolors(2*(k-1)+1,:), 'linewidth', 2); hold on
    text(0.52, y, up{k});
end
axis off
axis([0 1 0.05 2*(length(up)/10)+0.05]);


figure;% maximize;
plotsignals(frange, '', [0], [4 8 12], 0, 0, log(permute(spmn,[2 1 3])));
mysubplot(5,5,3); text(0.05, 0.9, 'Mean Spectra for each dataset', 'fontsize', 8); axis off
mysubplot(5,5,25);
for k=1:length(up)
    y = (k-1)*0.2+0.1;
    plot([0.3 0.5], [y y], 'color', mycolors(k,:), 'linewidth', 2); hold on
    text(0.52, y, up{k});
end
axis off
axis([0 1 0.05 2*(length(up)/10)+0.05]);

figure; %maximize;
plotsignals(frange, '', [0], [4 8 12], 0, 0, log(permute(Sps,[2 1 3])));
mysubplot(5,5,3); text(0.05, 0.9, 'Individual Spectra of all datasets', 'fontsize', 8); axis off

