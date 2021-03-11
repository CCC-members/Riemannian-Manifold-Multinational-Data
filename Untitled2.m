
clear;clc
%format short
M=10*randn(20,10);
covM=cov(M);
covM=repmat(covM,1,1,50);
tic
[C1,refM1]=Tangent_space(covM);
toc

tic
MM=num2cell(covM,[1,2]);
[refM2]=karcher(MM{1:end}); 
for i=1:size(covM,3)
    mapM(:,:,i)=logm((refM2^-0.5)*covM(:,:,i)*(refM2^-0.5));
end
vecmapM=mat2tril(mapM);
toc

MH=aveReference(M);
%% 
tic
[MS1,factor1]=globalScaleFactor(M);
toc;
tic
[MS2, factor2] = gsf( M );
toc
%the trues is cellfun took a lot time sower than loop
%%
tic
for i=1:size(M,3)
    eigval1(:,i)=eig(M(:,:,i));
end
toc
tic
MM=num2cell(M,[1,2]);
eigval2=cellfun(@eig,MM,'unif',false);
toc
piecentimes(M*(1-ro))



% y = num2cell(M,[1,2]);
% z = cellfun(@eig,y,'unif',false);
% ev3 = cat(1,z{:});