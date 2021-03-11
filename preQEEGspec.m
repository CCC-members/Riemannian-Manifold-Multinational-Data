%% ====  quantitative EEG by sepctrum ===========
%1- quality EEG by viewer (Babayan et al., 2019)
%2- save all figures and then good in to crossponding dataset folder, bad in to disqEEGMultiData
% if want to check on online, ture on 'puse'
%%============MinLi Yingwang 03/04/2021=======================================
clear;clc
folderdir='H:\PROCESSED_DATA\QMEEG\MultiData8Country994';
savedir='H:\PROCESSED_DATA\QMEEG\qEEGMultiData8Country';
discdir='H:\PROCESSED_DATA\QMEEG\qEEGMultiData8Country\disqEEGMultiData';
test_folder(savedir);
imgTitle={'MinMax','Mean','Individual'};
countryname={'NY_2','NY_1','Brb2','Switzerland','CU90','CU','CHBMP','BE','China'};
for i=6:length(countryname)
    %     try
    newpath=[savedir,filesep,countryname{i},filesep];
    test_folder(newpath);
    datadir=fullfile(folderdir,countryname{i});
    subjList = dir([datadir, '/*.mat']);              % List all .mat files
    for j=1:size(subjList,1)
        filename=fullfile(datadir, subjList(j).name);
        load(filename,'data_struct');
        ind=floor(31/data_struct.freqres);
        plotQEEGspec(data_struct.Spec(:,1:ind),data_struct.freqrange(1:ind));
        for img=1%:3
            Imagename=[data_struct.name,'_',num2str(img),'.jpg'];
            saveas(img,[newpath,Imagename]);   
            clf;
        end        
    end
    % catch ME
    % end
end