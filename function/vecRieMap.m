function vecmapM=vecRieMap(M)

% refM = positive_definite_karcher_mean(M);   %% from Manopt
MM=num2cell(M,[1,2]);
[refM]=karcher(MM{1:end});  % (D.A.Bini and B.Iannazzo,2013)
for i=1:size(M,3)
    mapM(:,:,i)=logm((refM^-0.5)*M(:,:,i)*(refM^-0.5));
end
vecmapM=mat2tril(mapM);
end