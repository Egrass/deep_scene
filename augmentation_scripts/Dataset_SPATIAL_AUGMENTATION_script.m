%% image augmentation including?
%% jinglu.sherry@gmail.com

%% step 1, crop the images
%% step 2. calculate mean

clear all; close all; clc

addpath(genpath('/home/luj/code/deepscene')

% image dimention
IMAGE_DIM=350;
CROP_DIM = 300;


% dataset and mask directory
DIR_DATASET = 'dataset/';
DIR_MASK = 'masks/';

% Read files names in the folder
origin_imgs = dir(DIR_DATASET);
mask_imgs = dir(DIR_MASK);

% get number of images
imgs_num = length(origin_imgs);
mask_num = length(mask_imgs);

% mean BGR pixel
% mean_pix = [104.00698793, 116.66876762, 122.67891434];
mean_pix = calculate_mean_pix(DIR_DATASET,origin_imgs,IMAGE_DIM,CROP_DIM);

% aug_mum?
aug_num = 25;

Img = zeros([CROP_DIM CROP_DIM 3 ((imgs_num)*(aug_num))]);
Seg = zeros([CROP_DIM CROP_DIM 1 ((mask_num)*(aug_num))]);


index=0;

for p = 1:imgs_num
        
    %%%%%%%%%%%%%%%%% augmentation part IMG %%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % get the path and name of the image
    origin_img_name = origin_imgs(p).name; 
    PATH_org_img = strcat(DIR_DATASET,origin_img_name);
    
    % READ IMAGE 
    % origin_img = imread('img/2008_000026.jpg');
    origin_img = imread(PATH_org_img);
    origin_img = imresize(origin_img, [CROP_DIM CROP_DIM],'bilinear')
 
    origin_img = single(origin_img);
    image = zeros(size(origin_img));
    
    
    % img_BGR:BGR image
    img_BGR = zeros(size(origin_img));
    disp(size(origin_img)
    
    % RGB to BGR
    img_BGR = origin_img(:,:,[3 2 1]);
    
    for c = 1:3
        image(:, :, c) = img_BGR(:, :, c) - mean_pix(c);
    end
    
        
    %%%%%%%%%%%%%%%%% augmentation part SEG
    
    mask_img_name = mask_imgs(p).name;
    PATH_mask_img = strcat(DIR_MASK,mask_img_name);
    
    
    mask_img = imread(PATH_mask_img);
    mask_img = imresize(mask_img, [CROP_DIM CROP_DIM],'bilinear');
    mask_img = RGB2Mask(mask_img); 
                    
        
    %%%%%%%%%%%%%%%%% augmentation part IMG---scaling and rotating
       
    for i = 1:aug_num
    
        x = rand*8;
        
        %% scaling and rotating
        
        if(x>=0 && x<=2)
        
            % random scale and angle factor are calculated and given to the
	    % augment-functions
	    Y = str2double(sprintf('%.2f',(0.5)*rand)); 
	    scaleFactor = 0.7 + Y;
	    angle = rand*20;
           
	    %% img augmentation
	    img_aug = augment(image, angle, scaleFactor);            
	    img_aug = single(img_aug);            
	    img_aug=permute(img_aug, [2 1 3]);            
	    Img(:,:,:,i+(aug_num*index))=img_aug;
        
	    %% mask augmentatin
	    labels_aug = augment_Mask(mask_img, angle, scaleFactor);            
	    labels_aug = single(labels_aug);            
	    labels_aug = permute(labels_aug, [2 1 3]);            
	    Seg(:,:,:,i+(aug_num*index))=labels_aug;
	end
	 
	if (x>2 && x<=3)
	
	    %% color contrast
	    img_aug = augment_color_contrast(image);
            img_aug = single(img_aug);            
	    img_aug = permute(img_aug, [2 1 3]);            
	    Img(:,:,:,i+(aug_num*index))=img_aug;
                
            % mask
	    labels_aug = single(mask_img);            
	    labels_aug = permute(labels_aug, [2 1 3]);            
	    Seg(:,:,:,i+(aug_num*index)) = labels_aug;
        end
         
        if(x>3 && x<=4)
        
            %% Horizontal Flipping             
            %figure;
            %imshow(image);
            %figure;
            %imagesc(mask_img);
                                
            img_aug = fliplr(image);     
            img_aug = single(img_aug);                
            img_aug = permute(img_aug, [2 1 3]);
            Img(:,:,:,i+(aug_num*index)) = img_aug;
                           
            % mask 
            labels_aug = fliplr(mask_img);
            labels_aug = single(labels_aug);
            labels_aug = permute(labels_aug, [2 1 3]);
            Seg(:,:,:,i+(aug_num*index)) = labels_aug;

            %figure;
            %imshow(img_aug);
            %figure;
            %imagesc(labels_aug);       
        end
         
        if(x>4 && x<=5)
        
	    %% Skewing 
	    %% Need to use the image without mean subtraction        
            shx = rand*0.1;
            shy = rand*0.1;
            img_aug = skewing(img_BGR,shx,shy);            
            img_aug = single(img_aug);

            % SUBTRACT MEAN  
            for c = 1:3
                img_aug(:, :, c) = img_aug(:, :, c) - mean_pix(c);
            end

            img_aug = permute(img_aug, [2 1 3]);
            Img(:,:,:,i+(aug_num*index)) = img_aug;           
            
            %% segmentation 
            labels_aug = skewing(mask_img,shx,shy);           
            labels_aug = single(labels_aug);
            labels_aug = permute(labels_aug, [2 1 3]);
            Seg(:,:,:,i+(aug_num*index)) = labels_aug;
            % figure, imshow(img_aug);
            % figure, imagesc(labels_aug); 
        end
         
        if(x>5 && x<=6)
        
	    %% Vignetting 
            scaleFactor = rand*0.6;
            img_aug = Vignetting(img_BGR,scaleFactor);
            img_aug = single(img_aug);

            % SUBTRACT MEAN 
            for c = 1:3
                img_aug(:, :, c) = img_aug(:, :, c) - mean_pix(c);
            end

            img_aug = permute(img_aug, [2 1 3]);
            Img(:,:,:,i+(aug_num*index)) = img_aug;
                
                
            %% mask                    
            labels_aug = single(mask_img);
            labels_aug = permute(labels_aug, [2 1 3]);
            Seg(:,:,:,i+(aug_num*index)) = labels_aug;
            % figure, imshow(img_aug);
            % figure, imagesc(labels_aug); 
        end


        if(x>6 && x<=8)
             
             [images] = CROP(img_BGR);
             [masks] = CROP_LABEL(mask_img);
             %for t=1:size(images,4)
             %      figure;
             %      imshow(images(:,:,:,t));
             %      figure;
             %      imagesc(masks(:,:,:,t));           
             %end
             %size(images)
             %size(masks)
             
            selector = ceil(rand*11);             
            img_aug = images(:,:,:,selector);
            img_aug = single(img_aug);
             
            for c = 1:3
                img_aug(:, :, c) = img_aug(:, :, c) - mean_pix(c);
            end             
             
            %augData=permute(augData2, [2 1 3]);?
            Img(:,:,:,i+(aug_num*index)) = img_aug;

            %% mask
            labels_aug = masks(:,:,:,selector);
            labels_aug = single(labels_aug);
            %augLabels=permute(augLabels, [2 1 3]);
            Seg(:,:,:,i+(aug_num*index)) = labels_aug;       
        end
         
                            
    end                
             
    index = index +1;
    % clearvars augData;
    % clearvars augLabels;       
end

%Img is the data structure with the augmented data

p = randperm(size(Img,4));
 
labels_caffe = zeros([CROP_DIM CROP_DIM 1 ((imgs_num)*(aug_num))]);
 
for i=1:size(Img,4)
    labels_caffe(:,:,:,i) = Seg(:,:,:,p(i));
end

clearvars Seg;
 
data_caffe = zeros([CROP_DIM CROP_DIM 3  ((imgs_num)*(aug_num))]);
  
for i = 1:size(Img,4)
    data_caffe(:,:,:,i) = Img(:,:,:,p(i));
end

clearvars Img; 
 
%hdf5write( ['TEST.h5'], 'data',ImgSuffle, 'label', SegSuffle);
%createHDF5_smallSets;
disp('Start ....... ');
%%create small datasets

ppp=100

NETNAME = 'v33';
nFiles = 20;

%why not ceil 
nAugmentedImages = round((round((imgs_num)/6)*(aug_num))/nFiles);
%nAugmentedImages=1000;

index = 1;
for fi = 1:nFiles
  
    if(index+nAugmentedImages > (round((imgs_num)/6)*(aug_num)))
	indexBegin = index;
	indexEnd = (round((imgs_num)/6)*(aug_num)); 
    else
	indexBegin = index 
	indexEnd = index+nAugmentedImages
    end
    index = index+nAugmentedImages
  
    clearvars img_aug;
    clearvars labels_aug;
      
  
    img_aug   = single(data_caffe(:,:,:,indexBegin:indexEnd));
    labels_aug = single(labels_caffe(:,:,:,indexBegin:indexEnd));
    %augLabels2 = single(labels_caffe2(:,:,:,indexBegin:indexEnd));
    %augLabels3 = single(labels_caffe3(:,:,:,indexBegin:indexEnd));
  
    
    disp('Creating randomly transformed image ');


    hdf5write( ['aug_deformed_' NETNAME '_file' num2str(fi) '.h5'], ...
                         'data', img_aug, ...
                         'label', labels_aug);
                       %  'label1', augLabels2, ...
                       %  'label2', augLabels3);
    
  
end
 

system(['echo aug_deformed_' NETNAME '_file*.h5 > aug_deformed_' ...
                NETNAME '.txt'])
