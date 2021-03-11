%%===================preorocess =================
%1- transfer eeg reference to agerage +H
%2- global scale factorization of each subject +HS
%3- Hibert-Smith regurization Schneider-Luftman & Walden, 2015  +HSR
%4- quality EEG by viewer (Babayan et al., 2019)
%%======MinLi Rigel 3/04/2021
function[ MHSR]=averageGlobalScaleReg(M,NTapers)
[Nf]=size(M,3);
MH=aveReference(M);
MHSR=zeros(size(MH));
[MHS] = gsf(MH);
for i=1:Nf
    MHSR(:,:,i)=regularizeHS(MHS(:,:,i), NTapers);
end
end
