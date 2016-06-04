clear all;
close all;

% some global variables:
IMAGE_DIM=350;
FINAL_DIM = 300;
aug_num = 10;
NETNAME = 'v31';

% mean BGR pixel
%mean_pix = [104.00698793, 116.66876762, 122.67891434];
%mean_pix_50 = [128.9595, 132.0086, 153.0701];

% this is used:
mean_pix_200 = [132.0989, 138.2469, 156.8581];

% image directory
imaDIR='images/';
imafiles=dir(imaDIR);

% calculation of the loop
loop=length(imafiles);
display(loop);

% masks directory
DIR='masks/';
files=dir(DIR);

loop = 4;
index=1;


for p=3:loop
    p-2
    
    %%%%%%%%%%%% Image part
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    name=imafiles(p).name;
    token = strtok(name,'.');
    ss = imaDIR;
    PATH = strcat(ss,name);
    
    ima=imread(PATH);

    ima = single(ima); 
    % resize to fixed input size
    ima = imresize(ima, [IMAGE_DIM IMAGE_DIM], 'bilinear');
    % permute from RGB to BGR (IMAGE_MEAN is already BGR)
    size(ima);
    % mean BGR pixel subtraction
    for c = 1:3
    ima(:, :, c) = ima(:, :, c) - mean_pix_200(c);
    end

    
     
    %%%%%%%%%%%%%%%%%% Mask part
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    maskname=files(p).name;
    token = strtok(maskname,'.');
    ssmask = DIR;
    PATH = strcat(ssmask,maskname);
    
    maskfile=imread(PATH);
    
    PartMAsk = RGB2Mask(maskfile);
    
    mask = single(PartMAsk);
    mask = imresize(mask, [IMAGE_DIM IMAGE_DIM],'nearest');
    size(mask);  
 

    %%%%%%%%%%%%%%%%% augmentation part
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    for i = 1:aug_num
        
            % random scale and angle factor are calculated and given to the
            % augment-functions
            scaleFactor = 0.7 + round((0.5)*rand, 2);
            angle = rand*20;
            finImage = augment(ima, angle, scaleFactor);
            
            augData = single(finImage);
            
            finMask = augment_Mask(mask, angle, scaleFactor);
            
            augLabels = single(finMask);
            

	    % writing of hdf5-files 
            hdf5write( ['aug_deformed_' NETNAME '_file' num2str(index) '.h5'], ...
                        'data', augData, ...
                        'label', augLabels);
            
            index = index +1;
            clearvars augData;
            clearvars augLabels;
    end

           

end


  

% writing the txt-file

 p = randperm((loop-2)*aug_num);
 ss = 'aug_deformed_';
 
 txt = '.txt';
 PATH = strcat(ss,NETNAME,txt);
 
 
fileID = fopen(PATH, 'w');
for i = 1:(loop-2)*aug_num
    first = 'aug_deformed_';
    file = '_file';
    ss2 = num2str(p(i));
    bla = '.h5 ';
    PATH2 = strcat(first, NETNAME, file, ss2, bla);
    fprintf(fileID, PATH2);
    fprintf(fileID, ' ');
end
fclose(fileID);
 
 
 

 
 

