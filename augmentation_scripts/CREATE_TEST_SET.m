clear all;
close all;

IMAGE_DIM=350;
CROP_DIM = 300;
% mean BGR pixel
mean_pix = [104.00698793, 116.66876762, 122.67891434];


IMG_BACTH=100;

DIR='images/';

files=dir(DIR);

loop=length(files);

Img=zeros([CROP_DIM CROP_DIM 3 ((loop-2)*12)]);

index=0;

pt = randperm((loop-2));

%RANGE is set to 20% 
RANGE=ceil((loop-2)/5);

test_index=zeros(RANGE,1);
pp=1;

for i=1:pt
   if(i>=1 && i<=RANGE)
      test_index(pp)=pt(i);
      pp=pp+1;
   end
    
end

Sorted_index= sort(test_index);

DIR2='test/img/';

%loop first 10
for p=3:loop
    p-2
    TEST=0;
    for tt=1:RANGE
        if((p-2) == test_index(tt))
            TEST=1; 
            name=files(p).name;
            token = strtok(name,'.');
    
            ss = DIR;
            PATH = strcat(ss,name);
     
            im=imread(PATH);
    
            ss = DIR2;
            PATH = strcat(ss,name);
            
            imwrite(im,PATH,'jpg');
            
            %NOW save the mask 
            DIR_mask='masks/';
            filesM=dir(DIR_mask);
            
            nameM=filesM(p).name;
    
            ssM = DIR_mask;
            PATH = strcat(ssM,nameM);
    
            load(PATH);
            DIRM='test/masks/';
            ss = DIRM;
            PATH = strcat(ss,nameM);
            
            save(PATH,'MM');
            
        end
    end
  
    
DIR3='train/img/';
    
    %save as TRAIN
    if(TEST==0)
            name=files(p).name;
            token = strtok(name,'.');
    
            ss = DIR;
            PATH = strcat(ss,name);
            im=imread(PATH);
            
            ss = DIR3;
            PATH = strcat(ss,name);
            
            imwrite(im,PATH,'jpg');
            
            %NOW save the mask 
            DIR_mask='masks/';
            filesM=dir(DIR_mask);
            
            nameM=filesM(p).name;
    
            ssM = DIR_mask;
            PATH = strcat(ssM,nameM);
    
            MM=load(PATH);
            DIRM='train/masks/';
            ss = DIRM;
            PATH = strcat(ss,nameM);
            
            save(PATH,'MM');
            
            
    end

    

       
end

