function CrossR = regularizeHS(Cross, dF)
    %Input:     Cross (Cross spectral matrix to be regularized)
    %           dF (Degees of freedom)
    %Output:    CrossR (Regularized Cross spectral matrix)

    e = real(eig(Cross));
    e(e<0)=0;
    t = sum(e);
    t1 = sum(e.^2)-(1/dF)*t^2;
    p = size(Cross,1);
    I = eye(p);
    [n,ro] = HS(dF,p,t,t1);
    CrossR = (1-ro).*Cross + (ro*n).*I;

    function [n,ro] = HS(K,p,t,t1)
        %HS
        %    [N,RO] = HS(K,P,T,T1)

        %    This function was generated by the Symbolic Math Toolbox version 8.2.
        %    14-Feb-2021 14:37:40

        t3 = 1.0./p;
        n = t.*t3;
        if nargout > 1
            ro = 1.0./(-K.*t3+K.*1.0./t.^2.*t1+1.0);
        end
    end

end