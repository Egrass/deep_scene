

clear all;
close all;

DIR='masks/';

DIR2='images/';

files2=dir(DIR2);

loop2=length(files2);

for p=3:round(loop2)
    p-2
    close all;
    
       
    name=files2(p).name;
    token = strtok(name,'.');
    ss = DIR2;
    PATH = strcat(ss,name);

         I2=imread(PATH);
         figure;
         imagesc(I2);

         %Convert RGB to mask
         I=RGB2Mask(I2);
         figure;
         imagesc(I);


        %%RUN REFINEMENT
          C=Filter(I);
          figure;
          imagesc(C);

        %%%% CONVERT BACK TO RGB  
         RGB=Mask2RGB(C);
     %    figure;
     %    imshow(RGB);

         
       %%Write image
       ss = DIR;
    %PATH = strcat(ss,name);
    ext='.png';
    PATH = strcat(ss,token);
    PATH = strcat(PATH,ext);
    
            
    imwrite(RGB,PATH,'png');

         
 
end 
 