clear all;
close all;

IMAGE_DIM=350;
CROP_DIM = 300;
% mean BGR pixel
mean_pix = [104.00698793, 116.66876762, 122.67891434];
%mean_pix = [50.0303, 187.9911, 173.9015];

FINAL_DIM = [300 300];

aug_num = 100;

DIR='images/';

files=dir(DIR);

loop=length(files);

%Img=zeros([CROP_DIM CROP_DIM 3 ((loop-2)*aug_num)]);
%Img=zeros([CROP_DIM CROP_DIM 3 ((loop-2)*(aug_num))]);
Img=zeros([FINAL_DIM(2) FINAL_DIM(1) 3 ((round((loop-2))*(aug_num)))]);

index=0;



DIR2='masks/';

files2=dir(DIR2);

loop2=length(files2);

%Seg=zeros([CROP_DIM CROP_DIM 1 ((loop2-2)*(aug_num))]);
Seg=zeros([FINAL_DIM(2) FINAL_DIM(1) 1 ((round((loop-2))*(aug_num)))]);


%loop first 10
for p=3:round(loop)
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
        %im = single(im);
        imm=im;
        imm = single(imm);
        I=zeros(size(imm));
        im2=zeros(size(imm));
        %RGB to BGR
        im2 = imm(:,:,[3 2 1]);
        for c = 1:3
            I(:, :, c) = im2(:, :, c) - mean_pix(c);
        end


        I = imresize(I, FINAL_DIM);

              
        
           %%%%%%%%%%%%%%%%% augmentation part SEG
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    name2=files2(p).name;
    token2 = strtok(name2,'.');
    
    ss = DIR2;
    PATH = strcat(ss,name2);
    
    ext='.png';
    %PATH = strcat(PATH,ext);
    
    mask=imread(PATH);
    M = imresize(mask, FINAL_DIM,'nearest');
    M = RGB2Mask(M);
    
    % MM=load(PATH);
    % M=MM.MM.PartMask;    
    % M=imresize(M,FINAL_DIM,'nearest'); 
    
        
        
        
        %%%%%%%%%%%%%%%%% augmentation part IMG
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    for i = 1:aug_num
        
        x = rand*3;
       
        
         if(x<=2)
        
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
        
       
        if(x>2)
                %%%%%%%%%%%%%%%%%%%IMG%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                II = imresize(im, [FINAL_DIM(1) FINAL_DIM(2)]);
                finImage = augment_color_contrast(II);
                
                finImage = single(finImage);
                for c = 1:3
                    finImage(:, :, c) = finImage(:, :, c) - mean_pix(c);
                end
                augData2 = finImage;

                
                augData=permute(augData2, [2 1 3]);
                Img(:,:,:,i+(aug_num*index))=augData;
                
                %%%%%%%%%%%%%%%%%%%%%%MASK%%%%%%%%%%%%%%%%%%%%%%%%%%
                MM = imresize(M, [FINAL_DIM(1) FINAL_DIM(2)], 'nearest');
                augLabels = single(MM);
                augLabels=permute(augLabels, [2 1 3]);
                Seg(:,:,:,i+(aug_num*index))=augLabels;
                
        end
        
        
        %%IMAGES
        %    augData = single(I);
            
        %    augData=permute(augData, [2 1 3]);
            
        %    Img(:,:,:,i+(aug_num*index))=augData;
        %%MASKS
            
        %    augLabels = single(M);
            
        %    augLabels=permute(augLabels, [2 1 3]);
            
        %    Seg(:,:,:,i+(aug_num*index))=augLabels;
        
        

    end   
           index = index +1;
           % clearvars augData;
           % clearvars augLabels;
   
end


%Img is the data structure with the augmented data

 p = randperm(size(Img,4));
 
 labels_caffe=zeros([FINAL_DIM(2) FINAL_DIM(1) 1 ((round((loop-2))*(aug_num)))]);

 for i=1:size(Img,4)
    labels_caffe(:,:,:,i)=Seg(:,:,:,p(i));
 end

 clearvars Seg;
 
 data_caffe=zeros([FINAL_DIM(2) FINAL_DIM(1) 3  ((round((loop-2))*(aug_num)))]);
  
 for i=1:size(Img,4)
    data_caffe(:,:,:,i)=Img(:,:,:,p(i));
 end

 clearvars Img;
 
 

 %hdf5write( ['TEST.h5'], 'data',ImgSuffle, 'label', SegSuffle);
 createHDF5_smallSets4;
