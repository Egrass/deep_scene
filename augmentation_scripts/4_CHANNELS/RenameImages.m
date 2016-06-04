clear all;
close all;

IMAGE_DIM=350;
CROP_DIM = 500;
% mean BGR pixel
%mean_pix = [104.00698793, 116.66876762, 122.67891434];

FINAL_DIM = [300 300];

DIR='images/';

files=dir(DIR);

loop=length(files);


index=0;

DIR2='images2/'

%loop first 10
for p=3:loop
    p-2
    
    name=files(p).name;
    token = strtok(name,'_');
        
    
    ss = DIR;
    PATH = strcat(ss,name);
    
    im=imread(PATH);

    I = imresize(im, [FINAL_DIM(1) FINAL_DIM(2)]);

    ss = DIR2;
    %PATH = strcat(ss,name);
    ext='.png';
    name=files(p).name;
    token = strtok(name,'.');
    token = strtok(token,'_');
    PATH = strcat(ss,token);
    PATH = strcat(PATH,ext);
    
           
    imwrite(I,PATH,'png');
     
       

end
