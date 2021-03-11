function MH=aveReference(M)
[Nchan,~,Nf]=size(M);
MH=zeros(Nchan-1,Nchan-1,Nf);
H=eye(Nchan)-ones(Nchan)/Nchan;    %Apply average reference
MH=pagemtimes(pagemtimes(H,M),'none',H,'ctranspose');
MH=MH(1:Nchan-1,1:Nchan-1,:); %delete one row and one column
end