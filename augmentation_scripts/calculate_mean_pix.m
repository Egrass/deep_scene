clear all;
close all;

IMAGE_DIM=300;
FINAL_DIM = 300;
% mean BGR pixel


imaDIR='/home/valada/test/nrg/';
imafiles=dir(imaDIR);
loop=length(imafiles);
display(loop);
blue = 0;
green = 0;
red = 0;

index=0;

%loop first 10
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
    
    
    for i = 1:IMAGE_DIM
        for j = 1:IMAGE_DIM
            blue = blue + ima(i,j,3);
            green = green + ima(i,j,2);
            red = red + ima(i,j,1);
        end
    end
    
end
cur = IMAGE_DIM*IMAGE_DIM*(loop-2);
BLUE = blue/cur;
GREEN = green/cur;
RED = red/cur;


    
    