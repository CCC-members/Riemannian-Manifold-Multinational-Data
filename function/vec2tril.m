function Atrl=vec2tril(A)
[n,m]=size(A);  % 
for i=1:m
% n=(-1+sqrt(1+8*length(A)))/2 ;
a=(1+sqrt(1+8*n))/2 ; %%
AA=zeros(a);
ind=find(tril(ones(a),-1));
AA(ind)=A(:,i);
Atrl(:,:,i)=AA;
end
% AA=AA'