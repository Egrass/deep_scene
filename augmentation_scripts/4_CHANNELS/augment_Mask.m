function mask = augment_Mask(ma, angle, scaleFactor)
% augments the mask
%   scaled and rotated

FINAL_DIM = 300;
preangle = -10;

    
    mask = imresize(ma, scaleFactor, 'nearest');
    mask = imrotate(mask, preangle + angle);
    [row columm numberOfChannels] = size(mask);
    
    %if(row < 301) 
        mask = imresize(mask, [300 300], 'nearest');
    %else
    %    mask = imcrop(mask, [(row-FINAL_DIM)/2 (columm-FINAL_DIM)/2 FINAL_DIM-1 FINAL_DIM-1]);
    %end
    
    
end

