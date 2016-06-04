clear all;
close all;

load tform


rgbImage = imread('b137-653_Clipped.jpg');
im2 = imread('b137-653.png');



rgbImage = imresize(rgbImage, [600 600]);
im2 = imresize(im2, [600 600]);

figure;
imshow(rgbImage);

im2=im2(:,:,3);
figure;
imshow(im2);


% Acquire webcam image
rgbImage = rgbImage;

% Acquire IR image
IR = im2;


% Adjust contrast of IR image
I = imadjust(IR,stretchlim(IR),[]);
figure;
imshow(I);



cmap = colormap(jet);
im2=grs2rgb(I,cmap);

figure;
imshow(im2);

%Roriginal = imref2d(size(I))
%recovered = imwarp(rgbImage,tform,'OutputView',Roriginal);
%imshowpair(I, rgbImage,'blend')

k = 2; %pyramid levels

figure;
imshow(rgbImage,[]);
figure;
imshow(im2,[]);
% fusion will start here
imf = uint8(DCTcIFlp(double(rgbImage),double(im2),k));
%display only
figure;
imshow(imf,[]);     
%imd = imt-imf;
%figure(4)
%imshow(imd,[]);

%XFUS = wfusimg(rgbImage,im2,'sym4',5,'max','max');
%figure;
%imshow(XFUS);

