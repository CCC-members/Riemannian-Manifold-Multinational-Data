%% ====preprocess cross-spectrum matrix===========
%1- transfer CrossM reference to agerage 
%2- global scale factorization of CrossM of each subject 
%3- Hibert-Smith regurization Schneider-Luftman & Walden, 2015  
%5-save all subjects into one folder information including proprocessed CrossM, age, sex, country, devices 
%%============MinLi Yingwang 03/04/2021=======================================
clear;clc
folderdir='H:\PROCESSED_DATA\QMEEG\qEEGMultiData8Country';
savedir='H:\PROCESSED_DATA\QMEEG\predQEEG';
test_folder(savedir);
countryname={'NY_3','NY_2','NY_1','Brb2','Switzerland','CU90','CU','CHBMP','BE','Germany','China'};
NTapers=20;
for i=1:length(countryname)
    newpath=[savedir,filesep];
    test_folder(newpath);
    datadir=fullfile(folderdir,countryname{i});
    subjList = dir([datadir, '/*.mat']);              % List all .mat files
    for j=1:size(subjList,1)
        filename=fullfile(datadir, subjList(j).name);
        load(filename,'data_struct');
        CrossMHSR=averageGlobalScaleReg(data_struct.CrossM,NTapers);
        data_struct.CrossMHSR=CrossMHSR;
        
        save([newpath,filename],'data_struct') ;
    end
end