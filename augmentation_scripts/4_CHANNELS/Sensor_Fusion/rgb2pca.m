function [PCA, V] = rgb2pca(RGB)
% Converting RGB space to PCA space
% from matrix representation to vector
r = RGB(:,:,1); 
g = RGB(:,:,2);
b = RGB(:,:,3);
[M, N, D] = size(RGB);
Ivec = cat(2,r(:),g(:),b(:));

% compute, select & normalize eigenvalues
Vi  = princomp(Ivec);
V = Vi/(sum(Vi(:,1)));

% transformation from RGB to PCA representation
Bvec = Ivec*V;

% from vector representation to matrix
p1 = reshape(Bvec(:,1),M,N);
p2 = reshape(Bvec(:,2),M,N);
p3 = reshape(Bvec(:,3),M,N);
PCA = cat(3,p1, p2, p3);