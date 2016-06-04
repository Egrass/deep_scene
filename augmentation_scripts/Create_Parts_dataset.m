clear all;
close all;

anno_files = './Annotations_Part/%s.mat';
examples_path = './Result';
examples_imgs = dir([examples_path, '/', '*.jpg']);
cmap = VOClabelcolormap();

pimap = part2ind();     % part index mapping
countPeople=0;
IM=0;

for ii = 1:numel(examples_imgs)
    ii
    imname = examples_imgs(ii).name;
    img = imread([examples_path, '/', imname]);
    % load annotation -- anno
    load(sprintf(anno_files, imname(1:end-4)));
    
    [cls_mask, inst_mask, part_mask] = mat2map(anno, img, pimap);
    
    % display annotation
    %figure;
    %subplot(2,2,1); imshow(img); title('Image');
    %subplot(2,2,2); imshow(cls_mask, cmap); title('Class Mask');
    %subplot(2,2,3); imshow(inst_mask, cmap); title('Instance Mask');
    %subplot(2,2,4); imshow(part_mask, cmap); title('Part Mask');
    [PartMask, isperson] = fuse_masks_5(cls_mask,part_mask);
    %[PartMask, isperson] = fuse_Keypoints(cls_mask,part_mask);
    %figure;
    %imagesc(PartMask);
    if (isperson==1)
       %create Keypoint Map
       %[KeypointMap] = KeypointCreation(PartMask,inst_mask,cls_mask);
 
       countPeople=countPeople +1;
       DIR='People_Parts_5_classes/img/'; DIR2='People_Parts_5_classes/masks/';
       %write the data into respective folders 
       P=strcat(DIR,imname);
       imwrite(img,P);
       %Now write the segmentation mask
       token = strtok(imname,'.');
       NAME=strcat(token,'.mat');
       P=strcat(DIR2,NAME);
       save(P,'PartMask','cls_mask')
       %save(P,'PartMask','cls_mask','KeypointMap')
       %IM=img; 
       %if(countPeople==32)
       %     break;
       %end
      
    end
    
    %pause;
end

%figure;
%imshow(IM);
%figure;
%imagesc(inst_mask);
%figure;
%imagesc(PartMask);

%figure;
%imagesc(PartMask);
%figure;
%imagesc(KeypointMap);

countPeople
