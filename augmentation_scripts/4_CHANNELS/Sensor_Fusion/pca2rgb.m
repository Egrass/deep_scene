function RGB = pca2rgb(PCA, V)
% Converting PCA space to RGB space
[M,N,D] = size(PCA);

% change matrix represenation into vector representation
p1 = PCA(:,:,1);
p2 = PCA(:,:,2);
p3 = PCA(:,:,3);
Bvec = cat(2,p1(:),p2(:),p3(:));

% apply transformation
Ivec = Bvec*inv(V);

% change from vector representation to matrix
R = reshape(Ivec(:,1),M,N);
G = reshape(Ivec(:,2),M,N);
B = reshape(Ivec(:,3),M,N);
RGB = cat(3,R,G,B);