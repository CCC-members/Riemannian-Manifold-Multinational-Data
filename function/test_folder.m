function test_folder(name,cat)
if nargin<2
 [p,n,e] = fileparts(name);
    if isempty(e)
        cat='dir';
    else
        cat='file';
    end
end



if strcmp(cat,'dir')
    if(~exist(name,'dir'))
        mkdir(name);
    end
else
    [p,n,e] = fileparts(name);
    if(~exist(p,'dir'))
        mkdir(p);
    end
end



