
function img=resizeImage(M,IMAGE_SIZE,i) 


%%if i==0 then is image, otherwise is label map

if i==0

                if(size(M,2)>=size(M,1))
                   stride= (size(M,2) - size(M,1))/2;
                   padcamR = padarray(M(:,:,1),[ceil(stride) 0],'both');
                   padcamG = padarray(M(:,:,2),[ceil(stride) 0],'both');
                   padcamB = padarray(M(:,:,3),[ceil(stride) 0],'both');
                   ii(:,:,1)=padcamR; ii(:,:,2)=padcamG; ii(:,:,3)=padcamB;
                   J2 = imresize(ii, [IMAGE_SIZE IMAGE_SIZE],'nearest');
                end

                if(size(M,1)>=size(M,2))
                   stride= (size(M,1) - size(M,2))/2;
                   padcamR = padarray(M(:,:,1),[0 ceil(stride)],'both');
                   padcamG = padarray(M(:,:,2),[0 ceil(stride)],'both');
                   padcamB = padarray(M(:,:,3),[0 ceil(stride)],'both');                   
                   ii(:,:,1)=padcamR; ii(:,:,2)=padcamG; ii(:,:,3)=padcamB;
                   J2 = imresize(ii, [IMAGE_SIZE IMAGE_SIZE],'nearest');
                end

end
if i==1
               if(size(M,2)>=size(M,1))
              % stride= (size(M,2) - size(M,1))/2;
              % padcam = padarray(M,[ceil(stride) 0],'both');
               J2 = imresize(M, [IMAGE_SIZE IMAGE_SIZE], 'nearest');
            end

            if(size(M,1)>=size(M,2))
              % stride= (size(M,1) - size(M,2))/2;
              % padcam = padarray(M,[0 ceil(stride)],'both');
               J2 = imresize(M, [IMAGE_SIZE IMAGE_SIZE], 'nearest');
            end
   
end

%figure;
%imagesc(J2);

img=J2;
%figure;
%imagesc(img);
end
