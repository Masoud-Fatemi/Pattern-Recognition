function [eigvector, eigvalue, elapse] = PCA(data, ReducedDim)

if (~exist('ReducedDim','var'))
   ReducedDim = 0;
end

[nSmp,nFea] = size(data);
if (ReducedDim > nFea) | (ReducedDim <=0)
    ReducedDim = nFea;
end

tmp_T = cputime;


if issparse(data)
    data = full(data);
end
sampleMean = mean(data,1);
data = (data - repmat(sampleMean,nSmp,1));



if nFea/nSmp > 1.0713
    % This is an efficient method which computes the eigvectors of
	% of A*A^T (instead of A^T*A) first, and then convert them back to
	% the eigenvectors of A^T*A.    
    ddata = data*data';
    ddata = max(ddata, ddata');

    dimMatrix = size(ddata,2);
    if dimMatrix > 1000 & ReducedDim < dimMatrix/10  % using eigs to speed up!
        option = struct('disp',0);
        [eigvector, eigvalue] = eigs(ddata,ReducedDim,'la',option);
        eigvalue = diag(eigvalue);
    else
        [eigvector, eigvalue] = eig(ddata);
        eigvalue = diag(eigvalue);

        [junk, index] = sort(-eigvalue);
        eigvalue = eigvalue(index);
        eigvector = eigvector(:, index);
    end

    clear ddata;
    
    maxEigValue = max(abs(eigvalue));
    eigIdx = find(abs(eigvalue)/maxEigValue < 1e-12);
    eigvalue (eigIdx) = [];
    eigvector (:,eigIdx) = [];

    eigvector = data'*eigvector;		% Eigenvectors of A^T*A
	eigvector = eigvector*diag(1./(sum(eigvector.^2).^0.5)); % Normalization
else
    ddata = data'*data;
    ddata = max(ddata, ddata');

    dimMatrix = size(ddata,2);
    if dimMatrix > 1000 & ReducedDim < dimMatrix/10  % using eigs to speed up!
        option = struct('disp',0);
        [eigvector, eigvalue] = eigs(ddata,ReducedDim,'la',option);
        eigvalue = diag(eigvalue);
    else
        [eigvector, eigvalue] = eig(ddata);
        eigvalue = diag(eigvalue);

        [junk, index] = sort(-eigvalue);
        eigvalue = eigvalue(index);
        eigvector = eigvector(:, index);
    end
    
    clear ddata;
    maxEigValue = max(abs(eigvalue));
    eigIdx = find(abs(eigvalue)/maxEigValue < 1e-12);
    eigvalue (eigIdx) = [];
    eigvector (:,eigIdx) = [];
end


if ReducedDim < length(eigvalue)
    eigvalue = eigvalue(1:ReducedDim);
    eigvector = eigvector(:, 1:ReducedDim);
end

elapse = cputime - tmp_T;
