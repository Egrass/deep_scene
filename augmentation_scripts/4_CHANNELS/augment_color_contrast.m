function image = augment_color_contrast(im)
% augment-function for color and contrast
%   
%CONTRAST WAS TURN OFF 

    % change to hsv
    hsv = rgb2hsv(im);
    % values used for every pixel
    s = 0.25 + (3.75)*rand;
    v = 0.25 + (3.75)*rand;
    addH = -0.1 + (0.2)*rand;
    for i=1:size(hsv,1)
        for j=1:size(hsv,2)
            % random factors for S and V
            factorS = 0.8 + (0.4)*rand;
            factorV = 0.8 + (0.4)*rand;
            addS = -0.05 + (0.1)*rand;
            addV = -0.05 + (0.1)*rand;
            % change color
            hsv(i,j,1) = hsv(i,j,1) + addH;
            if(hsv(i,j,1)>1) hsv(i,j,1) = hsv(i,j,1) - 1;
            end
            if(hsv(i,j,1)<0) hsv(i,j,1) = hsv(i,j,1) + 1;
            end
            % change contrast
            %hsv(i,j,2) = hsv(i,j,2) * s * factorS + addS;
            %hsv(i,j,3) = hsv(i,j,3) * v * factorV + addV;           
        end
    end
    
    % change to rgb again
    image = uint8(255*hsv2rgb(hsv)); 


end

