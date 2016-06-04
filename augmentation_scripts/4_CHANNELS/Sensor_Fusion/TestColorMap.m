
clear all;
close all;

im1 = imread('b137-653_Clipped.jpg');
im2 = imread('b137-653.png');

im1 = imresize(im1, [400 400]);
im2 = imresize(im2, [400 400]);


figure;
imshow(im1);

figure;
imshow(im2);

im2=im2(:,:,1);

cmap = colormap(jet);
im3=grs2rgb(im2,cmap);

figure;
imshow(im3);