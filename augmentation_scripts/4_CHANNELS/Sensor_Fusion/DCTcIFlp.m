function[imf] = DCTcIFlp(im1,im2,k)
% inputs: im1 & im2 are images to be fused
% output: imf is the fused image
%By Dr. VPS Naidu
% transform RGB image into PCA space
[pcaim1,V1] = rgb2pca(im1);
[pcaim2,V2] = rgb2pca(im2);
im1pca1 = pcaim1(:,:,1);
im1pca2 = pcaim1(:,:,2);
im1pca3 = pcaim1(:,:,3);
im2pca1 = pcaim2(:,:,1);
im2pca2 = pcaim2(:,:,2);
im2pca3 = pcaim2(:,:,3);

%fusion of chrominance components
imfpca2 = (im1pca2+im2pca2)/2;
imfpca3 = (im1pca3+im2pca3)/2;

% fusion of luminance components
imfpca1 = DCTIFlp(im1pca1,im2pca1,k);
imfpca(:,:,1) = imfpca1;
imfpca(:,:,2) = imfpca2;
imfpca(:,:,3) = imfpca3;

% transform PCA space to RGB space
imf1 = pca2rgb(imfpca,V1);
imf2 = pca2rgb(imfpca,V2);
imf = 0.5*(imf1 + imf2); % fused image