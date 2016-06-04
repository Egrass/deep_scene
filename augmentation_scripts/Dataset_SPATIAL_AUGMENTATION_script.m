clear all;
close all;

IMAGE_DIM=350;
CROP_DIM = 300;
% mean BGR pixel
mean_pix = [104.00698793, 116.66876762, 122.67891434];


aug_num = 25;

%Cityscapes dataset
DIR='dataset/';

files=dir(DIR);

loop=length(files);

%Img=zeros([CROP_DIM CROP_DIM 3 ((loop-2)*aug_num)]);
Img=zeros([CROP_DIM CROP_DIM 3 ((loop-2)*(aug_num))]);

index=0;



DIR2='masks/';

files2=dir(DIR2);

loop2=length(files2);

Seg=zeros([CROP_DIM CROP_DIM 1 ((loop2-2)*(aug_num))]);


%loop first 10
for p=3:loop
    p-2
    
    
    %%%%%%%%%%%%%%%%% augmentation part IMG    %%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
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

        
        %Crop image

        % mean BGR pixel
        mean_pix = [104.00698793, 116.66876762, 122.67891434];

        %tic;
        input_data = CROP(im, mean_pix);
        %toc;

        
          %%%%%%%%%%%%%%%%% augmentation part SEG
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    name2=files2(p).name;
    token2 = strtok(name2,'.');
    
    ss = DIR2;
    PATH = strcat(ss,name2);
    
     MM=load(PATH);
     M=MM.PartMask;    
     M=resizeImage(M,IMAGE_DIM,1); 
    
              
        %tic;
        input_data = CROP_LABEL(M);
        %toc;
        
        
        
        %%%%%%%%%%%%%%%%% augmentation part IMG
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    for i = 1:aug_num
        
            % random scale and angle factor are calculated and given to the
            % augment-functions
             Y = str2double(sprintf('%.2f',(0.5)*rand)); 
             scaleFactor = 0.7 + Y;
            angle = rand*20;
           
            %%%%%%%%%%%%%%%%%%%%%%%%%%%IMG%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            finImage = augment(I, angle, scaleFactor);
            
            augData = single(finImage);
            
            augData=permute(augData, [2 1 3]);
            
            Img(:,:,:,i+(aug_num*index))=augData;
            
            %%%%%%%%%%%%%%%%%%%%%MASK%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            finMask = augment_Mask(M, angle, scaleFactor);
            
            augLabels = single(finMask);
            
            augLabels=permute(augLabels, [2 1 3]);
            
            Seg(:,:,:,i+(aug_num*index))=augLabels;
            
            

    end   
          
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%IMGS%%%%%%%%%%%%%%%%%%%%%%%%%%%
       % for pos=1:11
       %     Img(:,:,:,pos+i+(aug_num*index))=input_data(:,:,:,(pos));
       % end
    
      
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%SEG%%%%%%%%%%%%%%%%%%%%%%%%%
       % for pos=1:11
       %     Seg(:,:,:,pos+i+(aug_num*index))=input_data(:,:,:,(pos));
       % end
        
        
        
        
    
    
           index = index +1;
           % clearvars augData;
           % clearvars augLabels;
        

end
%{
 DIR='masks/';

files=dir(DIR);

loop=length(files);

Seg=zeros([CROP_DIM CROP_DIM 1 ((loop-2)*(aug_num+11))]);

index=0;

for p=3:loop
    p-2
    
    name=files(p).name;
    token = strtok(name,'.');
    
    ss = DIR;
    PATH = strcat(ss,name);
    
     MM=load(PATH);
     M=MM.PartMask;    
     M=resizeImage(M,IMAGE_DIM,1); 
    
              
        %tic;
        input_data = CROP_LABEL(M);
        %toc;

        %create the global vector 
        %for pos=1:11
        %    Seg(:,:,:,pos+(11*index))=input_data(:,:,:,pos);
        %end
        for i = 1:aug_num
        
            % random scale and angle factor are calculated and given to the
            % augment-functions
             Y = str2double(sprintf('%.2f',(0.5)*rand)); 
            scaleFactor = 0.7 + Y;
            angle = rand*20;
            %finImage = augment(I, angle, scaleFactor);
            
            %augData = single(finImage);
            
            finMask = augment_Mask(M, angle, scaleFactor);
            
            augLabels = single(finMask);
            
            augLabels=permute(augLabels, [2 1 3]);
            
            Seg(:,:,:,i+(aug_num*index))=augLabels;

        end   
        
        for pos=(1+aug_num):((1+aug_num+11))
            Seg(:,:,:,pos+(aug_num*index))=input_data(:,:,:,(pos-aug_num));
        end
        
        
        index=index+1;
        
end

%}

%Img is the data structure with the augmented data

 p = randperm(size(Img,4));
 
 labels_caffe=zeros([CROP_DIM CROP_DIM 1 ((loop-2)*(aug_num))]);
 
 for i=1:size(Img,4)
    labels_caffe(:,:,:,i)=Seg(:,:,:,p(i));
 end

 clearvars Seg;
 
 data_caffe=zeros([CROP_DIM CROP_DIM 3  ((loop-2)*(aug_num))]);
  
 for i=1:size(Img,4)
    data_caffe(:,:,:,i)=Img(:,:,:,p(i));
 end

 clearvars Img;
 
 

 %hdf5write( ['TEST.h5'], 'data',ImgSuffle, 'label', SegSuffle);
 createHDF5_smallSets;

