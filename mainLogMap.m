%% ====main Riemann mapping of cross-spectrum matrix===========    
%1- group data by Manifolds of single frequencies for all subjects    
%2- calculate Riemann mean
%3- logMap form manifold to Eculiden sapce  Pennec et al., 2006
folderdir='H:\PROCESSED_DATA\QMEEG\qEEGMultiData8Country';
savedir='H:\PROCESSED_DATA\QMEEG\ManifoldMap';
countryname={'NY_3','NY_2','NY_1','Brb2','Switzerland','CU90','CU','CHBMP','BE','Germany','China'};
k=1;
for i=1:length(countryname)
    newpath=[savedir,filesep];
    test_folder(newpath);
    datadir=fullfile(folderdir,countryname{i});
    subjList = dir([datadir, '/*.mat']);              % List all .mat files
    for j=1:size(subjList,1)
        filename=fullfile(datadir, subjList(j).name);
        load(filename,'data_struct');     
        fCrossMHS(:,:,k,:)=data_struct.CrossMHS;
       k=k+1;
    end
end
%% manifold mapping of each freq point
for i = 1:zise(fCrossMHS,4) % for each independent frequency   
    vecmapM{i} = vecRieMap(fCrossMHS(:,:,:,i)); %Calculate the Riemannian Mean and do the mapping to the tangent space
end
   