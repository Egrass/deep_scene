function im = augment(ima, angle, scaleFactor)
% augments the image
%   scaled and rotated


FINAL_DIM = 300;
preangle = -10;

    
    im = imresize(ima, scaleFactor, 'bilinear');
    im = imrotate(im, preangle + angle);
    [row columm numberOfChannels] = size(im);
    
    if(row < 301) 
        im = imresize(im, [300 300], 'bilinear');
    else
        im = imcrop(im, [(row-FINAL_DIM)/2 (columm-FINAL_DIM)/2 FINAL_DIM-1 FINAL_DIM-1]);
    end
    
end
    





