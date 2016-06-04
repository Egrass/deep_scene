clear all;
close all;

IMAGE_DIM=350;
CROP_DIM = 300;
% mean BGR pixel
mean_pix = [104.00698793, 116.66876762, 122.67891434];


DIR='images/';

files=dir(DIR);

loop=length(files);

Img=zeros([CROP_DIM CROP_DIM 3 ((loop-2)*11)]);

index=0;

%loop first 10
for p=3:loop
    p-2
    
    name=files(p).name;
    token = strtok(name,'.');
    
    ss = DIR;
    PATH = strcat(ss,name);
    
    im=imread(PATH);

        %READ IMAGE 
        %im=imread('img/2008_000026.jpg');
        im = single(im);
        I=zeros(size(im));
        im2=zeros(size(im));
        %RGB to BGR
        im2 = im(:,:,[3 2 1]);
        for c = 1:3
            I(:, :, c) = im2(:, :, c) - mean_pix(c);
        end


        I = imresize(I, [IMAGE_DIM IMAGE_DIM]);

        I2 = flipdim(I ,2);           %# horizontal flip

        %figure;
        %subplot(1,2,1), imshow(I)
        %subplot(1,2,2), imshow(I2)

        %Crop image

        % mean BGR pixel
        mean_pix = [104.00698793, 116.66876762, 122.67891434];

        %tic;
        input_data = CROP(im, mean_pix);
        %toc;

        %create the global vector 
        for pos=1:11
            Img(:,:,:,pos+(11*index))=input_data(:,:,:,pos);
        end
        index=index+1;
       

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%For the segmentation masks%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

DIR='masks/';

files=dir(DIR);

loop=length(files);

Seg=zeros([CROP_DIM CROP_DIM 1 ((loop-2)*11)]);

index=0;

%loop first 10
for p=3:loop
    p-2
   
    name=files(p).name;
    token = strtok(name,'.');
    
    ss = DIR;
    PATH = strcat(ss,name);
    
    im=imread(PATH);
    
    %im=imread('masks/claasside15.jpg');
    PartMAsk = RGB2Mask(im);
    %imagesc(PartMAsk)
    
    %READ IMAGE 
        %im=imread('img/2008_000026.jpg');
        %PartMAsk = single(PartMAsk);
        
        I = imresize(PartMAsk, [IMAGE_DIM IMAGE_DIM],'nearest');

        %I2 = flipdim(I ,2);           %# horizontal flip

        %figure;
        %subplot(1,2,1), imshow(I)
        %subplot(1,2,2), imshow(I2)

        %Crop image

        % mean BGR pixel
        %mean_pix = [104.00698793, 116.66876762, 122.67891434];

        %tic;
        input_data = CROP_LABEL(I);
        %toc;

        %create the global vector 
        for pos=1:11
            Seg(:,:,:,pos+(11*index))=input_data(:,:,:,pos);
        end
        index=index+1;
  
       
end


%Img is the data structure with the augmented data

 p = randperm(size(Img,4));
 
 labels_caffe=zeros([CROP_DIM CROP_DIM 1 ((loop-2)*11)]);
 
 for i=1:size(Img,4)
    labels_caffe(:,:,:,i)=Seg(:,:,:,p(i));
 end

 clearvars Seg;
 
 data_caffe=zeros([CROP_DIM CROP_DIM 3  ((loop-2)*11)]);
  
 for i=1:size(Img,4)
    data_caffe(:,:,:,i)=Img(:,:,:,p(i));
 end

 clearvars Img;
 
 

 %hdf5write( ['TEST.h5'], 'data',ImgSuffle, 'label', SegSuffle);
 createHDF5_smallSets;




