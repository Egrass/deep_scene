%this function return the BGR 3 channel mean value for images--jing
% Do we need to crop the image before we get the mean value
function img_mean =calculate_mean_pix(DIR,origin_imgs, image_dim,final_dim)

IMAGE_DIM=image_dim;
FINAL_DIM=final_dim;
%IMAGE_DIM=300;
%FINAL_DIM = 300;
% mean BGR pixel


%imaDIR='/home/valada/test/nrg/';
%DIR_DATASET='/home/valada/test/nrg/
DIR_DATASET=DIR;

%origin_imgs=dir(DIR_DATASET);
imgs_num=length(origin_imgs);
display(imgs_num);
blue = 0;
green = 0;
red = 0;

index=0;

%loop first 10
% image 1-(loop-2)--jing
for p=1:imgs_num        

    origin_img_name = origin_imgs(p).name;
    PATH_org_img = strcat(DIR_DATASET,origin_img_name);    
    origin_img = imread(PATH_org_img);
    origin_img = single(origin_img); 
    
    % resize to fixed input size, here why is not final_dim
    % origin_img = imresize(origin_img, [FINAL_DIM FINAL_DIM], 'bilinear');
    origin_img = imresize(origin_img, [FINAL_DIM FINAL_DIM], 'bilinear');
    % permute from RGB to BGR (IMAGE_MEAN is already BGR)
    % why size?
    size(origin_img);    
    
    for i = 1:FINAL_DIM
        for j = 1:FINAL_DIM
            blue = blue + origin_img(i,j,3);
            green = green + origin_img(i,j,2);
            red = red + origin_img(i,j,1);
        end
    end
    
end
cur = FINAL_DIM*FINAL_DIM*(imgs_num);
BLUE = blue/cur;
GREEN = green/cur;
RED = red/cur;

img_mean=[BLUE GREEN RED];

    
    