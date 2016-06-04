close all;
clear all;

DIR='Annotations_Part/';

files=dir(DIR);

loop=length(files);

%Img=zeros([IMAGE_SIZE IMAGE_SIZE 3 (loop-2)]);

for p=3:loop
    p

    name=files(p).name;
    token = strtok(name,'.');

    ss = DIR;
    PATH = strcat(ss,name);

    NAME=strcat(token,'.jpg');
    
    %im=imread(PATH);

    %im = prepare_imageV2(im,mean_pix,IMAGE_SIZE);

    %change columns to rows
    %im(:,:,1)=im(:,:,1)';
    %im(:,:,2)=im(:,:,2)';
    %im(:,:,3)=im(:,:,3)';

    %im = im(:,:,[3 2 1]);

    %Img(:,:,:,p-2)=im;
    
        DIR2='JPEGImages/';

        files2=dir(DIR2);

        loop2=length(files2);

        parfor t=3:loop2
            t;

            name=files2(t).name;
            token2 = strtok(name,'.');
            
            tf = strcmp(token,token2);
            
            P=strcat('Result/',name);
            
            
            if(tf == 1)
                ss = DIR2;
                PATH2 = strcat(ss,name);
                im=imread(PATH2);
                imwrite(im,P);
            end
        end


end
