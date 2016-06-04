
disp('Start ....... ');
%%create small datasets

ppp=100


NETNAME = 'v57';
nFiles=20;
nAugmentedImages = round((round((loop-2))*(aug_num))/nFiles);
%nAugmentedImages=1000;

index=1;
 for fi=21:(nFiles+20)
  
  if(index+nAugmentedImages > (round((loop-2))*(aug_num)))
   indexBegin=index;
   indexEnd=(round((loop-2))*(aug_num)); 
  else
     indexBegin=index 
     indexEnd=index+nAugmentedImages
  end
  index=index+nAugmentedImages
  
  clearvars augData;
  clearvars augLabels;
      
  
  augData   = single(data_caffe(:,:,:,indexBegin:indexEnd));
  augLabels = single(labels_caffe(:,:,:,indexBegin:indexEnd));
  %augLabels2 = single(labels_caffe2(:,:,:,indexBegin:indexEnd));
  %augLabels3 = single(labels_caffe3(:,:,:,indexBegin:indexEnd));
  
    
            disp('Creating randomly transformed image ');


   hdf5write( ['aug_deformed_' NETNAME '_file' num2str(fi) '.h5'], ...
                         'data', augData, ...
                         'label', augLabels);
                       %  'label1', augLabels2, ...
                       %  'label2', augLabels3);
    
  
 end
 

 system(['echo aug_deformed_' NETNAME '_file*.h5 > aug_deformed_' ...
                NETNAME '.txt'])
