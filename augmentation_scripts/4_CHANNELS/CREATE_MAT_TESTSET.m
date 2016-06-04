clear all;
close all;

IMAGE_DIM=300;
CROP_DIM = 300;
% mean BGR pixel
%mean_pix = [104.00698793, 116.66876762, 122.67891434];
mean_pix = [81.1208, 102.1852, 120.4470,  194.739];

FINAL_DIM = [300 300];

aug_num = 1;

DIR='RGB/';

files=dir(DIR);

loop=length(files);

DIR3='nir/';

files3=dir(DIR3);

loop3=length(files3);

%Img=zeros([CROP_DIM CROP_DIM 3 ((loop-2)*aug_num)]);
%Img=zeros([CROP_DIM CROP_DIM 3 ((loop-2)*(aug_num))]);
Img=zeros([FINAL_DIM(2) FINAL_DIM(1) 4 ((round((loop-2))*(aug_num)))]);

index=0;


DIR2='masks2/';

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
    im=imresize(im, FINAL_DIM);
    im=single(im);
    imOriginal=im;

        %READ IMAGE 
        %im=imread('img/2008_000026.jpg');
        %im = single(im);
        imm=im;
        imm = single(imm);
        I=zeros(size(imm));
        im2=zeros(size(imm));
        %RGB to BGR
        im2 = imm(:,:,[3 2 1]);
        %for c = 1:3
        %    I(:, :, c) = im2(:, :, c) - mean_pix(c);
        %end

        im(:,:,1)=im2(:,:,1);
        im(:,:,2)=im2(:,:,2);
        im(:,:,3)=im2(:,:,3);

              
    
    
    %%%%%%%%%%%%%%%%% augmentation part IMG    %%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%% NIR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%NIR
    name=files3(p).name;
    token = strtok(name,'.');
    ss = DIR3;
    PATH = strcat(ss,name);
    
    %im(:,:,2)=imread(PATH);
    A=imread(PATH);
    im(:,:,4)=imresize(A, FINAL_DIM);
        
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     % subtract mean        
        for c = 1:4
            I(:, :, c) = im(:, :, c) - mean_pix(c);
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
        
               
            % random scale and angle factor are calculated and given to the
            % augment-functions
             Y = str2double(sprintf('%.2f',(0.5)*rand)); 
             scaleFactor = 0.7 + Y;
             angle = rand*20;
           
            %%%%%%%%%%%%%%%%%%%%%%%%%%%IMG%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            finImage = augment(I, angle, scaleFactor);
            finImage=I;
            augData = single(finImage);
            
            %augData=permute(augData, [2 1 3]);
            
            Img(:,:,:,i+(aug_num*index))=augData;
            
            
            
            DIRM='test/img/';
            ss = DIRM;
            ext='.mat';
            %%Extract id and number
            name=files(p).name;
            token = strtok(name,'.');
            token = strtok(token,'_');
            PATH = strcat(ss,token);
            PATH = strcat(PATH,ext);
            

            %tt='_';
            %PATH = strcat(PATH,tt);
            %PATH = strcat(PATH,token4);
            %PATH = strcat(PATH,ext);

            save(PATH,'augData'); 
            
            %%%%%%%%%%%%%%%%%%%%%MASK%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            finMask = augment_Mask(M, angle, scaleFactor);
            finMask = M;
            augLabels = single(finMask);
            
            %augLabels=permute(augLabels, [2 1 3 4]);
            
            Seg(:,:,:,i+(aug_num*index))=augLabels;


             DIRM='test/masks/';
            ss = DIRM;
            ext='.mat';
            %%Extract id and number
            name=files(p).name;
            token = strtok(name,'.');
            token = strtok(token,'_');
            PATH = strcat(ss,token);
            PATH = strcat(PATH,ext);
            

            %tt='_';
            %PATH = strcat(PATH,tt);
            %PATH = strcat(PATH,token4);
            %PATH = strcat(PATH,ext);

            save(PATH,'augLabels'); 
        
       
        
       
        
        

    end   
           index = index +1;
           % clearvars augData;
           % clearvars augLabels;
   
end



