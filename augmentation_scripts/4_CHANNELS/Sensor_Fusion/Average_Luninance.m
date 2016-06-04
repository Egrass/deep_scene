clear all;
close all;


rgbImage = imread('b137-653_Clipped.jpg');
im2 = imread('b137-653.png');



rgbImage = imresize(rgbImage, [600 600]);
im2 = imresize(im2, [600 600]);

YCBCR = rgb2ycbcr(rgbImage);

figure;
imshow(YCBCR);

im2=im2(:,:,3);
figure;
imshow(im2);

New=zeros(size(im2,1),size(im2,2));
New=uint8(New)

for i=1:size(im2,1)
   for j=1:size(im2,2)
     average=round((YCBCR(i,j,1) + im2(i,j))/2);
     New(i,j)=average;
   end
end

YCBCR_aux=YCBCR;
YCBCR(:,:,1)=New;

RGB = ycbcr2rgb(YCBCR);

figure;
imshow(RGB);

%%%% Try only change the luminance%%%%%%%%%
YCBCR_aux(:,:,1)=im2;
figure;
imshow(YCBCR_aux);

figure;
imshow(rgbImage);




