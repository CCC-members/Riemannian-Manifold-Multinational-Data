function mattril=mat2tril(data,ind)
% examp: 10*10*100, get lower trangle
% Yingwang 5/10/2020
%  ind= 0 is the main diagonal
%  ind > 0 is above the main diagonal
%  ind < 0 is below the main diagonal.
if nargin<2
    ind=0;
end
[r,c,p]=size(data);
switch ind
    case -1
        onesind=tril(ones(r,c),-1);
    case 1
        onesind=tril(ones(r,c),1);
    otherwise
        onesind=tril(ones(r,c));
end
nn=sum(sum(onesind));
onesind=repmat(onesind,[1,1,p]);
% mattril=reshape(data(onesind~=0),[(r*c-r)/2,p]);
mattril=reshape(data(onesind~=0),[nn,p]);
end


